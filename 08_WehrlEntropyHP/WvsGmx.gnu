set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output '76-77(mejorado).png'

set title "{/:Bold=16 Wehrl entropy as a function of |{/Symbol g}_x|,  j=100" \

#Comandos para el formato
#set xtics rotate by 45 right
set key top left
set xtics rotate by 45 right
set xtics format "%.15f"
set xrange [4.10331084174055:4.10331084174056]
set yrange [2.5:3.9]
set xlabel '|{/Symbol g}_x|'
set ylabel 'W_E' rotate by 0 offset 2

set arrow 1 from 4.103310841740555,2.5 to 4.103310841740555,3.9 lw 1 dt 2 lc 8 nohead

plot 'Wehrl.dat' using 1:3 index 0 with linespoints title 'k=70' lw 2,'Wehrl.dat' using 1:3 index 1 with linespoints title 'k=71' lw 2


unset multiplot
set terminal pop
set output
