
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output "DeltaEiVsEi.png" 
file= 'CompleteData.dat'

set title '{/:Bold=16 {/Symbol D}E_i as a function of energy}'
set log y
set grid lw 2
set key top right
set yrange [1e-14:0.01]
set xrange [0:4.5]
set ylabel '{/Symbol D}E_{N}'
set xlabel 'E_{N(mean)} - ESQPT_N'


styles = '"#FF0000" "#FF4500" "#006400" "#008080" "#4B0082" "#FF1493" "#778899" "#000000"'

names =  '"N=140" "N=156" "N=170" "N=174" "N=186" "N=196"'

a=100
f(x)=A*exp(-a*x)
g(x)=B*exp(-b*x)
h(x)=C*exp(-c*x)
i(x)=D*exp(-d*x)
j(x)=E*exp(-e*x)
k(x)=F*exp(-f*x)

do for[t=1:8]{
	set style line t lt rgb word(styles, t) lw 2
}

fit f(x) file using ($3-$4):2 index 0 via A,a
fit g(x) file using ($3-$4):2 index 1 via B,b
fit h(x) file using ($3-$4):2 index 2 via C,c
fit i(x) file using ($3-$4):2 index 3 via D,d
fit j(x) file using ($3-$4):2 index 4 via E,e
fit k(x) file using ($3-$4):2 index 5 via F,f

plot for [i=0:5] file index i using ($3-$4):2 ls i+1 notitle, f(x) ls 1 title word(names,1), g(x) ls 2 title word(names,2), h(x) ls 3 title word(names,3), i(x) ls 4 title word(names,4), j(x) ls 5 title word(names,5), k(x) ls 6 title word(names,6)  

