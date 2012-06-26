/*
 * File: main.c
 * Date: 15.08.2011
 * Denis Zheleznjakov http://ziblog.ru
 */

#ifndef MAIN_H_
#define MAIN_H_

#include "macros.h"

#include "stm32l1xx.h"
#include "stm32l1xx_it.h"
#include "core_cm3.h"

#include "mcu_gpio.h"
#include "mcu_rcc.h"

#define PIN_TEST	D, 2, HIGH, MODE_OUTPUT_PUSH_PULL, SPEED_400KHZ, AF_NO

#define LED_GREEN	B, 7, HIGH, MODE_OUTPUT_PUSH_PULL, SPEED_400KHZ, AF_NO
#define LED_BLUE	B, 6, HIGH, MODE_OUTPUT_PUSH_PULL, SPEED_400KHZ, AF_NO

#define USER_BUTTON	A, 0, HIGH, MODE_INPUT_FLOATING, SPEED_400KHZ, AF_NO

#define PIN_MCO		A, 8, HIGH, MODE_AF_PUSH_PULL, SPEED_40MHZ, AF0

#endif /* MAIN_H_ */
