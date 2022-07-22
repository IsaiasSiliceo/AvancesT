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

  subroutine kronecker(m,k,res)
    implicit none
    integer, intent (in) :: m, k
    integer, intent (out):: res

    if (k == m) then
       res=1
    else
       res=0
    end if
  end subroutine kronecker
  
end module MathTools

