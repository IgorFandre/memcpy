  .intel_syntax noprefix

  .text
  .global my_memcpy

my_memcpy:
  push rbp
  mov rbp, rsp
  mov eax, 0
  
  // Счетчик для цикла
  // edx содержит count по calling conventions
  
  add eax, 8
  cmp edx, eax
  jl stop_big_loop
 
 big_loop:   // В этом цикле читаем по 8 байт
  sub eax, 8
  mov rcx, [rsi + rax]
  mov [rdi + rax], rcx
  add eax, 16
  cmp edx, eax
  jge big_loop
  

 stop_big_loop:
  sub eax, 8
  add eax, 1
  cmp edx, eax
  jl stop_small_loop
  // Если кратно 64, то закончили читать

 small_loop:   // В этом цикле читаем по 1 байту
  sub eax, 1
  mov cl, [rsi + rax]
  mov [rdi + rax], cl
  add eax, 2
  cmp edx, eax
  jge small_loop

 stop_small_loop:

  mov rax, rdi
  mov rsp, rbp
  pop rbp
  ret

