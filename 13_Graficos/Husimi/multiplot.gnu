reset
set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 18' size 1600,550 enhanced color
set output 'j100.png'

#Esta parte define los espacios entre graficas 
if (!exists("MP_LEFT"))   MP_LEFT = .05
#Ancho de los gráficos
if (!exists("MP_RIGHT"))  MP_RIGHT = 0.92
if (!exists("MP_BOTTOM")) MP_BOTTOM = 0.1
#Altura de los gráficos
if (!exists("MP_TOP"))    MP_TOP = .9
#Espacio entre gráficas
if (!exists("MP_xGAP"))   MP_xGAP = 0.1
if (!exists("MP_yGAP"))   MP_yGAP = 0.15

#Se define el multiplot 1x3
set multiplot layout 1,3 columnsfirst 
#title "{/:Bold=16 Husimi representation j=100, {/Symbol g}@^{AC}_{x}  = -4.103310841740555, Positive parity" \
margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_xGAP, MP_yGAP
	      
#Comandos para el formato
#set xtics rotate by 45 right
set cbrange [0:0.15]

#Gráfica 11
load 'formato.gnu'
set title 'K=64'
splot 'QP_64.dat' using 1:2:3
#Gráfica 12
load 'formato.gnu'
set title 'K=76'
splot 'QP_76.dat' using 1:2:3
#Gráfica 13
load 'formato.gnu'
set title 'K=80'
splot 'QP_80.dat' using 1:2:3

unset multiplot
set terminal pop
set output
