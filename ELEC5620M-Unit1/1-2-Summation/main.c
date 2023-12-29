/**
 * Unit 1.2 - Summation
 *
 * This program performs the following on the ARM A9 and DE1-SoC Computer:
 * 	1. Initialises pointers to peripheral addresses
 * 	2. Loops indefinitely, sets LEDs (LEDR9-0) to the summation of KEY3-0 input.
 * 	3. Resets the watchdog timer value at the end of the main loop.
 */

#include "HPS_Watchdog/HPS_Watchdog.h"

/**
 * recursiveSum
 *
 * Sum all numbers from 1-N using recursion.
 *
 * Arguments:
 *      N       Number to sum to.
 *
 * Returns:
 *      The sum of all numbers 1-N.
 */
unsigned int recursiveSum(unsigned int N) {
    if (N == 0) {
        // If N is 0, we have reached deepest level
        return 0; // The sum of 0 + 0 is 0.
    } else {
        // Otherwise we need to perform another level
        return N + recursiveSum(N - 1); // Return N + sum(0 to N-1)
    }
}

int main(void) {

    // Peripheral Base Address Pointers
    volatile unsigned int *LEDR_ptr = (unsigned int *)0xFF200000; // Red LEDs base
    volatile unsigned int *KEY_ptr = (unsigned int *)0xFF200050;  // KEY buttons base

    // Local Variables
    unsigned int N;
    unsigned int sum;

    while (1) {

        // Set N to KEY[3:0] input value.
        N = *KEY_ptr & 0x0F;

        // Reset the sum value
        sum = 0;

        // Summation loop.
        // ToDo: Run program using loop, then swap it for the recursiveSum function
       sum =  recursiveSum(N);
        /*  while (N != 0) {
           sum = sum + N;
           N--;
        }
*/
        // Set LED output value to sum result.
        *LEDR_ptr = sum;

        // Reset the watchdog timer
        HPS_ResetWatchdog();
    }
}
