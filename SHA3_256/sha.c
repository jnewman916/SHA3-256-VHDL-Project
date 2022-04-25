#include <stdio.h> //for printf() and other functionalities 
#include <stdlib.h> //for exit() 
#include <stdint.h> //for uint32_t 
#include <fcntl.h> //for constants O_RDWR|O_SYNC used in opening serial interface 
#include <signal.h> //handles CTRL+C 
#include <sys/mman.h> //for mmap() and munmap() 
#include <time.h>
#include "hps_0.h" //Platform design peripheral description 
#include <unistd.h>
#include <sys/time.h>

#define REG_BASE 0xff200000 //LW H2F Bride Base Address 
#define REG_SPAN 0x00200000 //LW H2F Bridge Span 

// Global variables
void *base;
uint32_t *sha_in0; uint32_t *sha_in1;
uint32_t *sha_in2; uint32_t *sha_in3;
uint32_t *sha_in4; uint32_t *sha_in5;
uint32_t *sha_in6; uint32_t *sha_in7;

uint32_t *sha_out0; uint32_t *sha_out1;
uint32_t *sha_out2; uint32_t *sha_out3;
uint32_t *sha_out4; uint32_t *sha_out5;
uint32_t *sha_out6; uint32_t *sha_out7;

uint32_t *round_const0; uint32_t *round_const1;

uint32_t *flag_in; uint32_t *flag_out;

int fd;
	 
uint32_t attempt = 0;

void hash(char password[32]);

void handler(int signo){ //Used to free the mapped resource upon exit() 
	 *sha_in0=0;
	 *sha_in1=0;
	 *sha_in2=0;
	 *sha_in3=0;
	 *sha_in4=0;
	 *sha_in5=0;
	 *sha_in6=0;
	 *sha_in7=0;

	 *sha_out0=0;
	 *sha_out1=0;
	 *sha_out2=0;
	 *sha_out3=0;
	 *sha_out4=0;
	 *sha_out5=0;
	 *sha_out6=0;
	 *sha_out7=0;
	 
	*round_const0=0;
	*round_const1=0;

	*flag_in=0;
	*flag_out=0;

	munmap(base, REG_SPAN);
	close(fd); exit(0);
} 

void hash(char password[32]) {

	int ind;
	int password_int[32];

	for (ind = 0; ind < 32; ind = ind + 1)
	{
		password_int[ind] = password[ind];
	}

	*sha_in0 = (password_int[0] << 24) | (password_int[1] << 16) | (password_int[2] << 8) | (password_int[3]);
	*sha_in1 = (password_int[4] << 24) | (password_int[5] << 16) | (password_int[6] << 8) | (password_int[7]);
	*sha_in2 = (password_int[8] << 24) | (password_int[9] << 16) | (password_int[10] << 8) | (password_int[11]);
	*sha_in3 = (password_int[12] << 24) | (password_int[13] << 16) | (password_int[14] << 8) | (password_int[15]);

	*sha_in4 = (password_int[16] << 24) | (password_int[17] << 16) | (password_int[18] << 8) | (password_int[19]);
	*sha_in5 = (password_int[20] << 24) | (password_int[21] << 16) | (password_int[22] << 8) | (password_int[23]);
	*sha_in6 = (password_int[24] << 24) | (password_int[25] << 16) | (password_int[26] << 8) | (password_int[27]);
	*sha_in7 = (password_int[28] << 24) | (password_int[29] << 16) | (password_int[30] << 8) | (password_int[31]);
	*flag_out = 1;


	while (*flag_in==0) {

	}

	printf("SHA0: %#8X SHA1: %#8X\n", *sha_out0, *sha_out1);
	printf("SHA2: %#8X SHA3: %#8X\n", *sha_out2, *sha_out3);
	printf("SHA4: %#8X SHA5: %#8X\n", *sha_out4, *sha_out5);
	printf("SHA6: %#8X SHA7: %#8X\n", *sha_out6, *sha_out7);

	*flag_out = 0;
}

void initialize_addresses()
{
	sha_in0=(uint32_t*)(base+SHA_IN0_BASE);
	sha_in1=(uint32_t*)(base+SHA_IN1_BASE);
	sha_in2=(uint32_t*)(base+SHA_IN2_BASE);
	sha_in3=(uint32_t*)(base+SHA_IN3_BASE);
	sha_in4=(uint32_t*)(base+SHA_IN4_BASE);
	sha_in5=(uint32_t*)(base+SHA_IN5_BASE);
	sha_in6=(uint32_t*)(base+SHA_IN6_BASE);
	sha_in7=(uint32_t*)(base+SHA_IN7_BASE);

	sha_out0=(uint32_t*)(base+SHA_OUT0_BASE);
	sha_out1=(uint32_t*)(base+SHA_OUT1_BASE);
	sha_out2=(uint32_t*)(base+SHA_OUT2_BASE);
	sha_out3=(uint32_t*)(base+SHA_OUT3_BASE);
	sha_out4=(uint32_t*)(base+SHA_OUT4_BASE);
	sha_out5=(uint32_t*)(base+SHA_OUT5_BASE);
	sha_out6=(uint32_t*)(base+SHA_OUT6_BASE);
	sha_out7=(uint32_t*)(base+SHA_OUT7_BASE);
	
	round_const0=(uint32_t*)(base+ROUND_CONST0_BASE);
	round_const1=(uint32_t*)(base+ROUND_CONST1_BASE);

	flag_in=(uint32_t*)(base+FLAG_IN_BASE);
	flag_out=(uint32_t*)(base+FLAG_OUT_BASE);
}

