CC = arm-none-eabi-gcc

%_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -marm -c $< -o$@

.PHONY: all clean install

all: arm9_crt0.o
	
clean:
	rm -fr *.o

PREFIX ?= /usr/lib

install: arm9_crt0.o arm9.ld arm9.mem arm9.specs
	install -d $(DESTDIR)$(PREFIX)/arm-none-eabi/lib
	install -m 644 $^ $(DESTDIR)$(PREFIX)/arm-none-eabi/lib
