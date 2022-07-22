!******************
! compile as:
! gfortran -o LGMdiagonalization ./DiagonalizatorLGM.f90 -L/usr/local/lib -llapack -lblas
!************************
! Example of matrix diagonalization using LAPACK routine dsyev.f and the ! 
! Fortran 90 interface diasym.f90.                                       !
!------------------------------------------------------------------------!
! Programa por Daniel Julian Nader                                       !
!     -  diagonaliza LGM Model en representacion SU(2)                   !
!     -  Calcula representacion de Husimi                                !
!     -  Calcula entropia                                                !
!     -  Calcula segundo momento                                         !
!************************************************************************!

!---------------!
 program LGMmodel
!---------------!

   !
   !********* definicion de variables******************************
   !
   
 implicit none

 integer k,nn

 INTEGER, PARAMETER :: DP = SELECTED_REAL_KIND(16)

 integer :: i,ii,j,jq,jj,kk,kkk,n,nMC,m,mq
 real(8), allocatable :: m0p(:,:),m1p(:,:),m2p(:,:),eigp(:)
 real(8), allocatable :: m0n(:,:),m1n(:,:),m2n(:,:),eign(:)
 real(8), allocatable :: Q(:),ThetaL(:),PhiL(:)
 real(8) :: epsilon,uMC, w, v, gammax, gammay  ! Hamiltoniano
 real(DP) :: alabs,alere,aleim,theta,phi  ! Husimi
 real(DP) :: Q2temp,QM2,Q2sum,Qpsitemp,Qpsi,Wtemp,Wpsi  ! Husimi

 real(DP) :: Qh,u,vv,delta,bin,pi,Qc,Pc

 pi=3.14159265359
 


!read(10,*)n

  !**************  Lectura de datos  ****************
 
 print*,"Angular Momentum J"
 read*, jj
 print*,"gap energy epsilon (parameter)"
 read*, epsilon
 print*,"gammax (parameter)"
 read*, gammax
 print*,"gammay (parameter)"
 read*, gammay
 print*,'Husimi QE_k'
 read*,ii 

 v=epsilon*(gammax-gammay)/(2.0*(2.0*jj-1.0))
 w=epsilon*(gammax+gammay)/(2.0*(2.0*jj-1.0))

  ! ************   Diagonalizacion       ****************

 
! n=ndcp      ! Define el tamaño de la matriz igual a las raices del polinomio


 
 allocate (m0p(jj+1,jj+1))
 allocate (m1p(jj+1,jj+1))
 allocate (m2p(jj+1,jj+1))
 allocate (eigp(jj+1))
 allocate (m0n(jj,jj))
 allocate (m1n(jj,jj))
 allocate (m2n(jj,jj))
 allocate (eign(jj))
 allocate (Q(30000))
 allocate (ThetaL(30000))
 allocate (PhiL(30000))



 
!!$ !********************************************************************
!!$ ! ************Encuentra los elementos de matriz**********************
!!$ !********************************************************************
 ! comienza todos los elementos en zero para evitar errores
do i=1,jj
do j=1,jj
   m0p(i,j)=0.0
 enddo
enddo

do i=1,jj-1
do j=1,jj-1
   m0p(i,j)=0.0
 enddo
enddo


 !!**** Elementos diagonales**********!

 do i=0,jj
    m0p(i+1,i+1)=epsilon*(-jj+2*i)+(w)*(jj*(jj+1)-(-jj+2*i)**2)    ! <------   !!!paridad positiva
 enddo


 do i=0,jj-1
    m0n(i+1,i+1)=epsilon*(-jj+2*i+1)+(w)*(jj*(jj+1)-(-jj+2*i+1)**2)    ! <------   !!!paridad negativa
 enddo



 !!**** Elementos fuera de la diagonal**********!
  ! terminos no diagonales

    do i=0,jj-1
       m0p(i+1,i+2)=1.0*(v/2.0)*(jj*(jj+1)-(-jj+2*i+2)*((-jj+2*i+2)-1))**(1.0/2.0)* &
           & (jj*(jj+1)-((-jj+2*i+2)-1)*((-jj+2*i+2)-2))**(1.0/2.0)  ! <------   !!!paridad positiva            
    enddo

    do i=0,jj-2
       m0n(i+1,i+2)=1.0*(v/2.0)*(jj*(jj+1)-(-jj+2*i+3)*((-jj+2*i+3)-1))**(1.0/2.0)* &
           & (jj*(jj+1)-((-jj+2*i+3)-1)*((-jj+2*i+3)-2))**(1.0/2.0) ! <------   !!!paridad negativa
    enddo




 do i=0,jj-1
    m0p(i+2,i+1)=m0p(i+1,i+2)         ! <------   !!!paridad positiva
 enddo

 do i=0,jj-2
    m0n(i+2,i+1)=m0n(i+1,i+2)         ! <------   !!!paridad negativa
 enddo

  
 ! cuestion tecnica iguala m1=m0

 m1p(:,:)=m0p(:,:)
 m1n(:,:)=m0n(:,:)

