/*
 * main.c
 *
 *  Created on: 2022Äê5ÔÂ11ÈÕ
 *      Author: Yucheng Lin
 */

#include "DE1SoC_LT24/DE1SoC_LT24.h"
#include "HPS_Watchdog/HPS_Watchdog.h"
#include "HPS_usleep/HPS_usleep.h"

//Include our image
#include "Image/Image.h"

//Debugging Function
#include <stdlib.h>
void exitOnFail(signed int status, signed int successStatus){
    if (status != successStatus) {
        exit((int)status); //Add breakpoint here to catch failure
    }
}

  /* Pointers to peripherals */

// Peripheral base addresses.
    volatile unsigned int *key_ptr = (unsigned int *)0xFF200050;    // KEYS 0-3 (push buttons)
    volatile unsigned int *LEDR_ptr = (unsigned int *)0xFF200000; // Red LEDs base address
    volatile unsigned int *switch_ptr = (unsigned int *)0xFF200040; // 0-9 Switches base address



/************** Key module **************/
unsigned int key_last_state = 0;
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

unsigned int switch_last_state = 0;
unsigned int getPressedswitch() {

    // Store the current state of the switches.
    unsigned int switch_current_state = *switch_ptr;

    // If the key was down last cycle, and is up now, mark as pressed.
    unsigned int switch_pressed = (switch_current_state) & (~switch_last_state);

    if (switch_current_state != switch_last_state){
    // Save the key state for next time, so we can compare the next state to this.
    switch_last_state = switch_current_state;
    }
    // Return result.
    return switch_pressed;
}

