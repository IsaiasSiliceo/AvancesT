set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 650,650 enhanced color
set output 'Whole_60-79.png'

set title "{/:Bold=16 Wehrl entropy, Positive Parity, k=60-79}"

set size square
set format x
set format y
set yrange [-2.5:-1.3]
set pm3d map
set cbrange[2.5:3.8]
set xlabel '|{/Symbol g}_x|'
set ylabel 'E_i / j' rotate by 0
set arrow 1 from 4.103310841740555,-1.3 to 4.103310841740555,-2.5 lw 1 dt 2 lc 8 nohead front
set arrow 2 from 4.418950137259059,-1.3 to 4.418950137259059,-2.5 lw 1 dt 2 lc 8 nohead front
set label 1 '{/Symbol g}@^{AC}_{x}  =-4.10331' at 3.92,-2.4 front
set label 2 '{/Symbol g}@^{AC}_{x}  =-4.41895' at 4.24,-2.4 front

splot 'Whole.dat' using 1:2:3 with pm3d notitle, 'WehrlPares(copia).dat' using 1:2:3 with lines lw 2 lc 7 title 'Even', 'WehrlImpares(copia).dat' using 1:2:3 with lines lw 2 lc 6 title 'Odd'

set terminal pop
set output