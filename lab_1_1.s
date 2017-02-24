EXIT = 1
READ = 3
WRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0
SYSCALL = 0x80
BUFOR_SPACE = 254

.section .data
WELCOME_TEXT:
  .ascii "Podaj ciag liter: "
  welcome_text_len = . - WELCOME_TEXT
BUFOR:
  .space BUFOR_SPACE
  buf_len = . - BUFOR

.globl _start
_start:
  movl $WRITE, %eax
  movl $STDOUT, %ebx
  movl $WELCOME_TEXT, %ecx
  movl $welcome_text_len, %edx
  int $SYSCALL

  movl $READ, %eax
  movl $STDIN, %ebx
  movl $BUFOR, %ecx
  movl $buf_len, %edx   
  int $SYSCALL

  movl $WRITE, %eax
  movl $STDOUT, %ebx
  movl $BUFOR, %ecx
  movl $buf_len, %edx
  int $SYSCALL

  movl $EXIT, %eax
  movl $EXIT_SUCCESS, %ebx
  int $SYSCALL
