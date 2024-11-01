! This program diagonalize the LMG Hamiltonian and prints
! the Q,P,Hus data to plot the Husimi Representation
 program HusimiRep

   use MathTools
   implicit none
   double precision x
   real :: start, end
   integer :: i,ii,n,j,k,aux,Ite
   integer, allocatable :: r1(:), r2(:)
   real(8), allocatable :: m0p(:,:),m1p(:,:),evls1(:),Ek1(:)
   real(8), allocatable :: m2p(:,:),evls2(:),Ek2(:)
   integer, parameter :: p20 = selected_real_kind(16,3)
   real(kind=p20) :: Hus, P, Q, Wint, theta, phi, A(20301), B(20301)
   double precision :: delta
   real(8) :: Pi=acos(-1.0)
   
   ! Here we ask for "j" this will define the order of the matrix
   print*, 'Introduce j:'
   read*, j
   n=2*j+1

   ! Here we assign the order of arrays
   allocate(m0p(n,n))
   allocate(m1p(j+1,j+1)) !Positive parity
   allocate(evls1(j+1))
   allocate(r1(j+1))
   allocate(Ek1(j+1))
   allocate(m2p(j,j))     !Negative parity
   allocate(evls2(j))
   allocate(r2(j))
   allocate(Ek2(j))


   ! Here we call range (from MathTools.f90)
   call range(n, j, r1, r2)

   ! We must make the diagonalization for positive parity
   ! and a particular value of gmx
   print*, 'Introduce el valor de gamma x:'
   read*, x
   call cpu_time(start)
   call gmx(x,m1p,j+1,j,r1,evls1)
   call cpu_time(end)
   print*, 'La diagonalización duró ', end-start, ' segundos'
   call gmx(x,m2p,j,j,r2,evls2)

   !print*, 'Positive parity eigenvalues:'
   !do i=1,j+1
    !  print*, i,evls1(i)
   !end do
   !print*, '-----------------------------------------------'
   !print*, 'Negative parity eigenvalues:'
   !do i=1,j
    !  print*, i,evls2(i)
   !end do
   print*, '--------------------------------------------------'
     
   
   ! We ask for a particular value of k. to get the positive parity
   print*, 'Elije un estado k de los j+1 posibles '
   read*, k
   Ek1(:) = m1p(:,k)
   ! Now we calculate the integral iterating over theta and phi
   theta=0.0
   delta = Pi/100.0
   Wint=0.0
   aux = 1
   open(20, file = 'QPos.dat', status = 'unknown')

   call cpu_time(start)
   do i=0, 100
      phi = 0.0 ! Se reinicia phi
      do ii=0, 200
         call Husimi(j,r1,j+1,theta,phi,Ek1,Hus,P,Q)
         A(aux) = Hus*sin(theta)*log(Hus)
         write(20,*) Q, P, Hus
         aux = aux + 1
         phi = phi + delta
      end do
      theta = theta + delta
      write(20,*)
   end do
   close(20)
   call cpu_time(end)
   
   print*, 'El cálculo de la función de Husimi duró ', end-start, ' segundos'
   ! We ask for a particular of k to get the negative parity
   Ek2(:) = m2p(:,k)

   ! Now we calculate the integral iterating over theta and phi
   theta=0.0
   delta = Pi/100.0
   Wint=0.0
   aux = 1
   open(30, file = 'QNeg.dat', status = 'unknown')

   do i=0, 100
      phi = 0.0 ! Se reinicia phi
      do ii=0, 200
         call Husimi(j,r2,j,theta,phi,Ek2,Hus,P,Q)
         B(aux) = Hus*sin(theta)*log(Hus)
         write(30,*) Q, P, Hus
         aux = aux + 1
         phi = phi + delta
      end do
      theta = theta + delta
      write(30,*)
   end do
   close(30)

   
   ! We ask for a number of Monte Carlo iterations 
   print*, 'Introduce el número de Iteraciones Monte Carlo'
   read*, Ite

   ! Here we call the integradorMC to calculate the Wehrl Entropy
   !Positive parity
   call cpu_time(start)
   call IntegradorMC(j,A,Ite,Wint)
   call cpu_time(end)
   print*, 'La integral duró ', end-start, ' segundos'
   print*, '--------------------------------------------------'
   print*, 'Wehrl Entropy: ', Wint
   print*, 'Parameters:'
   print 100, j, k
100 format(' j= ',i4,2x,'k= ',i4)
   print*, 'File: "QPos.dat"'

   !Here we call the IntegradorMC to calculate the Wehrl Entropy
   !Negative Parity
   call IntegradorMC(j,B,Ite,Wint)
   print*, '--------------------------------------------------'
   print*, 'Wehrl Entropy: ', Wint
   print*, 'Parameters:'
   print 100, j, k
   print*, 'File: "QNeg.dat"'
   print*, '--------------------------------------------------'
   
 end program HusimiRep

 ! Husimi subroutine calculates the husimi Q(alpha) for a particular
 ! value of theta, phi, m is the size of r

 subroutine Husimi(j,r,m,theta,phi,Ek,Hus,P,Q)
   use MathTools
   integer :: j, n, i,m
   integer :: r(m)
   integer, parameter :: p20 = selected_real_kind(16,3)
   complex(kind=p20) :: alpha, z, alphC, suma1
   double precision :: b, Ek(m)
   real(kind=p20) :: Hus, P, Q, theta, phi, h

   ! Aquí se calcula alpha para un theta y phi en particular.
   z= cmplx(cos(phi),-sin(phi),kind=p20)
   alpha = tan(theta/2.0)*z
   alphC = conjg(alpha)
   suma1 = cmplx(0.0,0.0,kind=p20) !! suma1 comienza en cero
   n=2*j+1


   ! Se calcula P y Q
   Q=sqrt(2*(1-cos(theta)))*cos(phi)
   P=-sqrt(2*(1-cos(theta)))*sin(phi)
   !! Calculamos una sola suma y le sacamos el valor absoluto al cuadrado
   h=1/(1+abs(alpha)**2)**j
   do i=1, m ! We define m for the size of r(m)
      call binomial(2*j,j+r(i),b)
      suma1 = suma1 + Ek(i)*sqrt(b)*(alphC)**(j+r(i))
   end do

   !Se calcula finalmente el valor de Q(alpha)
   Hus= abs(h*suma1)**2
 end subroutine Husimi

!!!!-----------------------------------------------------------------!!!!
!!!! gmx gives eigenvalues & eigenvectors of A for a particular      !!!!
!!!! value of x(gammax), here we assume gammay=3gammax, hbar=1,      !!!!
!!!! eps=1                                                           !!!!
!!!!-----------------------------------------------------------------!!!!
subroutine gmx(x,A,n,j,r,eigp)
  use MathTools
   integer h,k,m,l,p,q,i,ii
   integer r(n)
   double precision x
   double precision :: A(n,n)
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
!---------------------!
