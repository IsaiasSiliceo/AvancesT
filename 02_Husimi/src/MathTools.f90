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

  !Subroutine to calculate the kronecker delta
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

  !Subroutine that calculates binomial coefficients
  subroutine binomial(x,y,b)
    implicit none
    integer, intent (in) :: x, y
    integer :: i
    double precision, intent (out) :: b
    double precision :: binnum, binden1, binden2
    binnum = 1.0
    do i=0,X-1
       if (X == Y) then
          exit
       else if (Y == (X-i)) then
          exit
       else if ((X-i) ==(X-Y)) then
          exit
       end if
       binnum=binnum*(X-i)
    end do
    !print*, binnum
    binden1 = 1.0

    do i=0,Y-1
       if (X == Y) then
          exit
       else if (Y == (X-i)) then
          binden1=1.0
          exit
       end if
       binden1 = binden1*(Y-i)
    end do
    !print*, binden1
    binden2 = 1.0

    do i=0,X-Y-1
       if (X==(X-Y)) then
          binden2 = 1.0
          exit
       else if ((X-i) ==(X-Y)) then
          binden2 =1.0
          exit
       end if
       binden2=binden2*(X-Y-i)
    end do
    !print*, binden2

    b=binnum/(binden1*binden2)

  end subroutine binomial

  ! Subroutine to calculate a Monte Carlo integral
  subroutine IntegradorMC(j,A,Ite,Wint)
    !double precision :: Wint, suma, promedio,x, elemento, A(20000), factor
    real(8) :: Pi=acos(-1.0)
    integer, parameter :: p20 = selected_real_kind(16,3)
    real(kind=p20) ::  Wint, A(20301), x, factor, suma, promedio, elemento
    integer, intent (in) :: j, Ite 
    integer :: i

    Wint = 0.0 !Se inicia el valor de la integral
    suma= 0.0
    promedio=0.0

    do i=1, Ite ! Este debe ser Ite nada más
       ! Necesitas debbuggear primero Prueba.f90
       !Seleccionar un elemento aleatorio de A
       call random_number(x)
       elemento = A(int(x*size(A))+1)
       !elemento = A(i)
       if (elemento .ne. elemento) then
          suma = suma + 0.0
       else
          suma = suma + elemento
       end if
    end do
    !print*, A(19800:20000)
    promedio =-suma/(Ite)
    factor = (2*j+1)/(4*Pi)
    Wint=2*factor*Pi*Pi*promedio

  end subroutine IntegradorMC

end module MathTools

