/*
 * DE1-SoC Audio Example
 *
 * Generates a sinusoidal tone waveform
 * Writes stereo audio to the CODEC (LINE OUT)
 *
 *  Created on: 03 Feb 2018
 */

#include "DE1SoC_WM8731/DE1SoC_WM8731.h"
#include "PrivateTimer/PrivateTimer.h"
#include "HPS_Watchdog/HPS_Watchdog.h"

//Include Floating Point Math Libraries
#include <math.h>

//Debugging Function (same as last lab)
#include <stdlib.h>
void exitOnFail(signed int status, signed int successStatus){
    if (status != successStatus) {
        exit((int)status); //Add breakpoint here to catch failure
    }
}

//Define some useful constants
#define F_SAMPLE 48000.0        //Sampling rate of WM8731 Codec (Do not change)
#define PI2      6.28318530718  //2 x Pi      (Apple or Peach?)

/************** Timer module **************/
void Private_Timer() {
	/* Initialisation */
	Timer_initialise(0xFFFEC600);
	// Set initial value of LEDs
	// Configure the ARM Private Timer
    // Set the "Load" value of the timer to any value:
	Timer_load(2000000); // set to hundredth of seconds
	//         100000000 is 0.5s!
	// Set the "Prescaler" value to 0, Enable the timer (E = 1)
	// on overflow (A = 1), and disable ISR (I = 0)
	Timer_enable(true);
	//Set Automatic reload
	Timer_ar(true);
	//Set Prescaler
	//Timer_P(0);
}

//
// Main Function
// =============
int main(void) {
    //Pointers
    volatile unsigned int*  LEDR_ptr  = (unsigned int *) 0xFF200000; // Red LEDs base address
    volatile unsigned char* fifospace_ptr;
    volatile unsigned int*  audio_left_ptr;
    volatile unsigned int*  audio_right_ptr;
    //Variables
    //Phase Accumulator
    double phase = 0.0;  // Phase accumulator
    double inc   = 0.0;  // Phase increment
    double ampl  = 0.0;  // Tone amplitude (i.e. volume)
    signed int audio_sample = 0;
    unsigned int n = 1;
    unsigned int en = 0;
    unsigned int ff_display_value = 0; // Set hundredth of seconds
    Private_Timer();
    //Initialise the Audio Codec.
    exitOnFail(
            WM8731_initialise(0xFF203040),  //Initialise Audio Codec
            WM8731_SUCCESS);                //Exit if not successful
    //Clear both FIFOs
    WM8731_clearFIFO(true,true);
    //Grab the FIFO Space and Audio Channel Pointers
    fifospace_ptr = WM8731_getFIFOSpacePtr();
    audio_left_ptr = WM8731_getLeftFIFOPtr();
    audio_right_ptr = WM8731_getRightFIFOPtr();
/*
    //Initialise Phase Accumulator
*/    inc   = 440.0 * PI2 / F_SAMPLE;  // Calculate the phase increment based on desired frequency - e.g. 440Hz
    // Volume adjustment
    ampl  = 8388608.0;               // Pick desired amplitude (e.g. 2^23). WARNING: If too high = deafening!
    phase = 0.0;

    // Primary function while loop
    while (1) {
    	//Initialise Phase Accumulator
    	while(!(Timer_interrupt(false) & 0x1)) HPS_ResetWatchdog(); // Use Blocking module
    	   // Clear the timer interrupt flag. We do this by writing 1 to the F bit,
    	   // which counter-intuitively informs the hardware to set the flag to set to 0
    	   Timer_interrupt(true);
    	    ff_display_value++;
    	if (ff_display_value >= 100){
   	     n++;
   	     ff_display_value = 0;
   	  //Always check the FIFO Space before writing or reading left/right channel pointers
   	      	    	        if ((fifospace_ptr[2] > 0) && (fifospace_ptr[3] > 0)) {
   	      	    	            //If there is space in the write FIFO for both channels:
   	      	    	            //Increment the phase
   	      	    	            phase = phase + ((40.0+100.0*n) * PI2 / F_SAMPLE);
   	      	    	            //Ensure phase is wrapped to range 0 to 2Pi (range of sin function)
   	      	    	            while (phase >= PI2) {
   	      	    	                phase = phase - PI2;
   	      	    	            }
   	      	    	            // Calculate next sample of the output tone.
   	      	    	            audio_sample = (signed int)( ampl * sin( phase ) );
   	      	    	            // Output tone to left and right channels.
   	      	    	            *audio_left_ptr = audio_sample;
   	      	    	            *audio_right_ptr = audio_sample;
   	      	    	        }
   	      	    	        //Debugging - display FIFO space on red LEDs.
   	      	    	        *LEDR_ptr = fifospace_ptr[2];  // Output 'WSRC' register to the red LEDs.
   	      	    	        //Finally reset the watchdog.
   	      	    	       // HPS_ResetWatchdog();
   	      	    	    //}
    	}
   	    if(n > 8){
   	     n=1;
   	       }
/*   	 if (n == 1){
   		 en = 0;
   	 }
   	 else if (n > 6){
   		 en = 1;
   	 }
     if(en == 0){
    	 n++;
     }
     if(en == 1){
    	 n--;
     }*/
    }
    // Finally, reset the watchdog timer.
          HPS_ResetWatchdog();
}
