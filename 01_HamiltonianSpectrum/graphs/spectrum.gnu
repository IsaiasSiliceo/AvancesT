set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 768,768 enhanced color
set output 'Niveles.png'

set title font 'HelveticaBold, 15'
set title 'Energy spectrum LMG Model (j=10,{/Symbol g}_y=3{/Symbol g}_x)'
set ylabel 'E_k' rotate by 0 left
set xlabel '|{/Symbol g}_x|'
set grid
set size square
set key bottom left
set yrange[-2.5:-1.5]
set xrange[3.6:4.6]

titles='"62" "63" "64" "65" "66" "67" "68" "69" "70" "71" "72" "73" "74" "75" "76"'
#plot for [i=2:102] 'Ek_Positive_100.dat' using 1:i with lines lc 8 notitle

set arrow 1 from 3.829756785624518,-2.5 to 3.829756785624518,-1.5 lw 1.3 dt 2 lc 8 nohead
set arrow 2 from 4.103310841740555,-2.5 to 4.103310841740555,-1.5 lw 1.3 dt 2 lc 8 nohead
set arrow 3 from 4.418950137259059,-2.5 to 4.418950137259059,-1.5 lw 1.3 dt 2 lc 8 nohead

plot for [n=62:76] 'Ek_Positive_100.dat' using 1:n with lines lw 2 title word(titles, n-61)

#plot for [i=2:52] 'Ek_Positive.dat' using 1:i with lines lc 8

set terminal pop
set output
