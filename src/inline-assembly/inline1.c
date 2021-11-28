// inline.c
#include <stdio.h>

int x=11, y=12, sum, prod;
int subtract(void);
void multiply(void);

int main(void)
{
	printf("%d, %d\n", x, y);
	__asm__
	(
		".intel_syntax noprefix;"
		"mov rax, x;"
		"add rax, y;"
		"mov sum, rax"
	);
	printf("Sum %d\n", sum);
	printf("Difference %d\n", subtract());
	multiply();
	printf("Product %d\n", prod);
}

int subtract(void)
{
	__asm__
	(
		".intel_syntax noprefix;"
		"mov rax, x;"
		"sub rax, y"
	);
}

void multiply(void)
{
	__asm__
	(
		".intel_syntax noprefix;"
		"mov rax, x;"
		"imul rax, y;"
		"mov prod, rax"	// no return value, set global
	);

}