unsigned int P1_o (int s) {
	// Record which are the circles
	unsigned int R_o = 0;
	// When Switch_0 is turned on draw a circle at the 0 position
	if (s==0x1){
		R_o = R_o | 0x1;
		exitOnFail(
		   LT24_copyFrameBuffer(o,172,10,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
	// When Switch_1 is turned on draw a circle at the 1 position
    if (s==0x2){
    	R_o = R_o | 0x2;
		exitOnFail(
		   LT24_copyFrameBuffer(o,172,123,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // When Switch_2 is turned on draw a circle at the 2 position
    if (s==0x4){
    	R_o = R_o | 0x4;
		exitOnFail(
		   LT24_copyFrameBuffer(o,172,233,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // When Switch_3 is turned on draw a circle at the 3 position
	if (s==0x8){
		R_o = R_o | 0x8;
		exitOnFail(
		   LT24_copyFrameBuffer(o,88,10,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
	// When Switch_4 is turned on draw a circle at the 4 position
    if (s==0x10){
    	R_o = R_o | 0x10;
		exitOnFail(
		   LT24_copyFrameBuffer(o,88,123,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // When Switch_5 is turned on draw a circle at the 5 position
    if (s==0x20){
    	R_o = R_o | 0x20;
		exitOnFail(
		   LT24_copyFrameBuffer(o,88,233,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // When Switch_6 is turned on draw a circle at the 6 position
	if (s==0x40){
		R_o = R_o | 0x40;
		exitOnFail(
		   LT24_copyFrameBuffer(o,6,10,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
	// When Switch_7 is turned on draw a circle at the 7 position
    if (s==0x80){
    	R_o = R_o | 0x80;
		exitOnFail(
		   LT24_copyFrameBuffer(o,6,123,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // When Switch_8 is turned on draw a circle at the 8 position
    if (s==0x100){
    	R_o = R_o | 0x100;
		exitOnFail(
		   LT24_copyFrameBuffer(o,6,233,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // Return result.
    return R_o;
}

unsigned int P2_x (int s) {
	// Record which are the crosses
	unsigned int R_x = 0;
	// When Switch_0 is turned on draw a cross at the 0 position
	if (s==0x1){
		R_x = R_x | 0x1;
		exitOnFail(
		   LT24_copyFrameBuffer(x,172,10,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
	// When Switch_1 is turned on draw a cross at the 1 position
    if (s==0x2){
    	R_x = R_x | 0x2;
		exitOnFail(
		   LT24_copyFrameBuffer(x,172,123,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // When Switch_2 is turned on draw a cross at the 2 position
    if (s==0x4){
    	R_x = R_x | 0x4;
		exitOnFail(
		   LT24_copyFrameBuffer(x,172,233,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // When Switch_3 is turned on draw a cross at the 3 position
	if (s==0x8){
		R_x = R_x | 0x8;
		exitOnFail(
		   LT24_copyFrameBuffer(x,88,10,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
	// When Switch_4 is turned on draw a cross at the 4 position
    if (s==0x10){
    	R_x = R_x | 0x10;
		exitOnFail(
		   LT24_copyFrameBuffer(x,88,123,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // When Switch_5 is turned on draw a cross at the 5 position
    if (s==0x20){
    	R_x = R_x | 0x20;
		exitOnFail(
		   LT24_copyFrameBuffer(x,88,233,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // When Switch_6 is turned on draw a cross at the 6 position
	if (s==0x40){
		R_x = R_x | 0x40;
		exitOnFail(
		   LT24_copyFrameBuffer(x,6,10,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
	// When Switch_7 is turned on draw a cross at the 7 position
    if (s==0x80){
    	R_x = R_x | 0x80;
		exitOnFail(
		   LT24_copyFrameBuffer(x,6,123,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // When Switch_8 is turned on draw a cross at the 8 position
    if (s==0x100){
    	R_x = R_x | 0x100;
		exitOnFail(
		   LT24_copyFrameBuffer(x,6,233,60,80),
		   LT24_SUCCESS); //Exit if not successful
	}
    // Return result.
    return R_x;
}
/*
void Win (int R){
	if (R == 0x7 || R == 0x31 || R == 0x1C0 ||
        R == 0x49 || R == 0x92  || R == 0x124 ||
		R == 0x54 || R == 0x111 ){
		exitOnFail(
			LT24_copyFrameBuffer(Result,5,95,23,130),
			LT24_SUCCESS); //Exit if not successful
	}
}
*/
int main(void) {
	 // Corresponding value set to 1 when a key is pressed then released.
		 unsigned int keys_pressed = 0;
		 unsigned int switch_pressed = 0;
		 unsigned int switch_last = 0;
		 unsigned int switch_current = 0;
		 unsigned int P1 = 0;    // Determining whether Player 1 has won
		 unsigned int P2 = 0;    // Determining whether Player 2 has won
		 unsigned int T = 0;     // Judge Tie or not
		 unsigned int start = 0; // Judge started or not
		 unsigned int o = 0;     // Determine if it is Player 1's turn
		 unsigned int x = 0;     // Determine if it is Player 2's turn
		 unsigned int w = 0;     // Judge win or not
		 unsigned int R_o = 0;   // The results of circle
		 unsigned int R_x = 0;   // The results of cross
		 unsigned int R = 0;     // Sum of results
/*		 unsigned int imageIdx = 0;
		 const unsigned short* images[4] =
		 		    {Test,Test_P,Tic_Tac_Toe,Test_Pball};
*/
    //Initialise the LCD Display.
    exitOnFail(
            LT24_initialise(0xFF200060,0xFF200080), //Initialise LCD
            LT24_SUCCESS);                          //Exit if not successful
    HPS_ResetWatchdog();
    //Display the image. Setting the co-ordinates and size of the image.
    // Display the Cover of Game
       exitOnFail(
                LT24_copyFrameBuffer(Cover,0,0,240,320),
                LT24_SUCCESS); //Exit if not successful
        usleep(1000000);
             HPS_ResetWatchdog();

	  while (1) {
		  keys_pressed = getPressedKeys();
		  switch_pressed = getPressedswitch();
		  *LEDR_ptr = *switch_ptr ;
		  switch_current = *switch_ptr ;
          // Press Key_3 to start the game
		  if (keys_pressed & 0x8){
			  start = 1;
			  o = 1;
			  // Display the start of Game
			  exitOnFail(
			         LT24_copyFrameBuffer(Tic_Tac_Toe,0,0,240,320),
			         LT24_SUCCESS); //Exit if not successful
		  }
		  // Press Key_3 to reset the game
		  if (keys_pressed & 0x4){
			  start = 0;
			  switch_pressed = 0;
			  switch_last = 0;
			  switch_current = 0;
			  P1 = 0;
			  P2 = 0;
			  o = 0;
			  x = 0;
			  T = 0;
			  w = 0;
			  R_o = 0;
			  R_x = 0;
			  R = 0;
			  // Return to the cover of game
		  			  exitOnFail(
		  			         LT24_copyFrameBuffer(Cover,0,0,240,320),
		  			         LT24_SUCCESS); //Exit if not successful
		  		  }
		  if (start){
			 if (o && P1 == 0 && P2 == 0 && T == 0){
				 //count == 0 || count == 2 || count == 4 || count == 6 || count == 8
			 // If the switch is different from the previous one, you can draw a circle
			  if (switch_current != switch_last){
				  o = 0;
				  x = 1;
				  P1_o(switch_pressed);        // Determine the position of the drawing
		          R_o = R_o | switch_pressed;  // Results of the recording circle
		          switch_last = *switch_ptr;
			  }
			 }
			 else if (x && P1 == 0 && P2 == 0 && T == 0){
			 // If the switch is different from the previous one, you can draw a cross
				if(switch_current != switch_last){
				  o = 1;
				  x = 0;
			  	  P2_x(switch_pressed);       // Determine the position of the drawing
			  	  R_x = R_x | switch_pressed; // Results of the recording cross
		          switch_last = *switch_ptr;
				}
			  }
		  }
		  // The sum of  the results of circle and cross
		  R = R_o | R_x;
		  if (R >= 31 && P1 == 0 && P2 == 0 && T == 0){
			 // Determining whether Player 1 has won
             if ((R_o & 0x7) == 0x7 || (R_o & 0x38) == 0x38 || (R_o & 0x1C0) == 0x1C0 ||
            	 (R_o & 0x49) == 0x49 || (R_o & 0x92) == 0x92  || (R_o & 0x124) == 0x124 ||
				 (R_o & 0x54) == 0x54 || (R_o & 0x111) == 0x111 ){
            	 P1 = 1;
            	 w = 1;
             }
             // Determining whether Player 2 has won
		     if ((R_x & 0x7) == 0x7 || (R_x & 0x38) == 0x38 || (R_x & 0x1C0) == 0x1C0 ||
		    	 (R_x & 0x49) == 0x49 || (R_x & 0x92) == 0x92  || (R_x & 0x124) == 0x124 ||
				 (R_x & 0x54) == 0x54 || (R_x & 0x111) == 0x111 ){
		         P2 = 1;
		         w = 1;
		               }
		     // When there is no space to paint
		     if (R == 0x1FF){
		    	 w = 1;
		     }
		  }
		  // When someone wins
		  if (w == 1){
			  // Game over prompt appears
			  exitOnFail(
			  	LT24_copyFrameBuffer(Result,5,97,23,130),
			  	LT24_SUCCESS); //Exit if not successful
		  }
		  // Press Key_2 to view the results
		  if (w == 1 && (keys_pressed & 0x2)){
			  w = 0;
			  if (P1 == 1){
			   // Showing pictures of Player 1 winning
			   exitOnFail(
				  		  LT24_copyFrameBuffer(WIN_P1,0,0,240,320),
				  		  LT24_SUCCESS); //Exit if not successful
			  }
			  // Showing pictures of Player 2 winning
			  if (P2 == 1){
			   exitOnFail(
			  			  LT24_copyFrameBuffer(WIN_P2,0,0,240,320),
			  			  LT24_SUCCESS); //Exit if not successful
			  }
			  // When no one wins, the game is Tie
			  if (P1 == 0 && P2 == 0){
				  T = 1;
				  exitOnFail(
				  			 LT24_copyFrameBuffer(Tie,0,0,240,320),
				  			 LT24_SUCCESS); //Exit if not successful
			  }
		   }
		  HPS_ResetWatchdog();
		 // HPS_ResetWatchdog(); //Just reset the watchdog.
	  }
}





