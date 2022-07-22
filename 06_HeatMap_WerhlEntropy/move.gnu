reset
set term gif animate delay 50
set output 'prueba.gif'
#set style fill transparent solid 0.5
#set size square

#file = "longitud.dat"
#len = system("head -n1 longitud.dat | awk '{print $1}'")

stats 'Wehrl1.dat' u 1 nooutput
N = STATS_blocks
print N

set xrange[3.9: 4.6]
set yrange[3: 4]

#unset key
#unset xtics
#unset ytics

do for[i=1:N]{
   plot 'Wehrl1.dat' using 1:2 index i-1 with linespoints
}