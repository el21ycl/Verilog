/*
 * main.c
 * Created on: 2022Äê3ÔÂ19ÈÕ
 *      Author: Yucheng lin
 *  It is a Stopwatch
 */
#include "DE1SoC_SevenSeg/DE1SoC_SevenSeg.h"
#include "Stopwatch_PrivateTimer/Stopwatch_PrivateTimer.h"
#include "HPS_Watchdog/HPS_Watchdog.h"


#include <stdlib.h>
  /* Pointers to peripherals */
    // Red LEDs base address
    volatile unsigned int *LEDR_ptr = (unsigned int *) 0xFF200000;
// Peripheral base addresses.
    volatile unsigned int *key_ptr = (unsigned int *)0xFF200050;
    // Select which displays to use
    //mm:ss:ff or hh:mm:ss
    #define ff_DISPLAY_LOCATION 0
    #define ss_DISPLAY_LOCATION 2
    #define mm_DISPLAY_LOCATION 4

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

/************** Key module **************/
// Store the state of the keys last time we checked.
// This allows us to determine when a key is pressed, then released.
unsigned int key_last_state = 0;
/**
 * getPressedKeys
 *
 * Helper function to determine which keys have been pressed
 * and then released later.
 *
 * Arguments:
 * 		key_last_state: 	4-value array of the last state of each key.
 *
 * Returns: Mask, 1 for keys which have been pressed, 0 for keys not.
 */
unsigned int getPressedKeys() {

    // Store the current state of the keys.
    unsigned int key_current_state = *key_ptr;

    // If the key was down last cycle, and is up now, mark as pressed.
    unsigned int keys_pressed = (~key_current_state) & (key_last_state);

    // Save the key state for next time, so we can compare the next state to this.
    key_last_state = key_current_state;

    // Return result.
    return keys_pressed;
}

int main(void) {
	 // Corresponding value set to 1 when a key is pressed then released.
	 unsigned int keys_pressed = 0;
     // Initial value of each display output.
	 unsigned int ff_display_value = 0; // Set hundredth of seconds
	 unsigned int ss_display_value = 30; // Set seconds
	 unsigned int mm_display_value = 59; // Set minutes
	 unsigned int hh_display_value = 23; // Set hours
	 unsigned int start = 0;
	 Private_Timer();
     // Set displays to have initial values.
     DE1SoC_SevenSeg_SetDoubleDec(ff_DISPLAY_LOCATION, ff_display_value);
     DE1SoC_SevenSeg_SetDoubleDec(ss_DISPLAY_LOCATION, ss_display_value);
     DE1SoC_SevenSeg_SetDoubleDec(mm_DISPLAY_LOCATION, mm_display_value);

   while(1){
	       keys_pressed = getPressedKeys();
	   while(!(Timer_interrupt(false) & 0x1)) HPS_ResetWatchdog(); // Use Blocking module
	           // Clear the timer interrupt flag. We do this by writing 1 to the F bit,
	           // which counter-intuitively informs the hardware to set the flag to set to 0
	          Timer_interrupt(true);
	   	   // Check if any buttons have been pressed and released.
	   	   // The keys_pressed variable will need to be bit masked to determine if a
	   	   // specific key was pressed.
	   	   // Test if each key has been pressed in turn, carry out action if so.
	   	   if (keys_pressed & 0x1) { // Enter Key_0 to start the stopwatch
	   		    start = 1;
	   	   }
           if (keys_pressed & 0x2){  // Enter Key_1 to stop the stopwatch
        	   start = 0;
           }
           if ((keys_pressed & 0x4) | hh_display_value >= 24 ){  // Enter Key_2 to reset the stopwatch
        	   start = 0;
        	   ss_display_value = 0;
        	   ff_display_value = 0;
        	   mm_display_value = 0;
        	   hh_display_value = 0;
           }
           if (start == 1){
           	 ff_display_value++;
           	     if (ff_display_value >= 100){ // If hundredth of a second is greater than 100, the second advance is +1
           	         ff_display_value = 0;
           	         ss_display_value++;
           	        if (ss_display_value >= 60){ // If second is greater than 60, the minute advance is +1
           	           ss_display_value = 0;
           	           mm_display_value++;
           	          if (mm_display_value >= 60){  // If minute is greater than 60, the hours advance is +1
           	             mm_display_value = 0;
           	             hh_display_value++;
           	          }
           	        }
           	     }
           	}
           //mm:ss:ff
           if (hh_display_value == 0){
		   DE1SoC_SevenSeg_SetDoubleDec(ff_DISPLAY_LOCATION, ff_display_value); //Display hundredth of seconds
           DE1SoC_SevenSeg_SetDoubleDec(ss_DISPLAY_LOCATION, ss_display_value); //Display seconds
           DE1SoC_SevenSeg_SetDoubleDec(mm_DISPLAY_LOCATION, mm_display_value); //Display minutes
           }
           //hh:mm:ss
           else {
    	   DE1SoC_SevenSeg_SetDoubleDec(ff_DISPLAY_LOCATION, ss_display_value); //Display seconds
           DE1SoC_SevenSeg_SetDoubleDec(ss_DISPLAY_LOCATION, mm_display_value); //Display minutes
           DE1SoC_SevenSeg_SetDoubleDec(mm_DISPLAY_LOCATION, hh_display_value); //Display hours
           }
   }
// Finally, reset the watchdog timer.
      HPS_ResetWatchdog();
}
