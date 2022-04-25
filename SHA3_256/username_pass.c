/******************************************************************************

                            Online C Compiler.
                Code, Compile, Run and Debug C program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/
#include <stdio.h>
#include <malloc.h>
#include <stdint.h> //for uint32_t 
#include <stdlib.h>
#include <string.h>

struct key_value
{
	/*
	* Username is the key, and the hash is the value
	*/
	char* key;
	char* pass; //temporary for development
    uint32_t value_0;
	uint32_t value_1;
	uint32_t value_2;
	uint32_t value_3;
	
	uint32_t value_4;
	uint32_t value_5;
	uint32_t value_6;
	uint32_t value_7;
};
struct key_value *kv;//= malloc(sizeof(struct key_value) * 5);//Max number of users = 5

// const int *p1 = malloc(4*sizeof(int));  // allocates enough for an array of 4 int
   
int num_created_users = 0;

int user_option = 0;

//Function declaration
void initialize();
void window_options();
void create_account();
void initial_login();
void existing_login();

void window_options()
{
    if (user_option == 1)
    {
        create_account();
    }
    else if(user_option == 2)
    {
        existing_login();
    }
    else
    {
        initial_login();
    }
}

void create_account()
{
	char password[32];

	printf("Enter username:\n");
	scanf("%32s", &kv[num_created_users].key);
// 	printf("user entered username: %s", &kv[num_created_users].key);

	printf("Enter a password:\n");
	scanf("%32s", &kv[num_created_users].pass);
	
// 	kv[num_created_users].pass = password; //TODO: make this the hash password
	
	num_created_users = num_created_users+1;
	user_option = 0; //return to initial initial_login
// 	printf("User option entered: %d\n", user_option);
	window_options();
}

void existing_login()
{
    char temp_username[32];
    char temp_password[32];
    // printf("Existing_login\n");
    printf("Enter existing username:\n");
    scanf("%32s", temp_username);
    
    printf("Enter existing password:\n");
    scanf("%32s", temp_password);
    // printf("num_created_user%d\n", num_created_users);
    // printf("temp_user:%s\n", temp_username);
	int i = 0;
    for(i; i < 5; i++)
    {
        // printf("userid:%s\n", &kv[i].key);
        // printf("tempid:%s\n", temp_username);
        // printf("bool:%d\n", strcmp(temp_username, &kv[i].key));
        if(strcmp(temp_username, &kv[i].key)==0)
        {
            // printf("userid:%s\n", &kv[i].key);
            // printf("usertemp:%s\n",temp_username);
            if(strcmp(temp_password,&kv[i].pass)==0)
            {
                printf("Successfully Logged In as: %s\n", temp_username);
            }
            else
            {
                printf("Incorrect password\n");
            }
            break;
        }
        
        if (i == 4)
        {
            printf("No  matching user found for: %s\n, temp_username");
        }
    }
    // printf("Last user: %s\n", &kv[num_created_users-1].key);
    // printf("Last pass: %s\n", &kv[num_created_users-1].pass);
    user_option = 0;
    // printf("User option entered: %d\n", user_option);
    window_options();
}

void initial_login()
{
	printf("Enter: (1) For Create Account, (2) For Existing User:\n");
	scanf("%d", &user_option);
    // printf("User option entered: %d\n", user_option);
    
	window_options();
}

void initialize()
{
    kv = malloc(sizeof(struct key_value) * 5);
}
int main()
{
    initialize();
    window_options();
    
    printf("User option entered: %d", user_option);

    return 0;
}
