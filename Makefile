CC = arm-none-eabi-gcc

%_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -marm -c $< -o$@

.PHONY: all clean install

all: arm9_crt0.o arm7_crt0.o
	
clean:
	rm -fr *.o

PREFIX ?= /usr/lib

DEPENDS = arm9_crt0.o arm9.ld arm9.mem arm9.specs \
		  arm7_crt0.o arm7.ld arm7.specs \
		  arm7_iwram.ld arm7_iwram.specs \
		  arm7_vram.ld arm7_vram.specs

install: $(DEPENDS)
	install -d $(DESTDIR)$(PREFIX)/arm-none-eabi/lib
	install -m 644 $^ $(DESTDIR)$(PREFIX)/arm-none-eabi/lib
