set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 800,600 enhanced color
set output 'Surface.png'


set title 'Entropy as a function of the E_i and |{/Symbol g}_x|'
set size square
set ticslevel 0
set view 60, 150
set xlabel '|{/Symbol g}_x|'
set ylabel 'Ei / j'
set zlabel 'W_E' offset 1,1,1

set xrange[3.9:4.5]
set yrange[-2.5:-1.8]
set zrange[2:4]
a=2/3.3
splot for [N=0:47] 'Sorted(copia).dat' i 2*N using 1:2:3 with lines lc 7 notitle,'WehrlImpares(copia).dat' using 1:2:3 with lines lw 2 lc 6 title 'Odd',for [N=0:47] 'Sorted(copia).dat' i 2*N+1 using 1:2:3 with line lc 6 notitle,'WehrlPares(copia).dat' using 1:2:3 with lines lw 2 lc 7 title 'Even', 'AC.dat' using 1:2:($3*a) with lines lw 2 lc 8 title 'AC'

set terminal pop
set output
