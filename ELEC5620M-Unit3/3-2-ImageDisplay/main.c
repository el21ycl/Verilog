/*
 * DE1-SoC LT24 Example
 *
 * Displays a test pattern on the LT24
 * LCD using the LT24 bare metal driver.
 *
 *  Created on: 09 Feb 2018
 */

#include "DE1SoC_LT24/DE1SoC_LT24.h"
#include "PrivateTimer/PrivateTimer.h"
#include "HPS_Watchdog/HPS_Watchdog.h"
#include "HPS_usleep/HPS_usleep.h"

//Include our image
#include "Test.h"

//Debugging Function (same as last lab)
#include <stdlib.h>
void exitOnFail(signed int status, signed int successStatus){
    if (status != successStatus) {
        exit((int)status); //Add breakpoint here to catch failure
    }
}

//--------------------------------------------------------------------
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
//----------------------------------------------------------------------

//
// Main Function
// =============
int main(void) {
/*	unsigned int imageIdx = 0;
	const unsigned int images[4] =
		    {Test,Test_P,Tic_Tac_Toe,Test_Pball};
*/	Private_Timer();
    //Initialise the LCD Display.
    exitOnFail(
            LT24_initialise(0xFF200060,0xFF200080), //Initialise LCD
            LT24_SUCCESS);                          //Exit if not successful
    HPS_ResetWatchdog();
    //Display the image. Setting the co-ordinates and size of the image.
/*    exitOnFail(
                LT24_copyFrameBuffer(Test,0,0,240,320),
                LT24_SUCCESS); //Exit if not successful
        usleep(1000000);
             HPS_ResetWatchdog();
        exitOnFail(
                    LT24_copyFrameBuffer(Test_P,0,0,240,320),
                    LT24_SUCCESS); //Exit if not successful
        usleep(1000000);
                HPS_ResetWatchdog();
*/
    //Main Run Loop
    while (1) {
 /*   	       LT24_copyFrameBuffer(images[imageIdx],0,0,240,320);
    	       imageIdx++;
			   if (imageIdx >= 4) {
				   imageIdx = 0;
			          }
*/
    	exitOnFail(
    	            LT24_copyFrameBuffer(Test,0,0,240,320),
    	            LT24_SUCCESS); //Exit if not successful
    	    usleep(500000);
    	         HPS_ResetWatchdog();
    	    exitOnFail(
    	                LT24_copyFrameBuffer(Test_P,0,0,240,320),
    	                LT24_SUCCESS); //Exit if not successful
    	    usleep(500000);
    	            HPS_ResetWatchdog();
    	HPS_ResetWatchdog(); //Just reset the watchdog.
    }
}
