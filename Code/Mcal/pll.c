/******************************************************************************************
  Filename    : pll.c

  Core        : RH850G3K (v850e3v5)

  Mcu         : R7F701030xAFP (RH850/F1L)

  Author      : Chalandi Amine

  Owner       : Chalandi Amine

  Date        : 02.11.2026

  Description : PLL driver implementation

******************************************************************************************/

//-----------------------------------------------------------------------------------------
// Includes
//-----------------------------------------------------------------------------------------
#include <stdint.h>

//-----------------------------------------------------------------------------------------
// Function Prototypes
//-----------------------------------------------------------------------------------------
void pll_init(void);

//-----------------------------------------------------------------------------------------
// Globals
//-----------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------
// Defines
//-----------------------------------------------------------------------------------------
#define MOSCE    (*(volatile uint32_t*)0xFFF81100ul)
#define MOSCS    (*(volatile uint32_t* const)0xFFF81104ul)
#define MOSCC    (*(volatile uint32_t*)0xFFF81108ul)
#define MOSCST   (*(volatile uint32_t*)0xFFF8110Cul)
#define MOSCSTPM (*(volatile uint32_t*)0xFFF81118ul)

#define PLLE (*(volatile uint32_t*)0xFFF89000ul)
#define PLLS (*(volatile uint32_t* const)0xFFF89004ul)
#define PLLC (*(volatile uint32_t*)0xFFF89008ul)

/* Control protection clusters */
#define PROTCMD0 (*(volatile uint32_t*)0xFFF80000ul)
#define PROTCMD1 (*(volatile uint32_t*)0xFFF88000ul)
#define PROTS0   (*(volatile uint32_t* const)0xFFF80004ul)
#define PROTS1   (*(volatile uint32_t* const)0xFFF88004ul)

#define WRITE_PROT(protcmdr,prots,reg,value) do{                             \
                                                   protcmdr = 0xA5ul;        \
                                                   reg = value;              \
                                                   reg = (uint32_t)~(value); \
                                                   reg = value;              \
                                                   while(prots);             \
                                                }while(0)
/* Clock selector registers */
#define CKSC_CPUCLKS_CTL (*(volatile uint32_t*)0xFFF8A000ul)
#define CKSC_CPUCLKS_ACT (*(volatile uint32_t*)0xFFF8A008ul)
#define CKSC_CPUCLKD_CTL (*(volatile uint32_t*)0xFFF8A100ul)
#define CKSC_CPUCLKD_ACT (*(volatile uint32_t*)0xFFF8A108ul)

//----------------------------------------------------------------------------------------
/// \brief  
///
/// \descr 
///
/// \param  
///
/// \return 
//----------------------------------------------------------------------------------------
void pll_init(void)
{
    /* set MainOSC clock amplification gain to mid-low */
    MOSCC = 0x6ul;

    /* set MainOSC clock stabilization time to 5ms */
    MOSCST = (uint32_t)(5 * 8 * 1000);

    /* enable MainOSC clock (16MHz) */
     WRITE_PROT(PROTCMD0, PROTS0, MOSCE, 1ul);

    /* wait for MainOSC to stabilize */
    while(!(MOSCS & (1ul << 2)));

    /* configure PLL (fPPLCLK=80MHz, fCPLLCLK=96MHz) */
    PLLC = 0x10B3Bul;

    /* enable PLL */
    WRITE_PROT(PROTCMD1, PROTS1, PLLE, 1ul);

    /* wait for PLL to stabilize */
    while(!(PLLS & (1ul << 2)));

    /* set CPUCLK source clock to PLL */
    WRITE_PROT(PROTCMD1, PROTS1, CKSC_CPUCLKS_CTL, 3ul);

    /* wait for CPUCLK clock to switch to PLL */
    while(CKSC_CPUCLKS_ACT != 3);
}














