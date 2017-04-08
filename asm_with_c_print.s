
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
  
  #add two double and printf
  mov number4, %eax
  push %eax
  mov number3, %eax
  push %eax
  call addTwoDoubleAndPrint

  call exit
