! This program diagonalize the LMG Hamiltonian and prints
! the Q,P,Hus data to plot the Husimi Representation Only for Positive Parity
! J=100
 program HusimiRep

   use MathTools
   implicit none
   double precision x
   real :: start, end
   integer :: i,n,j, states(8)
   integer, allocatable :: r1(:), r2(:)
   real(8), allocatable :: m1p(:,:),evls1(:),Ek1(:)
   !real(8), allocatable :: m0p(:,:),m2p(:,:),evls2(:),Ek2(:)
   
   ! Here we ask for "j" this will define the order of the matrix
   !print*, 'Introduce j:'
   j=100
   n=2*j+1
   x = -4.103310841740555
   

   ! Here we assign the order of arrays
   !allocate(m0p(n,n))
   allocate(m1p(j+1,j+1)) !Positive parity
   allocate(evls1(j+1))
   allocate(r1(j+1))
   allocate(Ek1(j+1))
   allocate(r2(j))


   ! Here we call range (from MathTools.f90)
   call range(n, j, r1, r2)

   open(10, file = 'states/Evecs.dat', status = 'old')
   do i=1, j+1
      read(10,*) m1p(:,i)
   end do
   close(10)
   
   print*, '--------------------------------------------------'

   ! Here we define a list of states:
   states = (/10,11,12,13,14,15,16,17/)
   
   call cpu_time(start)
   
   do i=1, size(states)
      Ek1(:) = m1p(:,states(i))
      call EvalHusimi(j,r1,j+1,Ek1,states(i))
   end do
   call cpu_time(end)
   print*, '--------------------------------------------------'
   print*, 'Total time execution', (end-start)/60, 'minutes'
   print*, 'gamma x: ', x
   print*, 'Files: "QP_state.dat"'

 end program HusimiRep

 ! This subroutine does not save values to calculate the Wehrl Entropy
  subroutine EvalHusimi(j,r,m,Ek,k)
   use MathTools
   integer ::j, m,k, r(m)
   double precision :: Ek(m)
   integer, parameter :: p20 = selected_real_kind(16,3)
   real(kind=p20) :: Hus, P, Q, theta, phi
   double precision :: delta
   real(8) :: Pi=acos(-1.0)
   character(len=16) :: file2
   real :: start1, end1

   ! Here we assing the state file
   call cpu_time(start1)
   write (file2, "(A10,I2,A4)") "states/QP_",k,".dat"
   open(20, file = file2, status= 'unknown')
   ! Now we calculate the integral iterating over theta and phi
   theta=0.0
   delta = Pi/100.0
   do i=0, 100
      phi = 0.0 ! Se reinicia phi
      do ii=0, 200
         call Husimi(j,r,m,theta,phi,Ek,Hus,P,Q)
         write(20,*) Q, P, Hus
         phi = phi + delta
      end do
      theta = theta + delta
      write(20,*)
   end do
   close(20)
   call cpu_time(end1)
   print*, 'State:', k ,'|Time execution: ', end1-start1, 'seconds'

 end subroutine EvalHusimi
 
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
