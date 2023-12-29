/*
 * Mandelbrot CPU Animator
 *
 * Creates a Mandelbrot animation and displays it on
 * the LT24 display. The animation can benefit from
 * NEON optimisation.
 *
 *  Created on: 05 March 2018
 */

#include "DE1SoC_LT24/DE1SoC_LT24.h"
#include "HPS_Watchdog/HPS_Watchdog.h"

// You can adjust these limits to zoom in to different regions of the Mandelbrot.
// If you zoom in, MAX_ITERATIONS may need to be increased.
#define MAX_ITERATIONS       64
#define MANDELBROT_XCENTRE  -0.75f
#define MANDELBROT_YCENTRE   0.0f
#define MANDELBROT_RADIUS    2.6f


//These don't need changing
#define MANDELBROT_YSIZE(RADIUS) (RADIUS * 2.0f)                              //Narrowest dimension is twice radius
#define MANDELBROT_XSIZE(RADIUS) (((RADIUS * 2.0f) * LT24_HEIGHT)/LT24_WIDTH) //Larger dimension is scaled proportionally

#define MANDELBROT_XMIN(XSIZE, XCENTRE)  (XCENTRE - (XSIZE/2))
#define MANDELBROT_YMIN(YSIZE, YCENTRE)  (YCENTRE - (YSIZE/2))

#define MANDELBROT_MAG   2.0f

//Simple square macro.
#define SQR(x) ((x) * (x)) //x^2

//
//Function to encode a single seven-segment digit
//
unsigned int sevenSegDigitEncode(unsigned int value) {
    //Create lookup table of 7-seg values
    unsigned int encoder[18] = {0x3F,0x6,0x5B,0x4F,0x66,0x6D,0x7D,0x7,0x7F,0x6F,0x77,0x7C,0x39,0x5E,0x79,0x71,0x40,0x0};
    //Limit range of input. 18 or higher will display a ' ' indicating unknown value. 17 is a '-' sign.
    if (value > 18) value = 18;
    //Convert the number to 7-seg.
    return encoder[value];
}

//
//Function to display BCD value on seven segment displays.
//
void sevenSegDisplayBCD(unsigned int value) {
    //7-Seg base addresses
    volatile int * HEX3to0_ptr = (int *) 0xFF200020;
    volatile int * HEX5to4_ptr = (int *) 0xFF200030;
    //Converted digit store
    unsigned char digits[8] = {0}; //assume blank displays initially.
    unsigned int* displays = (unsigned int*)digits; //Map digits into the two display banks.
    //Encode Digits
    unsigned int i;
    digits[0] = sevenSegDigitEncode(value % 10); //Encode digit 0 separately as this will always show
    for (i = 1; i < 6; i++) {
        value = value/10; //Divide by 10 to move next digit down.
        if (value == 0) {
            break; //If value is zero, we are done
        }
        digits[i] = sevenSegDigitEncode(value % 10); //Encode next digit
    }
    // drive the hex displays
    *HEX3to0_ptr = displays[0];
    *HEX5to4_ptr = displays[1];
}

