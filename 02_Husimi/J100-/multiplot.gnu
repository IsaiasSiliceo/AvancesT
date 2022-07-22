set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 768,768 enhanced color
set output 'j100.png'

#Esta parte define los espacios entre graficas 
if (!exists("MP_LEFT"))   MP_LEFT = .1
#Ancho de los gráficos
if (!exists("MP_RIGHT"))  MP_RIGHT = 0.96
if (!exists("MP_BOTTOM")) MP_BOTTOM = 0.1
#Altura de los gráficos
if (!exists("MP_TOP"))    MP_TOP = .9
#Espacio entre gráficas
if (!exists("MP_xGAP"))   MP_xGAP = 0.05
if (!exists("MP_yGAP"))   MP_yGAP = 0.15

#Se define el multiplot 2x2
set multiplot layout 2,2 columnsfirst title "{/:Bold=16 Density surfaces j=100, {/Symbol g}_x=-4, {/Symbol g}_y=3{/Symbol g}_x, Negative parity" \
margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_xGAP, MP_yGAP
	      
#Comandos para el formato
#set xtics rotate by 45 right

#Gráfica 11
load 'formato.gnu'
set title 'K=10'
splot 'Q10.dat' using 1:2:3
#Gráfica 21
load 'formato.gnu'
set title 'K=64'
splot 'Q64.dat' using 1:2:3
#Gráfica 12
load 'formato.gnu'
set title 'K=90'
splot 'Q90.dat' using 1:2:3
#Gráfica 22
load 'formato.gnu'
set title 'K=65'
splot 'Q65.dat' using 1:2:3

unset multiplot
set terminal pop
set output