! Llama a la rutina que diagonaliza la matriz
 call diasym(m1p,eigp,jj+1)
 call diasym(m1n,eign,jj)

 




!******************************************************************************
 !                           Impresion de resultados
!******************************************************************************
! do k=1, n   ! Imprime raizes
!  print*,' root ', k ,' = ',R(k)
   !  end do

!***parametros*******!
print*,'Diagonalization'
print*, 'Angular momentum= ', jj
print*,'Parameters'
print*,'epsilon= ',epsilon
print*,'gammax= ',gammax
print*,'gammay= ',gammay



!***Energias******!

 print*,'Eigenvalues (positive parity):'
 do i=1,jj+1
    !if (eig(i)< 0.0) then
     print*,i,eigp(i)
!    10 format(I3,'   ',f14.8)
     !endif
  enddo

 print*,'Eigenvalues (negative parity):'
 do i=1,jj
    !if (eig(i)< 0.0) then
     print*,i,eign(i)
!    10 format(I3,'   ',f14.8)
     !endif
  enddo 

   print*,'**************************'
   print*,'Husimi Representation    *'
   print*,'see files:               *'
   print*,'         resultsp+QP.dat *'
   print*,'         resultsp-QP.dat *'
   print*,'**************************'


!****vectores propios***!

!!$    print*,'Eigenvector:'
!!$    do i=1,jj+1
!!$    print*,i,m1p(i,:)
!!$     20 format(i3,'   ',10f14.8)
!!$    enddo
!!$ print*,

!!$!******************************************************************************
!*****Husimi e impresion en un archivo de datos*********!
!******************************************************************************
!  open(1,file='resultsp+QP.dat',status='new')

!  write(1,*)'# ********Parameters**********  #'
!  write(1,*)'# angular momentum',jj
!  write(1,*)'# Epsilon',epsilon
!  write(1,*)'# gammax',gammax
!  write(1,*)'# gammay',gammay
!  write(1,*)'# Epsilon',epsilon
!  write(1,*)'# Husimi Q(i)',ii
!  write(1,*)'# positive parity '
!  write(1,*)'# ****************************  #'
!  write(1,*)'#            u                          v                          Q #'

  nn=100
  delta=pi/(nn*1.0d0)
  theta=0.0d0
  kkk=0
  do k=0,nn
     phi=0.0d0
     do kk=0,2*nn
  !***Husimi************!
   alabs=1.0d0*tan(theta/2.0)
   alere=0.0d0
   aleim=0.0d0
   do m=0,jj
   call binomial(2*jj,jj+(-jj+2*m),bin)
   alere=alere+m1p(m+1,ii)*(1.0/(1.+alabs**2.0)**jj)*  &
         &  bin**(1./2.)*((alabs)**(jj+(-jj+2*m)))*cos((jj+(-jj+2*m))*phi)
   aleim=aleim-m1p(m+1,ii)*(1.0/(1.+alabs**2.0)**jj)*  &
         &  bin**(1./2.)*((alabs)**(jj+(-jj+2*m)))*sin((jj+(-jj+2*m))*phi)
   enddo
   Qh= 1.0d0*(alere**2.0+aleim**2.0)
   Qc=sqrt(2*(1.0d0-cos(theta)))*cos(phi)
   Pc=-sqrt(2*(1.0d0-cos(theta)))*sin(phi)
   kkk=kkk+1
   Q(kkk) = Qh
   ThetaL(kkk)=theta
   PhiL(kkk)=phi
   write(1,*)Qc, '  ',Pc, '  ',Qh !,' ',theta,' ',phi

   phi=phi+delta
   enddo
   theta=theta+delta
   enddo
   
!   close(1)

