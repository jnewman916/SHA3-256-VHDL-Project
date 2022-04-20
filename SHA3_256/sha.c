#include <stdio.h> //for printf() and other functionalities 
#include <stdlib.h> //for exit() 
#include <stdint.h> //for uint32_t 
#include <fcntl.h> //for constants O_RDWR|O_SYNC used in opening serial interface 
#include <signal.h> //handles CTRL+C 
#include <sys/mman.h> //for mmap() and munmap() 
#include <time.h>
#include "hps_0.h" //Platform design peripheral description 

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

struct key_value
{
	/*
	* Username is the key, and the hash is the value
	*/
	char* key;
    uint32_t value_0;
	uint32_t value_1;
	uint32_t value_2;
	uint32_t value_3;
	
	uint32_t value_4;
	uint32_t value_5;
	uint32_t value_6;
	uint32_t value_7;
};

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

void populate_password(int password_int[32])
{
	*sha_in0 = (password_int[0] << 24) | (password_int[1] << 16) | (password_int[2] << 8) | (password_int[3]);
	*sha_in1 = (password_int[4] << 24) | (password_int[5] << 16) | (password_int[6] << 8) | (password_int[7]);
	*sha_in2 = (password_int[8] << 24) | (password_int[9] << 16) | (password_int[10] << 8) | (password_int[11]);
	*sha_in3 = (password_int[12] << 24) | (password_int[13] << 16) | (password_int[14] << 8) | (password_int[15]);
	
	*sha_in4 = (password_int[16] << 24) | (password_int[17] << 16) | (password_int[18] << 8) | (password_int[19]);
	*sha_in5 = (password_int[20] << 24) | (password_int[21] << 16) | (password_int[22] << 8) | (password_int[23]);
	*sha_in6 = (password_int[24] << 24) | (password_int[25] << 16) | (password_int[26] << 8) | (password_int[27]);
	*sha_in7 = (password_int[28] << 24) | (password_int[29] << 16) | (password_int[30] << 8) | (password_int[31]);
	
	printf("SHA_in0: %#8X SHA_in1: %#8X\n", *sha_in0, *sha_in1);
	printf("SHA_in2: %#8X SHA_in3: %#8X\n", *sha_in2, *sha_in3);
	printf("SHA_in4: %#8X SHA_in5: %#8X\n", *sha_in4, *sha_in5);
	printf("SHA_in6: %#8X SHA_in7: %#8X\n", *sha_in6, *sha_in7);
}

void prompt_login(int *user_option)
{
	printf("Enter: (1) For Create Account, (2) For Existing User:\n")
	scanf("%d", &user_option)
}


void create_user(key_value *kv)
{
	char password[32];
	
	printf("Enter username:\n")
	scanf("%31s", kv[num_created_users].key);
	
	printf("Enter a password:\n");
	scanf("%31s", password);
	
	hash(password)
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
	
	initialize_addresses()

	initialize_round_const()
	
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
	
	int num_created_users = 0;
	int user_option=0;
	
	int number_of_users = 5; // Can only have a max of 5 users
	struct key_value *kv = malloc(sizeof(struct key_value) * number_of_users);
	
	signal(SIGINT, handler); //handles CTRL+C 
	while(1){ 
		
		prompt_login(user_option);
		
		while(user_option <= 0 || user_option > 2)
		{
			printf("Value Entered invalid\n");
			prompt_login(user_option);
		}
		
		if(*user_option == 1)
		{
			create_user(kv);
		}
		else if(*user_option == 2)
		{
			login();
		}

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
		}
	}
}