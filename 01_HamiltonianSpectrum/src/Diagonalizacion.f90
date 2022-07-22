! This program diagonalize the LMG Hamiltonian and prints
! the energy spectrum Ek
 program Diagonalizacion

   use MathTools
   implicit none
   double precision x
   integer :: i,n,j
   integer, allocatable :: r1(:), r2(:)
   real(8), allocatable :: m0p(:,:),m1p(:,:),m2p(:,:),evls1(:),evls2(:)

   ! Here we ask for "j" this will define the order of the matrix
   print*, 'Introduce j:'
   read*, j
   n=2*j+1

   ! Here we assign the order of arrays
   allocate(m0p(n,n))
   allocate(m1p(j+1,j+1)) !Positive parity
   allocate(evls1(j+1))
   allocate(r1(j+1))
   allocate(m2p(j,j))     !Negative parity
   allocate(evls2(j))
   allocate(r2(j))


   ! Here we call range (from MathTools.f90)
   call range(n, j, r1, r2)

   ! We must make the diagonalization for positive and negative parity
   x = 0.0
   ! First we call gmx for postive parity
   open(10, file = 'Ek_Positive.dat', status = 'unknown')
   do i=1, 51
      call gmx(x,m1p,j+1,j,r1,evls1)
      write(10,*) -x, evls1(:)/j
      x = x - 0.1
   end do
   close(10)

   x = 0.0

   ! Second we call gmx for negative parity
   open(20, file = 'Ek_Negative.dat', status = 'unknown')
   do i=1, 51
      call gmx(x,m1p,j,j,r2,evls2)
      write(20,*) -x, evls1(:)/j
      x = x - 0.1
   end do
   close(20)
   
end program Diagonalizacion
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
