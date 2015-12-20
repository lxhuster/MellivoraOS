@define the register addr
.equ WATCH_DOG, 0x53000000
.equ INT_MASK, 0x4a000008
.equ INT_SUBMASK, 0x4a00001c

@set init func stack at the highest addr of mini2440 sdram
.equ INIT_HEAD_STACK_ADDR, 0x34000000

@declare section name
.section .head.init

.code 32
.extern kernel_init
.global _start
.align 4
_start:
@disable mmu
    mrc p15, 0, r0, c1, c0, 0
@ 0xc00073fe base on ARM 920T Technical Reference Manual
    ldr r1, =0xc00073fe
    and r0, r0, r1
    mcr p15, 0, r0, c1, c0, 0

@disable IRQ & FIQ, get into sve mode
    msr CPSR_c, #0xd3

@disbale watchdog timer    
    ldr r0, =WATCH_DOG
    mov r1, #0
    str r1, [r0]
    
@mask all interrupt source
    ldr r0, =INT_MASK
    ldr r1, =0xffffffff
    str r1, [r0]
    ldr r0, =INT_SUBMASK
    ldr r1, =0x7fff
    str r1, [r0]
    
@set stack addr ,ready for c function
    ldr sp, =INIT_HEAD_STACK_ADDR

@jump to entry of kernel init
    b kernel_init
