program prueba
  implicit none
  integer :: i
  double precision :: x
  character(len=12) :: filename

  write (filename, "(A6,I2,A4)") "Evals/",6,".dat"

  print *, trim(filename)
  open(10, file = filename, status = 'old')

  do i=1, 101
     read(10,*) x
     print*,i, x
  end do
  close(10)
end program prueba
