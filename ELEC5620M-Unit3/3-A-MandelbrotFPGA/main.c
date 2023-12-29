/*
 * Mandelbrot FPGA Animator
 *
 * Creates a Mandelbrot animation and displays it on
 * the LT24 display. The animation benefits from a
 * dedicated FPGA hardware co-processor.
 *
 *  Created on: 05 March 2018
 */

#include "DE1SoC_LT24/DE1SoC_LT24.h"
#include "DE1SoC_Mandelbrot/DE1SoC_Mandelbrot.h"
#include "HPS_Watchdog/HPS_Watchdog.h"
#include "HPS_usleep/HPS_usleep.h"

// You can adjust these limits to zoom in to different regions of the Mandelbrot.
// If you zoom in, MAX_ITERATIONS may need to be increased.
#define MAX_ITERATIONS       64
#define MANDELBROT_XCENTRE  -0.75f
#define MANDELBROT_YCENTRE   0.00f
#define MANDELBROT_RADIUS    2.60f

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
    int iteration;  //Current iteration number

    //
    //Initialisation (Note, error checking omitted for brevity).
    //
    //Initialise LCD
    LT24_initialise(0xFF200060,0xFF200080); //Turn on LCD
    HPS_ResetWatchdog();
    //Initialise Mandelbrot
    Mandelbrot_initialise(0xFF200090);
    HPS_ResetWatchdog();
    //Wait for screen to refresh.
    usleep(200000);
    //Restart Mandelbrot Calculation
    Mandelbrot_resetPattern();
    HPS_ResetWatchdog();
    //Set Coordinates
    Mandelbrot_setCoordinates(MANDELBROT_RADIUS, MANDELBROT_XCENTRE, MANDELBROT_YCENTRE);
    HPS_ResetWatchdog();
    //
    // Mandelbrot Calculation Loop
    //
    for (iteration = 1; iteration <= MAX_ITERATIONS; iteration++) {
        
        // <<< Time Execution From Here >>>

        //Start Iteration
        Mandelbrot_startIteration();
        //Wait for iteration to complete
        while(Mandelbrot_iterationDone() != MANDELBROT_SUCCESS);
        //Reset watchdog
        HPS_ResetWatchdog();
        //Indicate current iteration on 7-Segs
        sevenSegDisplayBCD(Mandelbrot_currentIteration());
                
        // <<< Time Execution To Here >>>
    }

    //
    //Finished
    //
    while(1) {
        HPS_ResetWatchdog();
    }
}
