.data poczatek danych
napis: #etykieta napis widoczna tylko dla kodu programu (bez .global)
  .string "hello world!\n" #napis widoczny pod adresem etykiety
  len = . - napis #dlugosc napisu (. to aktualny adres w pamieci - koniec napisu)
.text #kod pragramu
.global _start #etykieta globalna
_start: #zawartosc etykiety start
  movl $4, %eax #movl-zapis do 32 bit rejestru, 4 w EAX(funkcje systemowe) to write,
  movl $1, %ebx #1 w EBX(plik docelowy) to standardowe wyjscie,
  movl $napis, %ecx #ECX - adres z danymi do wyswietlenia
  movl $len, %edx #EDX - dlugosc napsiu
  int $0x80 #wywolanie przerwania i realizacja czynnosci hello world

  movl $1, %eax #exit z argumentem 0
  movl $0, %ebx
  int $0x80
