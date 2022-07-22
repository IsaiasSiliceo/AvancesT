set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 1740,768 enhanced color
set output 'j100Entropy.png'

#Esta parte define los espacios entre graficas 
if (!exists("MP_LEFT"))   MP_LEFT = 0.05
#Ancho de los gráficos
if (!exists("MP_RIGHT"))  MP_RIGHT = 0.96
if (!exists("MP_BOTTOM")) MP_BOTTOM = 0.1
#Altura de los gráficos
if (!exists("MP_TOP"))    MP_TOP = .9
#Espacio entre gráficas
if (!exists("MP_xGAP"))   MP_xGAP = 0.05
if (!exists("MP_yGAP"))   MP_yGAP = 0.15

#Se define el multiplot 2x2
set multiplot layout 2,4 columnsfirst title "{/:Bold=16 Wehrl entropy as a function of |{/Symbol g}_x|,  j=100" \
margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_xGAP, MP_yGAP
	      
#Comandos para el formato
#set xtics rotate by 45 right
set key top left
set xrange [3.9:4.5]
set yrange [2.5:3.9]
set xlabel '|{/Symbol g}_x|'
set ylabel 'W_E' rotate by 0 offset 2

#Gráfica 11
set arrow 1 from 4.103310841740555,2.5 to 4.103310841740555,3.9 lw 1 dt 2 lc 8 nohead
set arrow 2 from 4.418950137259059,2.5 to 4.418950137259059,3.9 lw 1 dt 2 lc 8 nohead
plot 'WehrlPares(copia).dat' using 1:3 index 1 with linespoints title 'k=62' lw 2,'WehrlImpares(copia).dat' using 1:3 index 1 with linespoints title 'k=63' lw 2

#Gráfica 12
plot 'WehrlPares(copia).dat' using 1:3 index 5 with linespoints title 'k=66' lw 2,'WehrlImpares(copia).dat' using 1:3 index 5 with linespoints title 'k=67' lw 2

#Gráfica 21
plot 'WehrlPares(copia).dat' using 1:3 index 2 with linespoints title 'k=70' lw 2,'WehrlImpares(copia).dat' using 1:3 index 2 with linespoints title 'k=71' lw 2

#Gráfica 22
plot 'WehrlPares(copia).dat' using 1:3 index 6 with linespoints title 'k=72' lw 2,'WehrlImpares(copia).dat' using 1:3 index 6 with linespoints title 'k=73' lw 2

#Gráfica 11
plot 'WehrlPares(copia).dat' using 1:3 index 3 with linespoints title 'k=66' lw 2,'WehrlImpares(copia).dat' using 1:3 index 3 with linespoints title 'k=67' lw 2

#Gráfica 12
plot 'WehrlPares(copia).dat' using 1:3 index 7 with linespoints title 'k=74' lw 2,'WehrlImpares(copia).dat' using 1:3 index 7 with linespoints title 'k=75' lw 2

#Gráfica 21
plot 'WehrlPares(copia).dat' using 1:3 index 4 with linespoints title 'k=68' lw 2,'WehrlImpares(copia).dat' using 1:3 index 4 with linespoints title 'k=69' lw 2

#Gráfica 22
plot 'WehrlPares(copia).dat' using 1:3 index 8 with linespoints title 'k=76' lw 2,'WehrlImpares(copia).dat' using 1:3 index 8 with linespoints title 'k=77' lw 2


unset multiplot
set terminal pop
set output
