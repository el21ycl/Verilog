/*
 * PrivateTimer.h
 *
 *  Created on: 2022Äê4ÔÂ23ÈÕ
 *      Author: lin
 */

#ifndef PrivateTimer_H_
#define PrivateTimer_H_

#include <stdbool.h>

#define TIMER_SUCCESS       0
#define TIMER_ERRORNOINIT  -1

signed int Timer_initialise(unsigned int base_address);
bool Timer_isInitialised( void );

signed int Timer_enable( bool set_enabled);

//Automatically reloaded
signed int Timer_ar( bool set_A);

//To divide the clock to a lower rate
//signed int Timer_P(unsigned int P);

// ARM A9 Private Timer Load
signed int Timer_load(unsigned int load);

// ARM A9 Private Timer Value
signed int Timer_value (void);

// ARM A9 Private Timer Interrupt
signed int Timer_interrupt( bool set_F);

#endif /*PrivateTimer_H*/
