CC = arm-none-eabi-gcc

%_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -marm -c $< -o$@

.PHONY: all clean

all: arm9_crt0.o
	
clean:
	rm -fr *.o
