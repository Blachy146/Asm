SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
STDIN = 0
EXIT_SUCCESS = 0

.data
napis:
  .string "hello world!!!\n"
  len = .-napis

.text
.global _start
_start:
  movl $SYSWRITE, %eax
  movl $STDOUT, %ebx
  movl $napis, %ecx
  movl $len, %edx
  int $0x80

  movl $SYSEXIT, %eax
  movl $EXIT_SUCCESS, %ebx
  int $0x80 