!!$  open(2,file='resultsp-.dat',status='new')
!!$
!!$  write(2,*)'# ********Parameters**********  #'
!!$  write(2,*)'# angular momentum',jj
!!$  write(2,*)'# Epsilon',epsilon
!!$  write(2,*)'# gammax',gammax
!!$  write(2,*)'# gammay',gammay
!!$  write(2,*)'# Epsilon',epsilon
!!$  write(2,*)'# Husimi Q(i)',ii
!!$  write(2,*)'# negative parity '
!!$  write(2,*)'# ****************************  #'
!!$  write(2,*)'#            u                          v                          Q #'
!!$
!!$  nn=100
!!$  delta=pi/(nn*1.0d0)
!!$  theta=0.0d0
!!$  do k=0,nn
!!$     phi=0.0d0
!!$     do kk=0,2*nn
!!$  !***Husimi************!
!!$   alabs=1.0d0*tan(theta/2.0)
!!$   alere=0.0d0
!!$   aleim=0.0d0
!!$   do m=0,jj
!!$   call binomial(2*jj,jj+(-jj+2*m+1),bin)
!!$   alere=alere+m1n(ii,m+1)*(1.0/(1.+alabs**2.0)**jj)*  &
!!$         &  bin**(1./2.)*((alabs)**(jj+(-jj+2*m+1)))*cos((jj+(-jj+2*m+1))*phi)
!!$   aleim=aleim-m1n(ii,m+1)*(1.0/(1.+alabs**2.0)**jj)*  &
!!$         &  bin**(1./2.)*((alabs)**(jj+(-jj+2*m+1)))*sin((jj+(-jj+2*m+1))*phi)
!!$   enddo
!!$   Qh= 1.0d0*(alere**2.0+aleim**2.0)
!!$   u=(1.0d0-cos(theta))*cos(phi)
!!$   vv=(1.0d0-cos(theta))*sin(phi)
!!$   write(2,*)u, '  ',vv, '  ',Qh
!!$
!!$   phi=phi+delta
!!$   enddo
!!$   theta=theta+delta
!!$   enddo
!!$
!!$   
!!$  close(2)


!********* segundo momento de la funcion de Husimi y entropia *************!
   Q2sum=0d0
   Qpsitemp=0d0
   Wtemp=0d0
        nMC=1e7
       do i=1, nMC
          call random_number(uMC)
          jq = 1 + FLOOR((kkk)*uMC)
          Q2temp=(Q(jq)*Q(jq))*sin(ThetaL(jq))
          Q2sum=Q2sum+Q2temp
          Qpsitemp=Qpsitemp+(Q(jq))*sin(ThetaL(jq))
          Wtemp=Wtemp-(Q(jq))*log(Q(jq))*sin(ThetaL(jq))
       enddo

       Qpsi=2*pi*pi*Qpsitemp*((2.0*jj+1)/(4*pi))/nMC
       QM2=((4.0*jj+1)/(2*jj+1))*((2.0*jj+1)/(4*pi))*2*pi*pi*(Q2sum/(nMC))
       Wpsi=((2.0*jj+1)/(4*pi))*2*pi*pi*(Wtemp/(nMC))
       
       print*,'first  moment of Husimi rep  <Q>     :',Qpsi 
       print*,'second moment of Husimi rep  <Q^2>   :',QM2
       print*,'Entropy       of Husimi rep -<Q lnQ>):',Wpsi
       print*,'flag',ThetaL(kkk),PhiL(kkk)
   


  
  m2p=matmul(transpose(m1p),m0p)
  m0p=matmul(m2p,m1p)


! print*,'Transformed matrix (check):'
! do i=1,n
!    print*,m0(:,i)
!    30 format(10f14.8)
! enddo
! print*,

  deallocate(m0p); deallocate(m1p); deallocate(m2p);  deallocate(eigp)

 end program LGMmodel


!-------------------!

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


!********   Subrutina que calcula el coeficiente binomial ****!
 
subroutine binomial(x,y,b)
     implicit none

     INTEGER, PARAMETER :: DP = SELECTED_REAL_KIND(16)
     integer :: x, y, i
     REAL(DP) :: b, binnum, binden1, binden2

     binnum=1.0d0
     do i=0,X-1
     binnum=binnum*(X-i)
     enddo
     binden1=1.0d0
     do i=0,Y-1
     binden1=binden1*(Y-i)
     enddo
     binden2=1.0
     do i=0,X-Y-1
     binden2=binden2*(X-Y-i)
     enddo
     b=1.0d0*(binnum/(binden1*binden2))

     end subroutine binomial
