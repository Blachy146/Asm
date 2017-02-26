EXIT = 1
READ = 3
WRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0
SYSCALL = 0x80
BUFOR_SPACE = 10

.section .data
WELCOME_TEXT:
  .ascii "Podaj ciag znakow(hex): "
  welcome_text_len = . - WELCOME_TEXT
BUFOR:
  .space BUFOR_SPACE 
  buf_len = . - BUFOR
ENDL:
  .ascii "\n"
  endl_len = . - ENDL
.comm NUMS, 4
.comm TMP, 1
#--------------------------------------------
.globl _start
_start:
  #print message
  movl $WELCOME_TEXT, %ecx
  movl $welcome_text_len, %edx
  call COUT
  
  #read input
  movl $BUFOR, %ecx
  movl $buf_len, %edx
  call CIN
  movl %eax, buf_len
  
  #strip buf_len
  movl buf_len, %eax
  subl $1, %eax
  movl %eax, buf_len
  
  #init vars
  movl $1, %ecx
  movl $0, NUMS

  #scan bufor form the end store 4 bytes at separated memory adresses  
  movl buf_len, %esi
  sub $1, %esi
FOR1:
  cmp $0, %esi
  jl FOR1
  
  #check if small or big letter or number
  cmp $97, %al
  jge SMALL_LETTER            #got small letter
  cmp $65 ,%al
  jge BIG_LETTER              #got big letter          
  sub $48, %al                #got number
  jmp STORE_VALUE
SMALL_LETTER:
  sub $87, %al
  jmp STORE_VALUE
BIG_LETTER:
  sub $55, %al
  jmp STORE_VALUE 

STORE_VALUE:
  mul %ecx                     #val * m ???
  add %eax, NUMS

  movl %ecx, %eax              # m *= 16 ???
  movl $16, %edx
  mul %edx
  mov %eax ,%ecx
  jmp OUT 

OUT:
  dec %esi
  jmp FOR1


  jmp EXIT_PROG 
#---------------------------------------------
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

EXIT_PROG:
  movl $EXIT, %eax
  movl $EXIT_SUCCESS, %ebx
  int $SYSCALL
