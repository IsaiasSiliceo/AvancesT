reset
set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 1300,1000 enhanced color
set output 'j100Entropy.png'

#Esta parte define los espacios entre graficas 
if (!exists("MP_LEFT"))   MP_LEFT = 0.1
#Ancho de los gráficos
if (!exists("MP_RIGHT"))  MP_RIGHT = 0.98
if (!exists("MP_BOTTOM")) MP_BOTTOM = 0.1
#Altura de los gráficos
if (!exists("MP_TOP"))    MP_TOP = .9
#Espacio entre gráficas
if (!exists("MP_xGAP"))   MP_xGAP = 0.1
if (!exists("MP_yGAP"))   MP_yGAP = 0.10

#Se define el multiplot 2x2
set multiplot layout 2,2 columnsfirst title "{/:Bold=16 Wehrl entropy as a function of |{/Symbol g}_x|,  j=100" \
margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_xGAP, MP_yGAP
	      
#Comandos para el formato
set xtics rotate by 45 right
set key top left
#set xrange [4.102:4.105]
set yrange [2.8:3.9]
set xlabel '|{/Symbol g}_x|'
set ylabel 'W_E' rotate by 0 offset 2

set arrow 1 from 4.103310841740555,2.8 to 4.103310841740555,3.9 lw 1 dt 2 lc 8 nohead
set arrow 2 from 4.418950137259059,2.8 to 4.418950137259059,3.9 lw 1 dt 2 lc 8 nohead

#Gráfica 11
plot '62-63.dat' using 1:3 index 0 with linespoints title 'k=62' lw 2,'62-63.dat' using 1:3 index 1 with linespoints title 'k=63' lw 2

#Gráfica 12
plot '66-67.dat' using 1:3 index 0 with linespoints title 'k=66' lw 2,'66-67.dat' using 1:3 index 1 with linespoints title 'k=67' lw 2

#Gráfica 21
plot '64-65.dat' using 1:3 index 0 with linespoints title 'k=64' lw 2,'64-65.dat' using 1:3 index 1 with linespoints title 'k=65' lw 2

#Gráfica 22
set xtics format "%.7f"
plot '68-69.dat' using 1:3 index 0 with linespoints title 'k=68' lw 2,'68-69.dat' using 1:3 index 1 with linespoints title 'k=69' lw 2


unset multiplot
set terminal pop
set output
