#include "HPS_PrivateTimer.h"

//Driver Base Addresses
volatile unsigned int   *timer_base_ptr     = 0x0;  //0xFFFEC600

//Driver Initialised
bool timer_initialised = false;

//Control Bit Map
#define TIMER_E    (1 << 0)  //Output enable
#define TIMER_A    (1 << 1)  //Whether automatically reloaded
#define TIMER_I    (1 << 2)  //When the I bit is set, the timer will generate an interrupt request
#define TIMER_PRESCALER     (0 << 8)  //To divide the clock to a lower rate
//Interrupt Status Bit Map
#define TIMER_F    (1 << 0)  //Whether the Interrupt Status


//Register Offsets
#define TIMER_LOAD      (0x00/sizeof(unsigned int))
#define TIMER_VALUE     (0x04/sizeof(unsigned int))
#define TIMER_CONTROL   (0x08/sizeof(unsigned int))
#define TIMER_INTERRUPT (0x0C/sizeof(unsigned int))

//Function to initialise the Timer
signed int Timer_initialise(unsigned int base_address){
    //Initialise base address pointers
    timer_base_ptr = (unsigned int *)  base_address;
    //Ensure timer initialises to disabled
    timer_base_ptr[TIMER_CONTROL] = 0;
    //Timer now initialised
    timer_initialised = true;
    return TIMER_SUCCESS;
}

//Check if driver initialised
bool Timer_isInitialised() {
    return timer_initialised;
}

//Enable/Disable a timer
// - "set_enabled" is true to enable, false to disable.
// - returns SERVO_SUCCESS if successful
signed int Timer_enable( bool set_enabled) {
    volatile unsigned int* timer_ptr;
    //Sanity checks
    if (!Timer_isInitialised()) return TIMER_ERRORNOINIT;
    //Configure enable
    timer_ptr = (unsigned int*) timer_base_ptr; //Get the csr for the requested servo
    if (set_enabled) {
        timer_ptr[TIMER_CONTROL] |=  TIMER_E;
    } else {
        timer_ptr[TIMER_CONTROL] &= ~TIMER_E;
    }
    return TIMER_SUCCESS;
}

//Automatically reloaded
signed int Timer_ar( bool set_A) {
        volatile unsigned int* timer_ptr;
        //Sanity checks
        if (!Timer_isInitialised()) return TIMER_ERRORNOINIT;
        //Configure enable
        timer_ptr = (unsigned int*) timer_base_ptr; //Get the csr for the requested servo
        if (set_A) {
            timer_ptr[TIMER_CONTROL] |=  TIMER_A;
        } else {
            timer_ptr[TIMER_CONTROL] &= ~TIMER_A;
        }
        return TIMER_SUCCESS;
}

//To divide the clock to a lower rate
/*signed int Timer_P(unsigned int set_P) {
        volatile unsigned int* private_timer_Prescaler;
        //Sanity checks
        if (!Timer_isInitialised()) return TIMER_ERRORNOINIT;
        //Configure enable
        private_timer_Prescaler = (unsigned int*) timer_base_ptr; //Get the csr for the requested timer
        private_timer_Prescaler[TIMER_CONTROL] =  set_P<<8;
        return TIMER_SUCCESS;
}*/

// ARM A9 Private Timer Load
signed int Timer_load(unsigned int load) {
        volatile unsigned int* private_timer_load;
        //Configure enable
        private_timer_load = (unsigned int*) timer_base_ptr; //Get the csr for the requested timer
        private_timer_load[TIMER_LOAD] =  load;
        return TIMER_SUCCESS;
}

// ARM A9 Private Timer Value
signed int Timer_value (void){
	volatile unsigned int* private_timer_value;
	//Configure enable
     private_timer_value = (unsigned int*) timer_base_ptr; //Get the csr for the requested timer
    return private_timer_value[TIMER_VALUE];
}

// ARM A9 Private Timer Interrupt
signed int Timer_interrupt( bool set_F) {
        volatile unsigned int* private_timer_interrupt;
        //Sanity checks
        if (!Timer_isInitialised()) return TIMER_ERRORNOINIT;
        //Configure enable
        private_timer_interrupt = (unsigned int*) timer_base_ptr; //Get the csr for the requested servo
        if (set_F) {
        	private_timer_interrupt[TIMER_INTERRUPT] |=  TIMER_F;
        } else {
        	private_timer_interrupt[TIMER_INTERRUPT] &= ~TIMER_F;
        }
        return TIMER_SUCCESS;
}


