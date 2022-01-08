# Lib version 1.1.0

CC = arm-none-eabi-gcc

thumb/%_vram_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -DVRAM -mthumb -c $< -o$@

%_vram_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -DVRAM -marm -c $< -o$@

thumb/%_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -mthumb -c $< -o$@

%_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -marm -c $< -o$@


.PHONY: all build path_builder clean install

all: path_builder build

build: arm7_vram_crt0.o thumb/arm7_vram_crt0.o \
	   arm7_crt0.o thumb/arm7_crt0.o \
	   arm9_crt0.o thumb/arm9_crt0.o

path_builder:
	mkdir -p thumb

clean:
	rm -fr *.o thumb

PREFIX ?= /usr/lib

DEPENDS = arm9_crt0.o arm9.ld arm9.mem arm9.specs \
		  arm7_crt0.o arm7.ld arm7.specs \
		  arm7_iwram.ld arm7_iwram.specs \
		  arm7_vram.ld arm7_vram.specs

install: $(DEPENDS)
	install -d $(DESTDIR)$(PREFIX)/arm-none-eabi/lib
	install -m 644 $^ $(DESTDIR)$(PREFIX)/arm-none-eabi/lib
	cp *.specs *.ld *.mem $(DESTDIR)$(PREFIX)/arm-none-eabi/lib
	cp -r thumb *.o $(DESTDIR)$(PREFIX)/arm-none-eabi/lib