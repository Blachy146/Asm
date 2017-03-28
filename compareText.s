SYSEXIT = 1
EXIT_SUCCESS = 0
WRITE = 4
STDOUT = 1
READ = 3
STDIN = 0
SYSCALL = 0x80
BUFOR_SIZE = 16

.data
  .comm bufor, BUFOR_SIZE

.text
memory_string:
  .ascii "Napis testowy"
  memory_string_len = . - memory_string
newline:
  .ascii "\n"
  newline_len = . - newline
the_same:
  .ascii "TAKIE SAME!!!\n"
  the_same_len = . - the_same
different:  
  .ascii "INNE!!!\n"
  different_len = . - different
.global _start
_start:
  movl $memory_string, %ecx
  movl $memory_string_len, %edx
  call COUT

  movl $newline, %ecx
  movl $newline_len, %edx
  call COUT

  movl $bufor, %ecx
  movl $BUFOR_SIZE, %edx
  call CIN

  #comparing memory_string and bufor
  movl $0, %edi
  movl $0, %esi
  movl $0, %eax
FOR1:
  movb memory_string(,%edi,1), %al
  cmp $memory_string_len, %edi
  je END_AND_THE_SAME
  movb bufor(,%esi,1), %bl
  cmp %al, %bl
  je INC
  jmp END_AND_DIFFERENT

INC:
  inc %edi
  inc %esi
  jmp FOR1

END_AND_THE_SAME:
  movl $the_same, %ecx
  movl $the_same_len, %edx
  call COUT
  jmp END 
END_AND_DIFFERENT:
  movl $different, %ecx
  movl $different_len, %edx
  call COUT
  jmp END 
  

END:
  movl $SYSEXIT, %eax
  movl $EXIT_SUCCESS, %ebx
  int $SYSCALL
#===============================
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

