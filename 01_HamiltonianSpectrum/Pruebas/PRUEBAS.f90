module MathTools
  ! Here we define the Mathematical tools that does not need lapack
  implicit none
contains

  ! Subroutine to generate a range of numbers m 
  subroutine range(n,j,rango1,rango2)
    integer, intent (in) ::  j, n
    integer, intent (out) :: rango1(j+1)  !Positive parity
    integer, intent (out) :: rango2(j)    !Negative parity
    integer :: i, w, rango(n)

    w = j
    !First i create a range from -j to j with steps of 1
    do i=1, n
       if (w < 0) then
          rango(i) = w
       else if (w == 0) then
          rango(i) = 0
       else
          rango(i) = w
       end if
       w = w-1
    end do

    !Now we assign the positive parity to rango1(j+1)
    do i=1, j+1
       rango1(i) = rango(2*i-1)
    end do

    !Now we assign the negative parity to rango2(j)
    do i=1, j
       rango2(i) = rango(2*i)
    end do
       
  end subroutine range
  
end module MathTools

!!!!! PRUEBAS !!!
program PRUEBAS
  use MathTools
  implicit none
  integer :: j, n
  integer, allocatable ::  Rpos(:), Rneg(:)

  print*, 'I want to know if my subroutine works fine '
  print*, 'Introduce j'
  read*, j
  
  n= 2*j+1
  allocate(Rpos(j+1))
  allocate(Rneg(j))

  ! We call range() a subroutine of the MathTools_module
  call range(n,j,Rpos,Rneg)
  print*, Rpos
  print*, '---------------------------------'
  print*, Rneg
end program PRUEBAS
