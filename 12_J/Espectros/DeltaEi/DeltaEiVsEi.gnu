
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output "DeltaEiVsEi.png" 
file= 'DeltaEi.dat'

set title '{/:Bold=16 {/Symbol D}E_i as a function of energy}'
#set log y
set grid lw 2
set key top right
set yrange [-32:0]
set xrange [0:0.6]
set ylabel 'log({/Symbol D}E_{N})'
set xlabel 'E_{N(mean)} - ESQPT_N'


styles = '"#FF0000" "#FF4500" "#006400" "#008080" "#4B0082" "#FF1493" "#778899" "#000000"'

names =  '"J=100, N=170" "J=200, N=340" "J= 500, N=850" "J=800, N=1358" "J=1000, N=1698"'


f(x)=A*x+a
g(x)=B*x+b
h(x)=C*x+c
i(x)=D*x+d
j(x)=E*x+e

do for[t=1:8]{
	set style line t lt rgb word(styles, t) lw 2
}

fit f(x) file using 1:(log($2)) index 0 via A,a
fit g(x) file using 1:(log($2)) index 1 via B,b
fit h(x) file using 1:(log($2)) index 2 via C,c
fit i(x) file using 1:(log($2)) index 3 via D,d
fit j(x) file using 1:(log($2)) index 4 via E,e


plot for [i=0:4] file index i using 1:(log($2)) ls i+1 notitle, f(x) ls 1 title word(names,1), g(x) ls 2 title word(names,2), h(x) ls 3 title word(names,3), i(x) ls 4 title word(names,4), j(x) ls 5 title word(names,5)

