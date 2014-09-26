        .section        .rodata
.hellostr:
        .string "Hello, world\n"

        .text
.globl _start
_start:
        pushq   %rbp
        movq    %rsp, %rbp

        # write
        movl    $13, %edx         # str length
        movl    $.hellostr, %esi  # address of hellostr -> %esi
        movl    $1, %edi          # file descriptor, 1 = STDOUT
        movl    $1, %eax          # "write" syscall, 1 (c.f. /usr/include/asm/unistd_64.h)
        syscall

        # exit
        movl    $0, %eax          # program return code (arg to "exit")
        movl    $60, %eax         # "exit" syscall
        syscall
