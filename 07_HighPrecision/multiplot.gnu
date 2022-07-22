set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output "multiplot.png" 

set multiplot

set title font 'HelveticaBold, 16'
set title 'Wehrl Entropy as a function of the Energy E_i ({/Symbol g}@^{AC}_{x}  = -2.393597991015323)'
set ylabel 'Entropy'
set xlabel 'E_i / j'

set origin 0,0
set size 1,1
set yrange[1:4]
set xrange[-7:1]

set arrow 1 from -1.429745806380444,1 to -1.429745806380444,4 lw 1 dt 2 lc 8 nohead
set arrow 2 from -1.024056261216234,1 to -1.024056261216234,4 lw 1 dt 2 lc 8 nohead

plot 'AC/WehrlVsEi.dat' using 1:2 every 2::1 with linespoints lw 2 title 'k=2j', 'AC/WehrlVsEi.dat' using 1:2 every 2 with linespoints lw 2 title 'k=2j+1'

set nokey
unset title
unset xlabel
unset ylabel
unset arrow 2
unset arrow 1

set grid
set arrow 3 from -1.429745806380444,3 to -1.429745806380444,4 lw 1 dt 2 lc 8 nohead

set origin 0.1, 0.15
#set size 0.4, 0.2991
set size 0.4, 0.4
set xrange [-1.7:-1.0]
set yrange [3:4]
set xtics 0.2
set ytics 0.2
replot

unset multiplot
