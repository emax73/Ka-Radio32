/******************************************************************************
 * 
 * Copyright 2018 karawin (http://www.karawin.fr)
 *
 *
 * This file contain empty functions definition on the standard delivery
*******************************************************************************/
#include "driver/gpio.h"
#include "gpio.h"
#include "custom.h"

#define gpioLedBacklight 5

// LedBacklight control a gpio to switch on or off the lcd backlight 
// in addition of the sys.lcdout("x")  configuration for system with battries.
// added by Vadim Polyakovsky 
void LedBacklightInit()
{
	//gpio_output_conf(gpioLedBacklight);
	//gpio_set_level(gpioLedBacklight,1);
}	 
 
void LedBacklightOn() 
{
	//gpio_set_level(gpioLedBacklight,1);
}	 
 
void  LedBacklightOff() 
{
	//gpio_set_level(gpioLedBacklight,0);
}	 
