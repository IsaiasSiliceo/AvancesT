!gnuplot> set size square
!gnuplot> set xrange[0:2*3.1415]
!gnuplot> set yrange[0:2*3.1415]
!gnuplot> plot 'Kdata.dat' using 1:2:-1 lc var pt 7 ps 0.25 title 'K=0.5'
program kick
  implicit none
  integer i, ii, j
  real(4) :: K, Pi= acos(-1.0), delta, x0, p0, p, pn, xn1, xn, pn1

  !We want o iterate the two expresions for p and x over an interval
  ! 0-> 2pi 0->2pi. Write all these points x,p

  !We start defining p0, and K
  K=0.97

  delta= Pi/50
  x0=0.0
  p0=0.0
  
  open(10, file= 'Kdata.dat',status= 'unknown')
  do i=1, 100
     do ii=1, 50
        pn1 = mod(p0 + K*sin(x0),2*Pi)
        xn1 = mod(x0 + pn1,2*Pi)
        write(10,*) xn1, pn1
        x0 = xn1
        p0 = pn1
     end do
     write(10,*)
     p0 = p0 + delta
  end do
  close(10)
end program kick
