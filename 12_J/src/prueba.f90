program prueba
  ! Esta es una prueba para verificar que el binomial funciona
  ! para números muy grandes.
  ! Así como solucionar los problemas de Underflow
  ! gfortran -o prueba MathTools.f90 prueba.f90 
  use MathTools
  integer :: j, r, n,i
  integer, parameter :: p20 = selected_real_kind(16,3)
  real(kind=p20) :: b
  integer, allocatable :: r1(:), r2(:)


  print*, 'Introduce j para calcular binomial:'
  read*, j
  n=2*j+1
  allocate(r1(j+1))
  allocate(r2(j))
  
  call range(n,j,r1,r2)
  print*, r1(:)

  do i=1, j+1
     call binomial(2*j,j+r1(i),b)
     print*, 2*j, j+r1(i), b
  end do
  

  !print*, 'El valor del coeficiente binomial es:'
  !print*, b
end program prueba
