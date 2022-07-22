! Ejemplo de programa que lee una matriz 5x5
program ReadMatrix
  integer :: i, j
  integer :: matriz(5,5) ! Ya que es una matriz de enteros 5x5

  !abrimos la matriz
  open(20, file = 'matriz.dat', status='unknown')
  print*, 'Se lee la matriz 5x5 de enteros del archivo "matriz.dat"'
  print*
  do i=1,5
     read(20,*) matriz(i,:) !Leemos el primer renglón de elementos
  end do
  !cerramos la matriz
  close(20)

  print*
  print*, 'Probando que todo marcha en orden, se imprime la matriz:'
  print*
  
  do i=1, 5
     print*, matriz(i,:)
  end do

end program ReadMatrix
