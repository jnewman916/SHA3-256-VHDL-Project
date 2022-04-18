all: 
	arm-linux-gnueabihf-gcc -Dsoc_cv_av -O2 -o sha sha.c
	arm-linux-gnueabihf-strip -s sha
clean: 
	rm -rf sha