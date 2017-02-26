EXIT = 1
READ = 3
WRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0
SYSCALL = 0x80
BUFOR_SPACE = 4

.section .data
WELCOME_TEXT:
  .ascii "Podaj ciag znakow: "
  welcome_text_len = . - WELCOME_TEXT
BUFOR:
  .space BUFOR_SPACE 
  buf_len = . - BUFOR
ENDL:
  .ascii "\n"
#--------------------------------------------
.globl _start
_start:
  movl $WELCOME_TEXT, %ecx
  movl $welcome_text_len, %edx
  call PRINT

  jmp EXIT_PROG 
#---------------------------------------------
PRINT:
  movl $WRITE, %eax
  movl $STDOUT, %ebx
  int $SYSCALL
  ret

READ:
  movl $READ, %eax
  movl $STDIN, %ebx
  int $SYSCALL
  ret

EXIT_PROG:
  movl $EXIT, %eax
  movl $EXIT_SUCCESS, %ebx
  int $SYSCALL
