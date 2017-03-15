SYSEXIT = 1
EXIT_SUCCESS = 0
WRITE = 4
STDOUT = 1
READ = 3
STDIN = 0
SYSCALL = 0x80

.data
buf:
  .ascii "     "
  buf_len = . - buf

.text
msg:
  .ascii "Write text (5): \n"
  msg_len = . - msg
msg2:
  .ascii "Writen text: "
  msg2_len = . - msg2
newline:
  .ascii "\n"
  newline_len = . - newline
.global _start
_start:
  movl $msg, %ecx
  movl $msg_len, %edx
  call COUT

  movl $buf, %ecx
  movl $buf_len, %edx
  call CIN

  movl $msg2, %ecx
  movl $msg2_len, %edx
  call COUT
  

  movl $buf, %ecx
  movl $buf_len, %edx
  call COUT 

  movl $newline, %ecx
  movl $newline_len, %edx
  call COUT

movl $SYSEXIT, %eax
movl $EXIT_SUCCESS, %ebx
int $SYSCALL
#===========================
COUT:
  movl $WRITE, %eax
  movl $STDOUT, %ebx
  int $SYSCALL
  ret
CIN:
  movl $READ, %eax
  movl $STDIN, %ebx
  int $SYSCALL
  ret

