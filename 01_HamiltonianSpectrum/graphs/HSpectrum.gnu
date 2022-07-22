set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 1200,1200 enhanced color
set output 'Hamilonian spectrum'

#Esta parte define los espacios entre graficas 
if (!exists("MP_LEFT"))   MP_LEFT = 0.1
#Ancho de los gráficos
if (!exists("MP_RIGHT"))  MP_RIGHT = 0.96
if (!exists("MP_BOTTOM")) MP_BOTTOM = 0.1
#Altura de los gráficos
if (!exists("MP_TOP"))    MP_TOP = .9
#Espacio entre gráficas
if (!exists("MP_xGAP"))   MP_xGAP = 0.1
if (!exists("MP_yGAP"))   MP_yGAP = 0.15

#Se define el multiplot 2x2
set multiplot layout 1,2 columnsfirst title "{/:Bold= Hamiltonian spectrum, Positive Parity, j=100" \
margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_xGAP, MP_yGAP
	      
#Comandos para el formato
#set xtics rotate by 45 right
set ylabel 'E_k' rotate by 0 left
set xlabel '|{/Symbol g}_x|'
set grid
unset key
set yrange[-8.5:1.5]
set xrange[0:5]

set arrow 1 from 4.103310841740555,2.5 to 4.103310841740555,3.9 lw 1 dt 2 lc 8 nohead
set arrow 2 from 4.418950137259059,2.5 to 4.418950137259059,3.9 lw 1 dt 2 lc 8 nohead

#Gráfica 11
plot for [i=2:102] 'Ek_Positive_100.dat' using 1:i with lines lc 8

#Gráfica 12

plot for [i=2:102] 'Ek_Positive_100.dat' using 1:i with lines lc 8

unset multiplot
set terminal pop
set output
