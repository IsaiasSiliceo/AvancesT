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
set multiplot layout 2,4 columnsfirst title "{/:Bold=16 Wehrl entropy as a function of |{/Symbol g}_x|,  j=100, {/Symbol g}_x=-4, {/Symbol g}_y=3{/Symbol g}_x" \
margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_xGAP, MP_yGAP
	      
#Comandos para el formato
#set xtics rotate by 45 right
set xrange[4:4.2]
set yrange[2.9:3.8]
set xlabel '|{/Symbol g}_x|'
set ylabel 'W_E' rotate by 0 offset 2
#Gráfica 11
plot 'WEntropy_122-123.dat' using 1:2 with linespoints title 'k=122' lw 2,'WEntropy_122-123.dat' using 1:3 with linespoints title 'k=123' lw 2,'linea.dat' with lines lw 2 dt 2 lc 8 notitle
#Gráfica 12
set yrange[2.8:3.3]
set key center right
plot 'WEntropy_130-131.dat' using 1:2 with linespoints title 'k=130' lw 2,'WEntropy_130-131.dat' using 1:3 with linespoints title 'k=131' lw 2,'linea.dat' with lines lw 2 dt 2 lc 8 notitle
#Gráfica 21
set yrange[2.9:3.8]
set key default
plot 'WEntropy_124-125.dat' using 1:2 with linespoints title 'k=124' lw 2,'WEntropy_124-125.dat' using 1:3 with linespoints title 'k=125' lw 2,'linea.dat' with lines lw 2 dt 2 lc 8 notitle
#Gráfica 22
set yrange[2.8:3.3]
set key center right
plot 'WEntropy_132-133.dat' using 1:2 with linespoints title 'k=132' lw 2,'WEntropy_132-133.dat' using 1:3 with linespoints title 'k=133' lw 2,'linea.dat' with lines lw 2 dt 2 lc 8 notitle
#Gráfica 31
set yrange[2.9:3.8]
set key default
plot 'WEntropy_126-127.dat' using 1:2 with linespoints title 'k=126' lw 2,'WEntropy_126-127.dat' using 1:3 with linespoints title 'k=127' lw 2,'linea.dat' with lines lw 2 dt 2 lc 8 notitle
#Gráfica 32
set yrange[2.8:3.3]
set key center right
plot 'WEntropy_134-135.dat' using 1:2 with linespoints title 'k=134' lw 2,'WEntropy_134-135.dat' using 1:3 with linespoints title 'k=135' lw 2,'linea.dat' with lines lw 2 dt 2 lc 8 notitle
#Gráfica 41
set yrange[2.9:3.8]
set key default
plot 'WEntropy_128-129.dat' using 1:2 with linespoints title 'k=128' lw 2,'WEntropy_128-129.dat' using 1:3 with linespoints title 'k=129' lw 2,'linea.dat' with lines lw 2 dt 2 lc 8 notitle
#Gráfica 24
set yrange[2.8:3.3]
set key center right
plot 'WEntropy_136-137.dat' using 1:2 with linespoints title 'k=136' lw 2,'WEntropy_136-137.dat' using 1:3 with linespoints title 'k=137' lw 2,'linea.dat' with lines lw 2 dt 2 lc 8 notitle


unset multiplot
set terminal pop
set output