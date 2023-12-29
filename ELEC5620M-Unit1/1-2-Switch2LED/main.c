/**
 * main.c
 *
 *  Created on: 12 Feb 2021
 *      Author: Harry Clegg
 *      		You
 */

// Include drivers.
// Please note the compiler will not be able to find this driver until you have
// configured the project settings as described in the Unit 1.1 Notes.
#include "HPS_Watchdog/HPS_Watchdog.h"

// ToDo: Define any peripheral base addresses here. For example:
volatile unsigned int *key_ptr = (unsigned int *)0xFF200050; // KEYS 0-3 (push buttons)

volatile unsigned int *LEDR_ptr = (unsigned int *)0xFF200000; // Red LEDs base address

volatile unsigned int *switch_ptr = (unsigned int *)0xFF200040; // 0-9 Switches base address

/**
 * main
 *
 * The entry function for this task. This function should mirror the state of
 * the 10 switches on the 10 LEDs exactly, e.g. if SW3 is high, then LED3 should
 * also be high.
 *
 * If you want, you can extend this program such that if any of the key buttons
 * (KEY 0-3) are pressed, the state of the LEDs is the inverse of the switches,
 * e.g. if SW3 is high, then LED3 should be low.
 */
void main(void) {

    // ToDo: Declare any variables you need and perform initialisation here.
    unsigned int S;
    unsigned int i = 0;

    while (1) {
        // ToDo: Implement your loop logic here.
         S = *switch_ptr & 0x3FF;
     if (*key_ptr & 0xF ){
    	i++;      // Make the LED state the inverse of the switch
    	i = i % 2;
    }
    if (i == 0){
        *LEDR_ptr = S;
    }
    else {
    	*LEDR_ptr = ~S; // When the key is pressed, the state of the LED is inverse to that of the switch
    }
        // Reset the Watchdog Timer so the processor doesn't reset.
        HPS_ResetWatchdog();
    }
}
