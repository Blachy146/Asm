EXIT = 1
READ = 3
WRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0
SYSCALL = 0x80
BUFOR_SPACE = 254
SPACE = 32

.align 32 

.data
  .comm BUFOR, 100
  .comm buf_len, 4
  .comm NUMS, 4
  .comm TMP, 1
.text
  WELCOME_TEXT:
    .ascii "Podaj znaki(hex): "
    welcome_text_len = . - WELCOME_TEXT
  ENDL:
    .ascii "\n"
    endl_len = . - ENDL
#--------------------------------------------
.global _start
_start:
  #print message
  mov $WELCOME_TEXT, %ecx
  mov $welcome_text_len, %edx
  call COUT
  
  #read input
  mov $BUFOR, %ecx
  mov $100, %edx
  call CIN
  mov %eax, buf_len
  
  #strip buf_len
  mov buf_len, %eax
  sub $1, %eax
  mov %eax, buf_len
  
  #init vars
  mov $1, %ecx
  movl $0, NUMS

  #scan bufor form the end store 4 bytes at separated memory adresses  
  mov buf_len, %esi
  sub $1, %esi
FOR1:
  cmp $0, %esi
  jl END_FOR1
  
  #check if small or big letter or number
  xor %eax, %eax
  mov BUFOR(, %esi), %al
  cmp $SPACE, %al
je GOT_SPACE
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

GOT_SPACE:
  mov $1, %ecx

OUT:
  dec %esi
  jmp FOR1

END_FOR1:
  mov NUMS, %eax
  mov $2, %ebx
  call PRINT_BASE
  mov $8, %ebx
  call PRINT_BASE
  mov $10, %ebx
  call PRINT_BASE
  mov $16, %ebx
  call PRINT_BASE
  call PRINT_ENDL

  mov $EXIT, %eax
  mov $EXIT_SUCCESS, %ebx
  int $SYSCALL
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

PRINT_ENDL:
  movl $ENDL, %ecx
  movl $endl_len, %edx
  call COUT
  ret

PRINT_BASE:
  push %rax
  xor %esi, %esi
FOR3:
  xor %edx, %edx
  div %ebx
  push %rdx
  inc %esi
  cmp $0, %eax
  jne FOR3
FOR4:
  cmp $0, %esi
  je END_FOR4
  pop %rcx
  cmp $10, %ecx
  jl LESS
  add $7, %ecx
LESS:
  add $48, %ecx
  mov %ecx, TMP
  mov $TMP, %ecx
  mov $1, %edx
  call COUT
  dec %esi
  jmp FOR4
END_FOR4:
  call PRINT_ENDL
  pop %rax
  ret

