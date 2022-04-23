#include <stdio.h>

int a=12;
int b=13;
int bsum;

int main(void)
{
    printf("Globals: %d, %d\n", a, b);
    __asm__
    (
           ".intel_syntax noprefix\n"
           "mov rax, a \n"
           "add rax, b \n"
           "mov bsum, rax \n"
           :::"rax"	
    );

    printf("Extended inline (global) sum: %d\n", bsum);

    int x=14, y=16, esum, eproduct, edif;
    printf("Locals: %d, %d\n", x, y);

    __asm__
    (
         ".intel_syntax noprefix;"
        "mov rax, rdx;"
        "add rax, rcx;"
        :"=a"(esum)
        :"d"(x), "c"(y)
    );
    printf("Extended inline (local) sum: %d\n", esum);

    __asm__
    (
        ".intel_syntax noprefix;"
            "mov rbx, rdx;"
               "imul rbx, rcx;"
         "mov rax, rbx;"
        :"=a"(eproduct)
        :"d"(x), "c"(y)
        :"rbx"		
    );
    printf("Extended inline product: %d\n", eproduct);

    __asm__
    (
        ".intel_syntax noprefix;"
        "mov rax, rdx;"
        "sub rax, rcx;"
        :"=a"(edif)
        :"d"(x), "c"(y)	
    );
    printf("Extended inline difference: %d\n", edif);
}
