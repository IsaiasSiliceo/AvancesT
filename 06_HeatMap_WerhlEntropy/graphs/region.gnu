set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 600,600 enhanced color
set output 'Region.png'

set size square
set xlabel '|{/Symbol g}_x|'
set ylabel 'E_i / j' rotate by 0

plot 'WehrlPares(copia).dat' using 1:2 with lines lw 2 lc 7 title 'Even','WehrlImpares(copia).dat' using 1:2 with lines lw 2 lc 6 title 'Odd','AC.dat' using 1:2 with lines lw 2 lc 8 dt 2 title 'AC'

set terminal pop
set output
