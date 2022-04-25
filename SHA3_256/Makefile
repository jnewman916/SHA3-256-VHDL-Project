all: 
	arm-linux-gnueabihf-gcc -Dsoc_cv_av -O2 -o username_pass username_pass.c
	arm-linux-gnueabihf-strip -s username_pass
clean: 
	rm -rf username_pass
