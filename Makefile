CC = arm-linux-gcc 
CFLAGS = -Wall -g -v
LD = arm-linux-ld
LD_SCRIPT = ~/lxhuster_share/linkscript.S 
OBJCOPY = arm-linux-objcopy
DNW = ~/lxhuster_share/dnw2

all: init.o led.o lx_led.elf lx_led.bin down_bin

init.o: init.s 
	$(CC) -c -g -v init.s -o init.o

led.o: led.c
	$(CC) $(CFLAGS) -c led.c -o led.o

lx_led.elf: init.o led.o
	$(LD) -T $(LD_SCRIPT)

lx_led.bin: lx_led.elf
	$(OBJCOPY) -O binary -S lx_led.elf lx_led.bin

down_bin: lx_led.bin
	sudo $(DNW) ./lx_led.bin

clean:
	rm -f *.o lx_led.elf lx_led.bin 
