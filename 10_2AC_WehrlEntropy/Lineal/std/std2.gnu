
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output "Std2.png" 
file= 'tabla.dat'

set title '{/:Bold=16  Log({/Symbol s}) of Gaussian fits as a function of energy difference}'
set grid lw 2
set key top left
set ylabel 'Log({/Symbol s_N})'
set xlabel 'Log({/Symbol D} E_N)'

f(x) = A*x+a
g(x) = B*x+b
h(x) = C*x+c
i(x) = D*x+d
j(x) = E*x+e
k(x) = F*x+f

styles = '"#FF0000" "#FF4500" "#006400" "#008080" "#4B0082" "#FF1493" "#778899" "#000000"'

do for[t=1:8]{
	set style line t lt rgb word(styles, t) lw 2
}

fit f(x) file using (log($1)):(log($2)) index 0 via A,a
fit g(x) file using (log($1)):(log($2)) index 1 via B,b
fit h(x) file using (log($1)):(log($2)) index 2 via C,c
fit i(x) file using (log($1)):(log($2)) index 3 via D,d
fit j(x) file using (log($1)):(log($2)) index 4 via E,e
fit k(x) file using (log($1)):(log($2)) index 5 via F,f

set label '{/Helvetica y_{140}=1.00278x+1.12056 }' at -15, -22
set label '{/Helvetica y_{156}=1.00368x+1.21929 }' at -15, -24
set label '{/Helvetica y_{170}=1.03204x+1.60843 }' at -15, -26
set label '{/Helvetica y_{174}=1.05406x+2.0883 }' at -15, -28
set label '{/Helvetica y_{186}=1.01634+2.44515}' at -15, -30
set label '{/Helvetica y_{196}=1.05312x+4.18118 }' at -15, -32


plot for [i=0:5] file using (log($1)):(log($2)) index i ls i+1 notitle, f(x) ls 1 title 'N=140', g(x) ls 2 title 'N=156', h(x) ls 3 title 'N=170', i(x) ls 4 title 'N=174', j(x) ls 5 title 'N=186', k(x) ls 6 title 'N=196'


#plot file using 1:2:3 index 0 with yerrorbars lw 2 lc 6 notitle, f(x) lw 2 lc 6 title 'N=140',file using 1:2:3 index 1 with yerrorbars lw 2 lc 8 dt 4 notitle, g(x) lw 2 lc 8 title 'N=156',file using 1:2:3 index 2 with yerrorbars lw 2 lc 7 notitle, h(x) lw 2 lc 7 dt 2 title 'N=170', file using 1:2:3 index 3 with yerrorbars lw 2 lc 1 notitle, i(x) lw 2 lc 1 title 'N=172', file using 1:2:3 index 4 with yerrorbars lw 2 lc 2 notitle, j(x) lw 2 lc 2 title 'N=174', file using 1:2:3 index 5 with yerrorbars lw 2 lc 4 notitle, k(x) lw 2 lc 4 title 'N=186', file using 1:2:3 index 6 with yerrorbars lw 2 lc 10 notitle, l(x) lw 2 lc 10 title 'N=196'

