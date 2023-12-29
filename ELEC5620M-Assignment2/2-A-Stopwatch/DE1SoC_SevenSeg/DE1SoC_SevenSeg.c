/*
 * DE1SoC_SevenSeg.c
 *
 */

#include "DE1SoC_SevenSeg.h"

// ToDo: Add the base addresses of the seven segment display peripherals.
volatile unsigned char *sevenseg_base_lo_ptr = (unsigned char *)0xFF200020;
volatile unsigned char *sevenseg_base_hi_ptr = (unsigned char *)0xFF200030;

unsigned char LED[] = {0x3F,  //0 0111111
		               0x6,   //1 0000110
					   0x5B,  //2 1011011
					   0x4F,  //3 1001111
					   0x66,  //4 1100110
					   0x6D,  //5 1101101
					   0x7D,  //6 1111101
					   0x7,   //7 0000111
					   0x7F,  //8 1111111
					   0x67,  //9 1100111
					   0x77,  //A 1110111
					   0x7C,  //B 1111100
					   0x39,  //C 0111001
					   0x5E,  //D 1011110
					   0x79,  //E 1111001
					   0x71,  //F 1110001
					   0x40}; //dash 1000000
unsigned char single = 0;
unsigned char ten = 0;

// There are four HEX displays attached to the low (first) address.
#define SEVENSEG_N_DISPLAYS_LO 4

// There are two HEX displays attached to the high (second) address.
#define SEVENSEG_N_DISPLAYS_HI 2

void DE1SoC_SevenSeg_Write(unsigned int display, unsigned char value) {
    // Select between the two addresses so that the higher level functions
    // have a seamless interface.
    if (display < SEVENSEG_N_DISPLAYS_LO) {
        // If we are targeting a low address, use byte addressing to access
        // directly.
        sevenseg_base_lo_ptr[display] = value;
    } else {
        // If we are targeting a high address, shift down so byte addressing
        // works.
        display = display - SEVENSEG_N_DISPLAYS_LO;
        sevenseg_base_hi_ptr[display] = value;
    }
}

void DE1SoC_SevenSeg_SetDoubleDec(unsigned int display, unsigned int value) {

	single = value % 10; //The remainder of the division is left as a single digit
		if(value >= 10){
			ten = value /10; //Dividing by an integer leaves the tens digit
		}
		else {
			ten = 0;
		}
	DE1SoC_SevenSeg_Write(display,LED[single]); //Display single digits
	DE1SoC_SevenSeg_Write(display+1,LED[ten]);  //Display ten digits
    /** Some examples:
     *
     *	  input | output | HEX(N+1) | HEX(N)
     *    ----- | ------ | -------- | ------
     *        5 |     05 |        0 |      5
     *       30 |     30 |        3 |      0
     *     0x90 |     96 |        9 |      6
     */
}

