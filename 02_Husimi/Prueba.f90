program real_kinds
  integer :: i
  integer,parameter :: p6 = selected_real_kind(16,3)
  integer,parameter :: p10r100 = selected_real_kind(10,100)
  integer,parameter :: r400 = selected_real_kind(r=400)
  real(kind=p6) :: x(10),y(10),p(10),des, prom
  complex(kind=p6) :: z

  x = (/2.92942163738524505821,2.92964472199364924995,2.93126076705982919601,&
       2.92930237440140715604,2.93086715868645627170,2.93005361046194054116,&
       2.92988890426858572037,2.93012929447810255247,2.93041914658901789139,&
       2.92979924737519960049/)

  call desv(x,prom,des)
  print*, prom, des
  print*
  

  y = (/2.93139080668831280944,2.92981378477671384358,2.92975684147312976941,&
       2.93235818145082454745,2.92591508695755883260,2.93520731946386157852,&
       2.93103112118762075002,2.93050590841621304218,2.92594762666327796530,&
       2.93239033809827934684/)
  call desv(y,prom,des)
  print*, prom, des
  print*

  p = (/3.18373726506253751129,3.18213634769345345490,3.18278678467584431443,&
       3.18445117196250492746,3.18466448037025563972,3.18425327233448402062,&
       3.18369750092333437261,3.18317481609979289060,3.18299693819233191238,&
       3.18286989964494783562/)
  call desv(p,prom,des)
  print*, prom, des
  

end program real_kinds

subroutine desv(A,prom,des)
  integer,parameter :: p6 = selected_real_kind(16,3)
  real(kind=p6) :: A(10),des, prom, sum

  sum=0.0
  prom=0.0
  do i=1, 10
     prom = prom +A(i)
  end do
  prom=prom/10.0
  
  do i=1, 10
     sum = sum + (A(i) -prom)**2
  end do

  des=sqrt(sum/10.0)
  
  
  
end subroutine desv
