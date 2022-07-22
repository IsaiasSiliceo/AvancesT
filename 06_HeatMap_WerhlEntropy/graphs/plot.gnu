
reset
set multiplot layout 1,2

set size square
set format x
set format y
set pm3d map
unset key

# Taking the whole data set
#splot 'Wehrl60-69.dat' using 1:2:3 with pm3d
unset colorbox
# Taking only de odd states
splot 'WehrlImpares.dat' using 1:2:3 with pm3d, 'WehrlImpares(copia).dat' using 1:2:3 with lines lc 8
set colorbox
splot 'WehrlPares.dat' using 1:2:3 with pm3d, 'WehrlPares(copia).dat' using 1:2:3 with lines lc 7


#splot for [N=0:47] 'Sorted(copia).dat' i 2*N using 1:2:3 with lines lc 8 notitle, 'WehrlImpares(copia).dat' using 1:2:3 with lines lc 7 title 'Impares', for [N=0:47] 'Sorted(copia).dat' i 2*N+1 using 1:2:3 with line lc 7 notitle, 'WehrlPares(copia).dat' using 1:2:3 with lines lc 8 title 'Pares'