void initialize_round_const()
{
	*round_const0 = rand();
	*round_const1 = rand();
}

void create_hash_from_password()
{
	char password[32];
	printf("Enter a password:\n");
	scanf("%31s", password);
		
	hash(password);
}

void crack_hash()
{
	char temp_password[32];
	struct timeval start, end;
	
	printf("Enter a password:\n");
	scanf("%31s", temp_password);
		
	hash(temp_password);
	
	uint32_t temp_sha_out0=sha_out0; uint32_t temp_sha_out1=sha_out1;
	uint32_t temp_sha_out2=sha_out2; uint32_t temp_sha_out3=sha_out3;
	uint32_t temp_sha_out4=sha_out4; uint32_t temp_sha_out5=sha_out5;
	uint32_t temp_sha_out6=sha_out6; uint32_t temp_sha_out7=sha_out7;
	
	int not_cracked = 1;
	double time_printed = 0;
	gettimeofday(&start, NULL);
	
	while(not_cracked)
	{
		*sha_in0 = rand();
		*sha_in1 = rand();
		*sha_in2 = rand();
		*sha_in3 = rand();
		
		*sha_in4 = rand();
		*sha_in5 = rand();
		*sha_in6 = rand();
		*sha_in7 = rand();
		*flag_out = 1;
		while (*flag_in==0) {} //Wait for the hardware to be ready to hash
		
		attempt++;
		printf("Attempt:%d\n", attempt);
		printf("SHA1: %#8X %#8X %#8X %#8X\n\n", *sha_out0, *sha_out1, *sha_out2, *sha_out3);
		printf("SHA1: %#8X %#8X %#8X %#8X\n\n", *sha_out4, *sha_out5, *sha_out6, *sha_out7);

		*flag_out = 0;
		
		if( (*sha_out0 == temp_sha_out0) && (*sha_out1 == temp_sha_out1) &&
			(*sha_out2 == temp_sha_out2) && (*sha_out3 == temp_sha_out3) &&
			(*sha_out4 == temp_sha_out4) && (*sha_out5 == temp_sha_out5) &&
			(*sha_out6 == temp_sha_out6) && (*sha_out7 == temp_sha_out7))
		{
			printf("ACCESS GRANTED\n");
			not_cracked = 0;
		}
		if (attempt % 1000 == 0)
		{
			gettimeofday(&end, NULL);
	
			double time_taken = end.tv_sec + end.tv_usec / 1e6 -
                        start.tv_sec - start.tv_usec / 1e6; // in seconds

			printf("Total HashAttemps: %d\n", attempt);
			printf("Average Time hashing per 1000: %f\n", time_taken);
			sleep(1);
			gettimeofday(&start, NULL);
		}
	}
}


int main(){
	int i = 0; 
	fd=open("/dev/mem", O_RDWR|O_SYNC); //try and open the entire memory space 
	if(fd<0){ 
		printf("Can't open memory\n"); 
		return -1; 
	} 
	
	base=mmap(NULL, REG_SPAN, PROT_READ|PROT_WRITE, MAP_SHARED, fd, REG_BASE); //map the lightweight bridge 
	if(base==MAP_FAILED){
		printf("Can't map to memory\n");
		close(fd); 
		return -1;
	} 
	//peripheral exists at the base address plus the specific offset 
	
	initialize_addresses();

	initialize_round_const();
	
	*sha_in0=0x12345678;
	*sha_in1=0x11111111;
	*sha_in2=0x22222222;
	*sha_in3=0x33333333;
	*sha_in4=0;
	*sha_in5=0;
	*sha_in6=0;
	*sha_in7=0;
	
	*flag_out = 1;
	char password[32];
	int password_int[32];
	int ind;
	int option = 0;
	
	signal(SIGINT, handler); //handles CTRL+C 
	while(1){ 

		printf("(1) Create a hash or (2) Try and crack your password");
		scanf("%d", &option);

		if(option == 1)
		{
			create_hash_from_password();
		}
		else if(option == 2)
		{
			crack_hash();
		}
		else{
			printf("not a valid value entered");
		}
		/**
		*flag_out = 1;
		sleep(1);

		if (*flag_in == 1)
		{
			printf("SHA0: %#8X SHA1: %#8X\n", *sha_out0, *sha_out1);
			printf("SHA2: %#8X SHA3: %#8X\n", *sha_out2, *sha_out3);
			printf("SHA4: %#8X SHA5: %#8X\n", *sha_out4, *sha_out5);
			printf("SHA6: %#8X SHA7: %#8X\n", *sha_out6, *sha_out7);
						
			*sha_in0 = *sha_in0 + *sha_in0;
			*sha_in1 = *sha_in1 + *sha_in1;
			*flag_out = 0;
		}**/
	}
}