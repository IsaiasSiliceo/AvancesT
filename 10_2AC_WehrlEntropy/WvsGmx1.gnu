set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color

set output '76-77.png'
file = 'N196/76-77.dat'
state1 = 'k=76'
state2 = 'k=77'
AC = 28.72317589218388

set title '{/:Bold=16|{/Symbol g}@_x^{AC}|=28.72317589218388, N=196'

#Comandos para el formato
set key top left
set xtics rotate by 45 right
#set xtics format "%.9f"
#set xrange [4.416:4.422]
#set yrange [3.2:3.8]

set xlabel '|{/Symbol g}_x|'
set ylabel 'W_E' rotate by 0 offset 2


set arrow 1 from AC,graph 0 to AC,graph 1 lw 1 dt 2 lc 8 nohead

plot file using 1:3 index 0 with linespoints title state1 lw 2, file using 1:3 index 1 with linespoints title state2 lw 2


set terminal pop
set output
