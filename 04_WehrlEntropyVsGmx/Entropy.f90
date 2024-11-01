!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!! Programa para calcular Entropía de Wehrl !!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! compile as:
! gfortran -o Entropy ./Entropy.f90 -L/usr/local/lib -llapack -lblas
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program Entropy

  implicit none
  integer k, res, y, Ite
  double precision x, Wint, A(20000)
  double precision, dimension(51):: GXValues
  integer, dimension (16) :: KValues
  double precision, dimension(size(KValues)) :: tempint
  real :: step
  integer :: i,ii,n,m,j,jj,l
  integer, allocatable :: r(:)
  real(8), allocatable :: m0p(:,:),m1p(:,:),evls(:),Ek(:)
  
  !Aquí se definen los pasos para gamma x
  x = -4 !First value of gamma x
  step  = 0.004 ! Steps of gamma x
  do i=1, 51
     GXValues(i) = x
     x = x-step
  end do

  y = 62!First K value
  do i=1, 16
     KValues(i) = y
     y = y + 1
  end do
  
  ! 1) Pedimos un j, se calcula el valor de n y se construye un rango r de -j a j para los valores de m
  print*, 'Introduce un valor de j:'
  read*, j
  n=2*j+1
  print*, '----------------------------------------------'
  print*, 'Introduce el número de iteraciones de Monte Carlo'
  read*, Ite
  print*, 'Kvalues:'
  print*, KValues(:)

  ! Asignamos el tamaño a las matrices de nxn
  allocate(m0p(n,n))
  allocate(m1p(n,n))
  allocate(evls(n))
  allocate(r(n))
  allocate(Ek(n))
  print*, 'El rango de la matriz es:', n
  call range(n,j,r)
  print*

  ! comienza todos los elementos en zero para evitar errores
  do i=1,n
     do ii=1,n
        m0p(i,ii)=0.0
     end do
  end do

  ! 2) Vamos a llamar a gmx para calcular una lista de eigenvectores para un valor de gammax particular
  m1p(:,:)=m0p(:,:)
  
  ! 3) Se inicia el ciclo
  open(30 ,file= 'WEntropy.dat', status= 'unknown')
  do i=1, size(GXValues)
     ! Llamamos a gmx para diagonalizar para un valor particular gmx
     call gmx(GXValues(i),m1p,n,j,r,evls)
     print*, 'Paso:', i
     do ii=1, size(KValues)
        Ek(:) = m1p(:,KValues(ii))
        call EvalHusimi(j,r,Ek,A)
        call IntegradorMC(j,A,Ite,Wint)
        tempint(ii) = Wint
     end do
     write(30,*) -GXValues(i), tempint(:)
     print*, -GXValues(i), tempint(:)
  end do
  close(30)

 print*, 'This is the list of k values'
 print*, KValues(:)
 print*, 'This is the list of gmx values'
 print*, GXValues(:)
 

  print*, '--------------------------------------------------'
  print*, 'File: "Entropy.dat"'
end program Entropy

!!!-------------------------------------------------------------!!!
!!!                     IntegradorMC                            !!!
!!!-------------------------------------------------------------!!!
subroutine IntegradorMC(j,A,Ite,Wint)
  double precision :: Wint, suma, promedio,x, elemento, A(20000), factor
  real(8) :: Pi=acos(-1.0)
  integer :: i,j
  
  Wint = 0.0 !Se inicia el valor de la integral
  suma= 0.0
  promedio=0.0
  
  do i=1, Ite ! Este debe ser Ite nada más
     ! Necesitas debbuggear primero Prueba.f90
     !Seleccionar un elemento aleatorio de A
     call random_number(x)
     !elemento = A(int(x*size(A))+1)
     elemento = A(i)
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

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!! EvalHusimi recibe j, r-> Rango de -j a j en pasos de 1
!!!! un Eigenvector Ek y retorna una lista A de evaluaciones
!!!! Luego se calcula la entropía utilizando MonteCarlo.
subroutine EvalHusimi(j,r,Ek,A)
  double precision :: phi, theta, P, Q, Hus, delta,  A(20000)
  integer :: r(2*j+1), aux, j 
  double precision :: Ek(2*j+1)
  double precision :: Pi=acos(-1.0) 

  theta=0.0
  delta = Pi/100.0
  aux = 1
  A(:) = 0.0
  do i=1, 100
     phi = 0.0 ! Se reinicia phi
     do ii=1, 200
        call Husimi(j,r,theta,phi,Ek,Hus,P,Q)
        A(aux)= Hus*sin(theta)*log(Hus)
        aux = aux +1
        phi = phi + delta
     end do
     theta = theta + delta
  end do
end subroutine EvalHusimi

