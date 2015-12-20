#define K_SECTION __attribute__((section(".head.init")))

#define GPBCON (*((unsigned int *)0x56000010))
#define GPBDAT (*((unsigned int *)0x56000014))

/* this operation base s3c2440 data sheet */
K_SECTION void gpiob_outmode_set(unsigned char gpio_num)
{
    GPBCON &= ~(0x01 << ((gpio_num << 1) + 1));
    GPBCON |= 0x01 << (gpio_num << 1);
}

K_SECTION void led_init()
{
    gpiob_outmode_set(5);
    gpiob_outmode_set(6);
    gpiob_outmode_set(7);
    gpiob_outmode_set(8);
    
/* light up all the four led on mini2440 board */    
    GPBDAT = 0x00;
}

K_SECTION void delay()
{
    volatile unsigned int i = 0;
    volatile unsigned int j = 0;
    for(; i < 99999; i++)
        for(; j < 90000; j++);
}

K_SECTION void blink_led()
{
    while(1)
    {    
        GPBDAT = 0x00;
        delay(); 
        GPBDAT |= 0xff;
        delay();
    }
}

K_SECTION void kernel_init()
{
    led_init();
    blink_led();
}

