program sort
  implicit none
  integer, parameter :: states = 5
  double precision :: gmx, energy
  integer, parameter :: p20 = selected_real_kind(16,3)
  real(kind=p20) :: integral
  integer :: i,j,k

  do i=0, 47
     open (10, file = 'Wehrl48.dat',status = 'old')
     call ordena(i)
     close(10)
  end do
  
120  format(F18.16,4x,F19.16,4x,F22.20)
     
end program sort

subroutine ordena(skip)
  implicit none
  integer ::  skip, i, j
  double precision :: gmx, energy
  integer, parameter :: p20 = selected_real_kind(16,3)
  real(kind=p20) :: integral

  open(40, file = 'Sorted.dat', action='write', position = 'append')
  ! First we skip certain number of lines
  if (skip /= 0) then
     do i=1, skip
        read(10,120)
     end do
  end if
  
  do j=1, 10
     read(10,120) gmx, energy, integral
     write(40,120) gmx, energy, integral
     if (j /= 10) then
        do i=1, 48
           read(10,120)
        end do
     end if
  end do
  write(40,*)
  write(40,*)
  close(40)
120  format(F18.16,4x,F19.16,4x,F22.20)
  
  
end subroutine ordena
