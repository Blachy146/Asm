
.align 32

.data
  number1:
    .int 10
  number2:
    .int 100 
  number3:
    .float 20.5
  number4:
    .float 111.1
  number5:
    .double 1.45
  number6:
    .double 3.11
  format_str:
    .ascii "%d\n\0"

.text
.global main 
main:
  #print C function
  call print
  
  #add two int and printf
  push number1
  push number2
  call addTwoIntAndPrint 
  
  #add two float and printf
  mov number4, %eax
  push %eax
  mov number3, %eax
  push %eax
  call addTwoFloatAndPrint

  #add two double and printf
BREAK:
  push number5+4
  push number5
  push number6+4
  push number6
  call addTwoDoubleAndPrint

  call exit
