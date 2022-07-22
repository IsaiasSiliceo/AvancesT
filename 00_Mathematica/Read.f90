  ! This program read high precision data
program read_data
  implicit none
  integer :: i
  integer, parameter :: k40 = selected_real_kind(16)
  double precision :: x(101), eval, VecP(101,101), Ek(101)

  open(10, file = 'Eigenvalues.dat', status = 'old')
  do i=1, 101
     read(10,*) eval
     x(i) = eval
  end do
  close(10)

  do i=1,101
     print*,i,precision(x(i)), x(i)
  end do

  open(30, file = 'Eigenvectors.dat',status = 'old')
  do i=1,101
     read(30,*) Ek(:)
     VecP(i,:) = Ek(:)
  end do
  print*, VecP(1,:)

120 format(F42.37) 
  
end program read_data