!!!!-----------------------------------------------------------------!!!!
!!!!                            HUSIMI                               !!!!
!!!! Para un valor particular de theta, phi
!!!! Retorna Hus, P, Q
!!!!-----------------------------------------------------------------!!!

subroutine Husimi(j,r,theta,phi,Ek,Hus,P,Q)
  integer :: j, n, i, ii
  integer :: r(n)
  complex(8) :: alpha, z, alphC, suma1
  double precision :: phi, theta, b, d, Hus, P, Q, Ek(2*j+1)
  double precision :: h
  double precision :: Pi = acos(-1.0)

  ! Aquí se calcula alpha para un theta y phi en particular.
  z= cmplx(cos(phi),-sin(phi))
  alpha = tan(theta/2.0)*z
  alphC = conjg(alpha)
  suma1 = cmplx(0.0,0.0,kind(0d0)) !! suma1 comienza en cero
  n=2*j+1

  ! Se calcula P y Q
  Q=sqrt(2*(1-cos(theta)))*cos(phi)
  P=-sqrt(2*(1-cos(theta)))*sin(phi)
  !! Calculamos una sola suma y le sacamos el valor absoluto al cuadrado
  h=1/(1+abs(alpha)**2)**j
  do i=1, n
     call binomial(2*j,j+r(i),b)
     suma1 = suma1 + Ek(i)*sqrt(b)*(alphC)**(j+r(i))
  end do

  !Se calcula finalmente el valor de Q(alpha)
  Hus= abs(h*suma1)**2
end subroutine Husimi

!!!!-----------------------------------------------------------------!!!!
!!!!                         BINOMIAL                                !!!!
!!!!-----------------------------------------------------------------!!!!
subroutine binomial(x,y,b)
     implicit none
     integer :: x, y, i
     double precision :: b
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
!!!!------------------------------------------------------------------!!!!
!!!!                        Rango -j a j en pasos de 1                !!!!
!!!!  n - tamaño del arreglo, j-límites del arreglo, rango(2j+1)      !!!!
!!!!------------------------------------------------------------------!!!!
 subroutine range(n,j,rango)
   integer i,ii,w
   integer rango(n)
   
   w=-j
   do i=1,n
      if (w < 0) then
         rango(i)=w
      else if(w == 0) then
         rango(i)=0
      else
         rango(i)= w
      end if
      w=w+1
   end do
 end subroutine range

!!!!-----------------------------------------------------------------!!!!
!!!! gmx gives eigenvalues & eigenvectors of A for a particular      !!!!
!!!! value of x(gammax), here we assume gammay=3gammax, hbar=1,      !!!!
!!!! eps=1                                                           !!!!
!!!!-----------------------------------------------------------------!!!!
 subroutine gmx(x,A,n,j,r,eigp)
   integer h,k,m,l,p,q,i,ii
   integer r(n)
   double precision x
   double precision :: A(n,n), B(n,n)
   double precision sqr1, sqr2
   real(8):: eigp(n)
   h= 2*j-1
   A(:,:)=0.0
   
   do i=1,n
      k=r(i)
      do ii=1,n
         m=r(ii)
         call kronecker(m,k,l)
         call kronecker(m+2,k,p)
         call kronecker(m-2,k,q)
         !print*, l,p,q,k,m
         sqr1= p*((j*(j+1)-m*(m+1))*(j*(j+1)-(m+1)*(m+2)))**0.5
         sqr2= q*((j*(j+1)-m*(m-1))*(j*(j+1)-(m-1)*(m-2)))**0.5
         A(i,ii)=m*l-0.5*(x/h)*(sqr1 + sqr2 - 4*l*(j*(j+1)-m**2))
      end do
   end do
   ! Se llama a la rutina para diagonalizar A
   call diasym(A,eigp,n)
 end subroutine gmx



!---------------------------------------------------------!
!Calls the LAPACK diagonalization subroutine DSYEV        !
!input:  a(n,n) = real symmetric matrix to be diagonalized!
!            n  = size of a                               !
!output: a(n,n) = orthonormal eigenvectors of a           !
!        eig(n) = eigenvalues of a in ascending order     !
!---------------------------------------------------------!
 subroutine diasym(a,eig,n)
 implicit none

 integer n,l,inf
 real*8  a(n,n),eig(n),work(n*(3+n/2))

 l=n*(3+n/2)
 call dsyev('V','U',n,a,n,eig,work,l,inf)

 end subroutine diasym


!!!!------------------------------------------------------!!!!
!!!!                Subroutine Kronecker Delta            !!!!
!!!!------------------------------------------------------!!!!
 subroutine kronecker(m,k,res)
   implicit none
   integer k, m, res

   if (k == m) then
      res=1
   else
      res=0
   end if
 end subroutine kronecker