//
// Main Function
//
int main()
{
    //
    // Colour Map for output
    //
    unsigned short colourMap[32] = {0x0008,0x012C,0x0271,0x0396,0x04DB,0x061F,0x157C,0x2CFA,
                                    0x4457,0x5BD4,0x7351,0x8AAE,0xA22B,0xB9A8,0xD105,0xE082,
                                    0xF800,0xF8C0,0xF980,0xFA40,0xFB00,0xFBC0,0xFC80,0xFD40,
                                    0xFE00,0xDD41,0xBC82,0x9BC3,0x7B04,0x5A45,0x3986,0x18C7
    };
    //
    // Mandelbrot Calculation Variables
    //
    float yn[LT24_HEIGHT][LT24_WIDTH] = {0.0f}; //Buffers for storing value of each pixel from previous iteration
    float xn[LT24_HEIGHT][LT24_WIDTH] = {0.0f};
    unsigned int px = 0; //Current pixel coordinate for vector looping
    unsigned int py = 0;
    int iteration;  //Current iteration number
    unsigned short iterations[LT24_HEIGHT][LT24_WIDTH] = {0}; //Iteration count for each pixel

    //
    // Frame Buffer Variables
    //
    unsigned int pixel; //Current pixel for frame buffer looping
    unsigned short frameBuffer[LT24_WIDTH * LT24_HEIGHT]; //Frame buffer data

    //
    //Initialisation
    //
    HPS_ResetWatchdog();
    //Initialise LCD
    LT24_initialise(0xFF200060,0xFF200080); //Turn on LCD
    HPS_ResetWatchdog();
    
    //
    // Mandelbrot Calculation Loop
    //
    for (iteration = 1; iteration <= MAX_ITERATIONS; iteration++) {
        
        // <<< Time Execution From Here >>>
        
        //For each iteration:
        for (px = 0; px < LT24_HEIGHT; px++) {  //NOTE: WIDTH/HEIGHT are swapped around to force display to be landscape.
            //For each X coordinate:
            for (py = 0; py < LT24_WIDTH; py++) { //NOTE: We do the Y as the inner loop because it is the inner-most index (i.e. [outer][inner]).
                //For each Y coordinate:
                //Map X-Y coordinate linearly into Mandelbrot set range
                float x0 = (float)px * MANDELBROT_XSIZE(MANDELBROT_RADIUS)/LT24_HEIGHT +
                                       MANDELBROT_XMIN(MANDELBROT_XSIZE(MANDELBROT_RADIUS), MANDELBROT_XCENTRE);
                float y0 = (float)py * MANDELBROT_YSIZE(MANDELBROT_RADIUS)/LT24_WIDTH +
                                       MANDELBROT_YMIN(MANDELBROT_YSIZE(MANDELBROT_RADIUS), MANDELBROT_YCENTRE);
                //Calculate number of iterations required to escape limit, or stop when maximum allowed reached
                float xnm1 = xn[px][py];
                float ynm1 = yn[px][py];
                xn[px][py] = (    SQR(xnm1) - SQR(ynm1)) + x0; //Xn+1 = Real((Xn+iYn)^2) + X0 = Xn^2 - Yn^2 + X0
                yn[px][py] = (2 *     xnm1  *     ynm1 ) + y0; //Yn+1 = Imz ((Xn+iYn)^2) + Y0 = 2XnYn + Y0
            }
            //Calculate if another iteration is needed
            //We do this in a seperate loop to help vectorisation because iterations and yn/yx are different bit widths
            for (py = 0; py < LT24_WIDTH; py++) {
                //For each pixel, check if the result has not exceeded our preset magnitude.
                if ((SQR(xn[px][py]) + SQR(yn[px][py])) < SQR(MANDELBROT_MAG)) {
                    //If we are still in range, another iteration is needed
                    iterations[px][py] = iterations[px][py] + 1;
                } //Otherwise no iteration is needed
            }
        }
        //Reset watchdog
        HPS_ResetWatchdog();
        //Map the iterations on to a display colour
        for (pixel = 0; pixel < (LT24_WIDTH * LT24_HEIGHT); pixel++) {
            unsigned short* iterationsPtr = &iterations[0][0];  //Pointer to iteration count array
            unsigned int colourIdx = iterationsPtr[pixel] % 32;
            frameBuffer[pixel] = colourMap[colourIdx];
        }        
        //Display result
        LT24_copyFrameBuffer(frameBuffer,0,0,LT24_WIDTH,LT24_HEIGHT);
        //Indicate current iteration on 7-Segs
        sevenSegDisplayBCD(iteration);
        
        // <<< Time Execution To Here >>>
    }

    //
    //Finished
    //
    while(1) {
        HPS_ResetWatchdog();
    }
}
