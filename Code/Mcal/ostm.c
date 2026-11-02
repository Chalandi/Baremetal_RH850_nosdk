/******************************************************************************************
  Filename    : ostm.c

  Core        : RH850G3K (v850e3v5)

  Mcu         : R7F701030xAFP (RH850/F1L)

  Author      : Chalandi Amine

  Owner       : Chalandi Amine

  Date        : 02.11.2026

  Description : OSTM0 driver implementation

******************************************************************************************/
#include <stdint.h>

#define OSTM0_BASE 0xFFEC0000ul

#define OSTM0CMP (*(volatile uint32_t*)(OSTM0_BASE + 0x00))
#define OSTM0CNT (*(volatile uint32_t* const)(OSTM0_BASE + 0x04))
#define OSTM0TE  (*(volatile uint8_t* const)(OSTM0_BASE + 0x10))
#define OSTM0TS  (*(volatile uint8_t*)(OSTM0_BASE + 0x14))
#define OSTM0TT  (*(volatile uint8_t*)(OSTM0_BASE + 0x18))
#define OSTM0CTL (*(volatile uint8_t*)(OSTM0_BASE + 0x20))
#define OSTM0EMU (*(volatile uint8_t*)(OSTM0_BASE + 0x24))

#define ICOSTM0 (*(volatile uint16_t*)0xFFFFA098ul)

void ostm_init(void);
void ostm_start(void);
void ostm_stop(void);
void ostm_reload(uint32_t reload_value);

//----------------------------------------------------------------------------------------
/// \brief  
///
/// \descr 
///
/// \param  
///
/// \return 
//----------------------------------------------------------------------------------------
void ostm_init(void)
{
    OSTM0CTL = 0u;
    OSTM0TE  = 1u;
    /* configure timer interrupt */
    ICOSTM0  = 0x0040;
}
//----------------------------------------------------------------------------------------
/// \brief  
///
/// \descr 
///
/// \param  
///
/// \return 
//----------------------------------------------------------------------------------------
void ostm_start(void)
{
    OSTM0TS = 1u;
}

//----------------------------------------------------------------------------------------
/// \brief  
///
/// \descr 
///
/// \param  
///
/// \return 
//----------------------------------------------------------------------------------------
void ostm_stop(void)
{
    OSTM0TT = 1u;
}

//----------------------------------------------------------------------------------------
/// \brief  
///
/// \descr 
///
/// \param  
///
/// \return 
//----------------------------------------------------------------------------------------
void ostm_reload(uint32_t reload_value)
{
    OSTM0CMP = reload_value;
}
