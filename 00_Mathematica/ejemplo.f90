program real_kinds
  integer,parameter :: p6 = selected_real_kind(6)
  integer,parameter :: p10r100 = selected_real_kind(10,100)
  integer,parameter :: r400 = selected_real_kind(r=400)
  real(kind=p6) :: x
  real(kind=p10r100) :: y
  real(kind=r400) :: z

  x=1
  y=2
  z=3
  print *,x, precision(x), range(x)
  print *,y, precision(y), range(y)
  print *,z, precision(z), range(z)
end program real_kinds
