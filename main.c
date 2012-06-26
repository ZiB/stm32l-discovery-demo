/*
 * File: main.c
 * Date: 15.08.2011
 * Denis Zheleznjakov http://ziblog.ru
 */

#include "main.h"

//------------------------------------------------------------------------------
void main(void)
{
	mcu_rcc_init();

	PIN_CONFIGURATION(PIN_TEST);
	PIN_CONFIGURATION(LED_GREEN);
	PIN_CONFIGURATION(LED_BLUE);
	PIN_CONFIGURATION(USER_BUTTON);
	PIN_CONFIGURATION(PIN_MCO);

	//
	PIN_ON(LED_GREEN);

	while (1)
	{
		if (PIN_SIGNAL(USER_BUTTON))
		{
			PIN_ON(LED_GREEN);
			PIN_OFF(LED_BLUE);
		}
		else
		{
			PIN_OFF(LED_GREEN);
			PIN_ON(LED_BLUE);
		}
	}
}
