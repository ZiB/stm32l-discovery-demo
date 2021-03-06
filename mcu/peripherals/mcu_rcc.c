/*
 * File: mcu_rcc.c
 * Date: 16.12.2011
 * Denis Zheleznjakov http://ziblog.ru
 */

#include "main.h"

enum rcc_cfgr_mco_select
{
	RCC_CFGR_MCOSEL_DISABLED = 0,
	RCC_CFGR_MCOSEL_SYSCLK = RCC_CFGR_MCOSEL_0,
	RCC_CFGR_MCOSEL_HSI = RCC_CFGR_MCOSEL_1,
	RCC_CFGR_MCOSEL_MSI = RCC_CFGR_MCOSEL_1 | RCC_CFGR_MCOSEL_0,
	RCC_CFGR_MCOSEL_HSE = RCC_CFGR_MCOSEL_2,
	RCC_CFGR_MCOSEL_PLL = RCC_CFGR_MCOSEL_2 | RCC_CFGR_MCOSEL_0,
	RCC_CFGR_MCOSEL_LSI = RCC_CFGR_MCOSEL_2 | RCC_CFGR_MCOSEL_1,
	RCC_CFGR_MCOSEL_LSE = RCC_CFGR_MCOSEL_2 | RCC_CFGR_MCOSEL_1
			| RCC_CFGR_MCOSEL_0
};

//------------------------------------------------------------------------------
void mcu_rcc_init(void)
{
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN | RCC_AHBENR_GPIOBEN | RCC_AHBENR_GPIOCEN
			| RCC_AHBENR_GPIODEN;
	RCC->APB1ENR |= RCC_APB1ENR_LCDEN | RCC_APB1ENR_PWREN | RCC_APB1ENR_I2C1EN;
}
