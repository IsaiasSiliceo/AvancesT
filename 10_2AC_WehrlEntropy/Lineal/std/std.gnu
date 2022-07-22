
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output "StdDev.png" 
file= 'tabla.dat'

set title '{/:Bold=16 Parameter {/Symbol s} of Gaussian fits}'
set log y
set log x
set grid lw 2
set key top left
set ylabel 'Parameter {/Symbol s}'
set xlabel '{/Symbol D} E_i'
A=3.03628
B=3.42203
C=3.58996
D=4.77428
E=9.71588
F=28.5363
a=-10e-14
b=-10e-14
c=-10e-14
d=-10e-14
e=-10e-14
f=-10e-14

f(x) = A*x
g(x) = B*x
h(x) = C*x
i(x) = D*x
j(x) = E*x
k(x) = F*x

styles = '"#FF0000" "#FF4500" "#006400" "#008080" "#4B0082" "#FF1493" "#778899" "#000000"'

do for[t=1:8]{
	set style line t lt rgb word(styles, t) lw 2
}

fit f(x) file using 1:2 index 0 via A
fit g(x) file using 1:2 index 1 via B
fit h(x) file using 1:2 index 2 via C
fit i(x) file using 1:2 index 3 via D
fit j(x) file using 1:2 index 4 via E
fit k(x) file using 1:2 index 5 via F

set label '{/Helvetica y_{140}=3.03628x }' at 1e-6, 1e-7
set label '{/Helvetica y_{156}=3.42203x }' at 1e-6, 1e-8
set label '{/Helvetica y_{170}=3.58996x }' at 1e-6, 1e-9
#set label '{/Helvetica y_{172}=4.95568x }' at 1e-6, 1e-10
set label '{/Helvetica y_{174}=4.77428x }' at 1e-6, 1e-10
set label '{/Helvetica y_{186}=9.71588x }' at 1e-6, 1e-11
set label '{/Helvetica y_{196}=28.5363x }' at 1e-6, 1e-12


plot for [i=0:5] file using 1:2:3 index i with yerrorbars ls i+1 notitle, f(x) ls 1 title 'N=140', g(x) ls 2 title 'N=156', h(x) ls 3 title 'N=170', i(x) ls 4 title 'N=174', j(x) ls 5 title 'N=186', k(x) ls 6 title 'N=196'


#plot file using 1:2:3 index 0 with yerrorbars lw 2 lc 6 notitle, f(x) lw 2 lc 6 title 'N=140',file using 1:2:3 index 1 with yerrorbars lw 2 lc 8 dt 4 notitle, g(x) lw 2 lc 8 title 'N=156',file using 1:2:3 index 2 with yerrorbars lw 2 lc 7 notitle, h(x) lw 2 lc 7 dt 2 title 'N=170', file using 1:2:3 index 3 with yerrorbars lw 2 lc 1 notitle, i(x) lw 2 lc 1 title 'N=172', file using 1:2:3 index 4 with yerrorbars lw 2 lc 2 notitle, j(x) lw 2 lc 2 title 'N=174', file using 1:2:3 index 5 with yerrorbars lw 2 lc 4 notitle, k(x) lw 2 lc 4 title 'N=186', file using 1:2:3 index 6 with yerrorbars lw 2 lc 10 notitle, l(x) lw 2 lc 10 title 'N=196'

