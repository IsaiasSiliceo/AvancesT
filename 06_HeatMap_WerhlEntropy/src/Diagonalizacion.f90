! This program diagonalize the LMG Hamiltonian and prints
! the energy spectrum Ek as a function of gammax
 program Entropy
   use MathTools
   implicit none
   double precision x, deltax
   integer :: i,ii,n,j,Ite,states(10)
   real :: start, end, end1, start1
   integer, allocatable :: r1(:), r2(:)
   real(8), allocatable :: m1p(:,:),evls1(:),Ek1(:)
   !real(8), allocatable :: m2p(:,:),evls2(:),Ek2(:)
   integer, parameter :: p20 = selected_real_kind(16,3)
   real(kind=p20) :: Wint, A(20301)
   
   ! Here we ask for "j" this will define the order of the matrix
   print*, 'Introduce j:'
   read*, j
   n=2*j+1

   ! Here we assign the order of arrays
   !allocate(m0p(n,n))
   allocate(m1p(j+1,j+1)) !Positive parity
   allocate(evls1(j+1))
   allocate(r1(j+1))
   allocate(Ek1(j+1))
   !allocate(m2p(j,j))     !Negative parity
   !allocate(evls2(j))
   allocate(r2(j))
   !allocate(Ek2(j))


   ! Here we call range (from MathTools.f90)
   call range(n, j, r1, r2)

   print*, '--------------------------------------------------'
   ! Here we define the number of MonteCarlo Iterations
   Ite = 300000000

   states = (/60,62,64,66,68,61,63,65,67,69/)
   ! We want to iterate over gamma x from -4.5 to -4.0
   ! so we define a deltax
   deltax = 0.0125
   
   open(40, file = 'Wehrl.dat', status = 'unknown')
   call cpu_time(start)
   do ii=1,10 ! Number of states
      ! This cycle calculates for a particular value of gmx
      x=-4.5 ! Start gammax
      print 100, states(ii)
      call cpu_time(start1)
      do i=1, 48
         ! we call the gmx to  make the Hamiltonian and diagonalization
         call gmx(x,m1p,j+1,j,r1,evls1)
         Ek1(:) = m1p(:,states(ii)) !Ek1 is a temporal location
         call EvalHusimi(j,r1,j+1,Ek1,A) !A temporal location
         call IntegradorMC(j,A,Ite,Wint)
         write(40,120) -x,evls1(states(ii))/j,Wint
         print 120, -x,evls1(states(ii))/j,Wint
         x = x + deltax
         print*, 'Intermediate step: ', i
      end do
      call cpu_time(end1)
      print*,'time execution per state:', (end1-start1)/60, 'minutes'
      write(40,*)
   end do
   close(40)
   call cpu_time(end)
   
   print*, 'Total time execution: ', (end-start)/60, ' minutes'
   print*, 'file = "Wehrl.dat" ordered per states'
   !print*, 'file = "Sorted.dat" ordered per gammax'
   
120 format(F18.16,4x,F19.16,4x,F22.20)
100 format('State: ',i4)

   ! Agregar un ciclo que ordene los datos con respecto a gamma x

 end program Entropy

 subroutine EvalHusimi(j,r,m,Ek,C)
   use MathTools
   integer ::j, m, r(m), aux
   double precision :: Ek(m)
   integer, parameter :: p20 = selected_real_kind(16,3)
   real(kind=p20) :: Hus, P, Q, Wint, theta, phi, C(20301)
   double precision :: delta
   real(8) :: Pi=acos(-1.0)

   C(:)=0.0
   ! Now we calculate the integral iterating over theta and phi
   theta=0.0
   delta = Pi/100.0
   Wint=0.0
   aux = 1
   do i=0, 100
      phi = 0.0 ! Se reinicia phi
      do ii=0, 200
         call Husimi(j,r,m,theta,phi,Ek,Hus,P,Q)
         C(aux) = Hus*sin(theta)*log(Hus)
         aux = aux + 1
         phi = phi + delta
      end do
      theta = theta + delta
   end do

 end subroutine EvalHusimi
 
 ! Husimi subroutine calculates the husimi Q(alpha) for a particular
 ! value of theta, phi, m is the size of r, Ek is a particular eigenvector

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
