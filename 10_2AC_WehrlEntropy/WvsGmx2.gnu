set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 700,1200 enhanced color
set output 'EntropyVsgmx2.png'

#Esta parte define los espacios entre graficas 
if (!exists("MP_LEFT"))   MP_LEFT = 0.12
#Ancho de los gráficos
if (!exists("MP_RIGHT"))  MP_RIGHT = 0.96
if (!exists("MP_BOTTOM")) MP_BOTTOM = 0.1
#Altura de los gráficos
if (!exists("MP_TOP"))    MP_TOP = .9
#Espacio entre gráficas
if (!exists("MP_xGAP"))   MP_xGAP = 0.1
if (!exists("MP_yGAP"))   MP_yGAP = 0.12

#Se define el multiplot 2x2
set multiplot layout 3,1 columnsfirst title "{/:Bold=16 Wehrl entropy as a function of |{/Symbol g}_x|,  j=100 }" \
margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_xGAP, MP_yGAP
	      
#Comandos para el formato
#set xtics rotate by 45 right
set key top left
set xtics rotate by 45 right
#set xrange [4.08-4.12]
set yrange [2.6:3.8]

set ylabel 'W_E' rotate by 0 offset 2
set grid lw 1.2



set arrow 1 from 3.829756785624518,2.6 to 3.829756785624518,3.8 lw 1.3 dt 2 lc 8 nohead
set arrow 2 from 4.103310841740555,2.6 to 4.103310841740555,3.8 lw 1.3 dt 2 lc 8 nohead
set arrow 3 from 4.418950137259059,2.6 to 4.418950137259059,3.8 lw 1.3 dt 2 lc 8 nohead

#Gráfica 11
set xtics format "%.9f"
set xrange [3.829756770:3.829756790]
set title '{/:Bold=16|{/Symbol g}@_x^{AC}|=3.829756785624518, N=170}'
plot 'AC3/70-71(1).dat' using 1:3 index 0 with linespoints title 'k=70' lw 2,'AC3/70-71(1).dat' using 1:3 index 1 with linespoints title 'k=71' lw 2

#Gráfica 12

set xrange [4.1033108395:4.103310845]
set title '{/:Bold=16|{/Symbol g}@_x^{AC}|=4.103310841740555, N=172}'
plot 'AC3/70-71(2).dat' using 1:3 index 0 with linespoints title 'k=70' lw 2,'AC3/70-71(2).dat' using 1:3 index 1 with linespoints title 'k=71' lw 2

set xlabel '|{/Symbol g}_x|'
#Grafica 13
set xrange [4.418950120:4.418950140]
set title '{/:Bold=16|{/Symbol g}@_x^{AC}|=4.418950137259059,  N=174}'
plot 'AC3/70-71(3).dat' using 1:3 index 0 with linespoints title 'k=70' lw 2,'AC3/70-71(3).dat' using 1:3 index 1 with linespoints title 'k=71' lw 2
unset multiplot
set terminal pop
set output
