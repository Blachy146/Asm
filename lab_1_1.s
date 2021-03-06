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

  movl $0x0, %ecx

start:
  movb BUFOR(%ecx,1), %bl
  cmpb $0, %bl
  jz end
  jmp checkIfLower
next:
  inc %ecx
  inc %ecx
  jmp start
checkIfLower:
  cmpb $'a', %bl
  jb checkIfUpper
  cmp $'z', %bl
  ja next
  jmp toUpper
checkIfUpper:
  cmpb $'A', %bl
  jb next
  cmpb $'Z', %bl
  ja next
  jmp toLower
toUpper:
  subb $0x20, %bl
  movb %bl, BUFOR(%ecx,1)
  jmp next
toLower:
  addb $0x20, %bl
  movb %bl, BUFOR(%ecx,1)
  jmp next
end:
  movl %ecx, %edx
  movl $BUFOR, %ecx
  movl $STDOUT, %ebx
  movl $WRITE, %eax
  int $SYSCALL    

  movl $EXIT, %eax
  movl $EXIT_SUCCESS, %ebx
  int $SYSCALL
