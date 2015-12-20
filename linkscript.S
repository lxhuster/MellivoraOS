INPUT (init.o led.o)
OUTPUT(lx_led.elf)
OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)

SECTIONS
{
    . = 0x30008000;
    __begin_init_sec = .;
    .head.init ALIGN(4) : { *(.head.init) }
    __end_init_sec = .;
}
