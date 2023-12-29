/**
 * Unit 1.2 - FunctionPointers
 *
 * This program shows how to create and use function pointers.
 * You can explore how we can direct data to different functions at
 * runtime based on the value of the function pointer.
 */

#include "HPS_Watchdog/HPS_Watchdog.h"

// Define a new data type for a function which takes two int parameters
// and returns an int.
typedef int (*TaskFunction)(int, int);

// Create a couple of functions which match our function data type
int aFunction(int a, int b) {
    // ToDo: <-- Set a break point here
    int c = a + b;
    return c;
}

int anotherFunc(int a, int b) {
    // ToDo: <-- Set a break point here
    int c = a * b;
    return c;
}

int main(void) {

    // Create a pointer to aFunction.
    // ToDo: Try changing to &anotherFunc
    TaskFunction aPointer = &aFunction;

    // Create some inputs
    int a = 4;
    int b = 6;

    // Try calling the function
    int c = aPointer(a, b);

    // Do nothing, forever.
    while (1) {
        HPS_ResetWatchdog();
    }
}
