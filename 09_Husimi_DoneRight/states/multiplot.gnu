reset
set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 1600,800 enhanced color
set output 'j100.png'

#Esta parte define los espacios entre graficas 
if (!exists("MP_LEFT"))   MP_LEFT = .05
#Ancho de los gráficos
if (!exists("MP_RIGHT"))  MP_RIGHT = 0.96
if (!exists("MP_BOTTOM")) MP_BOTTOM = 0.1
#Altura de los gráficos
if (!exists("MP_TOP"))    MP_TOP = .9
#Espacio entre gráficas
if (!exists("MP_xGAP"))   MP_xGAP = 0.05
if (!exists("MP_yGAP"))   MP_yGAP = 0.15

#Se define el multiplot 2x2
set multiplot layout 2,4 columnsfirst title "{/:Bold=16 Husimi representation j=100, {/Symbol g}@^{AC}_{x}  = -4.103310841740555, Positive parity" \
margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_xGAP, MP_yGAP
	      
#Comandos para el formato
#set xtics rotate by 45 right
set cbrange [0:0.15]

#Gráfica 11
load 'formato.gnu'
set title 'K=10'
splot 'QP_10.dat' using 1:2:3
#Gráfica 21
load 'formato.gnu'
set title 'K=11'
splot 'QP_11.dat' using 1:2:3
#Gráfica 11
load 'formato.gnu'
set title 'K=12'
splot 'QP_12.dat' using 1:2:3
#Gráfica 21
load 'formato.gnu'
set title 'K=13'
splot 'QP_13.dat' using 1:2:3
#Gráfica 12
load 'formato.gnu'
set title 'K=14'
splot 'QP_14.dat' using 1:2:3
#Gráfica 22
load 'formato.gnu'
set title 'K=15'
splot 'QP_15.dat' using 1:2:3
load 'formato.gnu'
set colorbox
#set cbrange[0:0.2]
set title 'K=16'
splot 'QP_16.dat' using 1:2:3
#Gráfica 22
load 'formato.gnu'
set colorbox
#set cbrange[0:0.2]
set title 'K=17'
splot 'QP_17.dat' using 1:2:3

unset multiplot
set terminal pop
set output
