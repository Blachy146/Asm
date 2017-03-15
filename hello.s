SYSEXIT = 1
EXIT_SUCCESS = 0
WRITE = 4
STDOUT = 1
READ = 3
STDIN = 0
SYSCALL = 0x80

.text
msg:
  .ascii "Hello!\n"
  masg_len = . - msg

.global _start
_start:

movl $WRITE, %eax
movl $STDOUT, %ebx
movl $msg, %ecx
movl $masg_len, %edx
int $SYSCALL

#movl $SYSEXIT, %eax
#movl $EXIT_SUCCESS, %ebx
#int $SYSCALL
