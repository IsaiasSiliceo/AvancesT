set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output "multiplot.png" 

set multiplot

set title font 'HelveticaBold, 16'
set title 'Wehrl Entropy as a function of the Energy E_i ({/Symbol g}@^{AC}_{x}  = -5.22239)'
set ylabel 'Entropy'
set xlabel 'E_i / j'

set origin 0,0
set size 1,1
set yrange[1:4]
set xrange[-7:1]

plot 'WehrlVsEi-522239.dat' using 1:2 every 2::1 with linespoints lw 2 title 'k=2j', 'WehrlVsEi-522239.dat' using 1:2 every 2 with linespoints lw 2 title 'k=2j+1', 'dotline.dat' with lines dt 2 lw 2 lc -1 notitle

set nokey
unset title
unset xlabel
unset ylabel
set grid


set origin 0.10, 0.15
#set size 0.4, 0.2991
set size 0.4, 0.4
#set xrange [-3.8:-1.2]
#set xrange [-2.53:-1.2]
set xrange [-3.2:-2.5]
set yrange [3:4]
set xtics 0.2
set ytics 0.2
replot

unset multiplot
