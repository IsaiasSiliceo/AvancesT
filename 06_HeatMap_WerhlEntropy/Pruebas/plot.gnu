
# Esto plotea los estados pares
splot for [N=0:5] 'Sorted.dat' i 2*N using 1:2:3 with lines lc 8 notitle, for [N=0:4] 'Wehrl.dat' i N using 1:2:3 with lines lc 9 notitle


# Esto plotea los estados impares
splot for [N=0:5] 'Sorted.dat' i 2*N+1 using 1:2:3 with lines lc 8 notitle, for [N=5:8] 'Wehrl.dat' i N using 1:2:3 with lines lc 4 notitle

#Esto plotea ambos estados pares e impares
splot for [N=0:5] 'Sorted.dat' i 2*N using 1:2:3 with lines lc 8 notitle, for [N=0:4] 'Wehrl.dat' i N using 1:2:3 with lines lc 8 notitle, for [N=0:5] 'Sorted.dat' i 2*N+1 using 1:2:3 with lines lc 9 notitle, for [N=5:8] 'Wehrl.dat' i N using 1:2:3 with lines lc 9 notitle


#Para plotear el heat map de la entropía para estados pares o impares separados en bloques de un espacio
splot 'WehrlPrueba.dat' using 1:2:3 with pm3d at s