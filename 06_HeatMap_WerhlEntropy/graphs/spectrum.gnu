set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 768,1024 enhanced color
set output 'j50.png'
#set terminal postscript eps size 4,6 enhanced color font 'Helvetica,14' linewidth 0.5
#set output 'J100.eps'

set title font 'HelveticaBold, 15'
set title 'Energy spectrum LMG Model (j=100,{/Symbol g}_y=3{/Symbol g}_x)'
set ylabel 'E_k' rotate by 0 left
set xlabel '|{/Symbol g}_x|'
set grid
unset key
set yrange[-8.5:1.5]
set xrange[0:5]

set arrow 1 from 3.9,-2.5 to 4.5,-2.5 lw 2 lc 7 nohead
set arrow 2 from 3.9,-2.5 to 3.9,-1.8 lw 2 lc 7 nohead
set arrow 3 from 3.9,-1.8 to 4.5,-1.8 lw 2 lc 7 nohead
set arrow 4 from 4.5,-1.8 to 4.5,-2.5 lw 2 lc 7 nohead

plot for [i=2:102] 'Ek_Positive_100.dat' using 1:i with lines lc 8
#plot for [i=2:52] 'Ek_Positive.dat' using 1:i with lines lc 8

set terminal pop
set output
