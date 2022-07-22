set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 1740,768 enhanced color
set output 'j50Entropy.png'

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
set multiplot layout 2,4 columnsfirst title "{/:Bold=16 Wehrl entropy as a function of |{/Symbol g}_x|,  j=50, {/Symbol g}_x=-4, {/Symbol g}_y=3{/Symbol g}_x" \
margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_xGAP, MP_yGAP
	      
#Comandos para el formato
#set xtics rotate by 45 right
set xrange[4:4.2]
set yrange[2.5:3.5]
set xlabel '|{/Symbol g}_x|'
set ylabel 'W_E' rotate by 0 right offset 3.5

#Gráfica 11
set key bottom right
plot 'WEntropy.dat' using 1:2 with linespoints lw 2 title 'k=62', 'WEntropy.dat' using 1:3 with linespoints lw 2 title 'k=63'

#Gráfica 12
set yrange[2.2:2.9]
set key center right
plot 'WEntropy.dat' using 1:10 with linespoints lw 2 title 'k=70', 'WEntropy.dat' using 1:11 with linespoints lw 2 title 'k=71'

#Gráfica 21
set yrange[2.5:3.5]
set key default
plot 'WEntropy.dat' using 1:4 with linespoints lw 2 title 'k=64', 'WEntropy.dat' using 1:5 with linespoints lw 2 title 'k=65'

#Gráfica 22
set yrange[2.2:2.9]
set key center right
plot 'WEntropy.dat' using 1:12 with linespoints lw 2 title 'k=72', 'WEntropy.dat' using 1:13 with linespoints lw 2 title 'k=73'

#Gráfica 31
set yrange[2.5:3.5]
set key default
plot 'WEntropy.dat' using 1:6 with linespoints lw 2 title 'k=66', 'WEntropy.dat' using 1:7 with linespoints lw 2 title 'k=67'

#Gráfica 32
set yrange[2.2:2.9]
set key center right
plot 'WEntropy.dat' using 1:14 with linespoints lw 2 title 'k=74', 'WEntropy.dat' using 1:15 with linespoints lw 2 title 'k=75'

#Gráfica 41
set yrange[2.5:3.5]
set key default
plot 'WEntropy.dat' using 1:8 with linespoints lw 2 title 'k=68', 'WEntropy.dat' using 1:9 with linespoints lw 2 title 'k=69'

#Gráfica 24
set yrange[2.2:2.9]
set key center right
plot 'WEntropy.dat' using 1:16 with linespoints lw 2 title 'k=76', 'WEntropy.dat' using 1:17 with linespoints lw 2 title 'k=77'


unset multiplot
set terminal pop
set output