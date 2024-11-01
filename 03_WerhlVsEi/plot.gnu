set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output 'EntropyVsEi.png'
#set terminal postscript eps size 6,4 enhanced color font 'Helvetica,16' linewidth 1
#set output 'J100.eps'

set title font 'HelveticaBold, 16'
set title 'Wehrl Entropy as a function of the Energy E_i ({/Symbol g}@^{AC}_{x}  = -2.87232)'
set ylabel 'Entropy'
set xlabel 'E_i / j'
set grid
#unset key
set yrange[1:4]
set xrange[-7:1]

plot 'WehrlVsEi.dat' using 1:2 every 2::1 with linespoints lw 2 title 'i=2j', 'WehrlVsEi.dat' using 1:2 every 2 with linespoints lw 2 title 'i=2j+1', 'dotline.dat' with lines dt 2 lw 2 lc -1 notitle

set terminal pop
set output