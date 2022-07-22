set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 14' size 1200,650 enhanced color
set output 'HeatMap.png'

#Esta parte define los espacios entre graficas 
if (!exists("MP_LEFT"))   MP_LEFT = .1
#Ancho de los gráficos
if (!exists("MP_RIGHT"))  MP_RIGHT = 0.90
if (!exists("MP_BOTTOM")) MP_BOTTOM = 0.1
#Altura de los gráficos
if (!exists("MP_TOP"))    MP_TOP = .9
#Espacio entre gráficas
if (!exists("MP_xGAP"))   MP_xGAP = 0.15
if (!exists("MP_yGAP"))   MP_yGAP = 0.15

#Se define el multiplot 2x2
set multiplot layout 1,2 columnsfirst title "{/:Bold=16 Wehrl entropy j=100, Positive parity" \
margins screen MP_LEFT, MP_RIGHT, MP_BOTTOM, MP_TOP spacing screen MP_xGAP, MP_yGAP
	      
#Comandos para el formato
#set xtics rotate by 45 right

#Gráfica 11
set title 'Odd k= 61-69'
set size square
set format x
set format y
set yrange[-2.5:-1.8]
set pm3d map
set xlabel '|{/Symbol g}_x|'
set ylabel 'E_i / j' rotate by 0
unset key
set label '{/Symbol g}@^{AC}_{x}  =-4.10331' at 3.92,-2.45 front
set label '{/Symbol g}@^{AC}_{x}  =-4.41895' at 4.22,-1.9 front
splot 'WehrlImpares.dat' using 1:2:3 with pm3d, 'WehrlImpares(copia).dat' using 1:2:3 with lines lw 2 lc 6, 'AC.dat' using 1:2:3 with lines lw 2 lc 8 dt 2

set label '{/Symbol g}@^{AC}_{x}  =-4.10331' at 3.92,-2.45 front
set label '{/Symbol g}@^{AC}_{x}  =-4.41895' at 4.22,-1.9 front
#Gráfica 21
set title 'Even k= 60-68'
splot 'WehrlPares.dat' using 1:2:3 with pm3d, 'WehrlPares(copia).dat' using 1:2:3 with lines lw 2 lc 7, 'AC.dat' using 1:2:3 with lines lw 2 lc 8 dt 2
#unset pm3d map

unset multiplot
set terminal pop
set output
