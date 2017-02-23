SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

.data
text_zachecajacy:
  .string "Podaj znak: "
  len = . - text_zachecajacy

bufor:
  .space 1000
  bufor_len = 10
    

.text
.global _start
_start:
  movl $SYSWRITE, %eax
  movl $STDOUT, %ebx
  movl $text_zachecajacy, %ecx
  movl $len, %edx
  int $0x80

  movl $SYSREAD, %eax
  movl $STDIN, %ebx
  movl $bufor, %ecx
  movl $bufor_len, %edx
  int $0x80

  movl $SYSWRITE, %eax
  movl $STDOUT, %ebx
  movl $bufor, %ecx
  movl $bufor_len, %edx
  int $0x80

  movl $SYSEXIT, %eax
  movl $EXIT_SUCCESS, %ebx
  int $0x80

