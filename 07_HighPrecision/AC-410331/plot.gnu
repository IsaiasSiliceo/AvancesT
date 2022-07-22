set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 16' size 1100,768 enhanced color
set output 'EntropyVsEi.png'
#set terminal postscript eps size 6,4 enhanced color font 'Helvetica,16' linewidth 1
#set output 'J100.eps'

set title font 'HelveticaBold, 16'
set title 'Wehrl and Entanglement Entropy as a function of the Energy E_i ({/Symbol g}@^{AC}_{x}  = -4.103310841740555)'
set ylabel 'Entropy'
set xlabel 'E_i / j'
set grid
#unset key
set yrange[1:4]
set xrange[-7:1]

plot 'WehrlVsEi.dat' using 1:2 every 2::1 with linespoints lw 2 title 'Even W', 'WehrlVsEi.dat' using 1:2 every 2 with linespoints lw 2 title 'Odd W', 'dotline.dat' with lines dt 2 lw 2 lc -1 notitle,'EEntropyVsEi.dat' using ($1/100):2 every 2::1 with linespoints lw 2 lc 6 title 'Even E', 'EEntropyVsEi.dat' using ($1/100):2 every 2 with linespoints lw 2 lc 7 title 'Odd E'

set terminal pop
set output
