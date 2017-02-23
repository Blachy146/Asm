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
  

.text
.global _start
_start:
  movl $SYSWRITE, %eax
  movl $STDOUT, %ebx
  movl $text_zachecajacy, %ecx
  movl $len, %edx
  int $0x80

  movl $SYSEXIT, %eax
  movl $EXIT_SUCCESS, %ebx
  int $0x80

