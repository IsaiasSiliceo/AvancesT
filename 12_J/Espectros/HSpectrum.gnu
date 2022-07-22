set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 16' size 800,800 enhanced color

jvalue = 200
Nvalue = '340'
first = 120
last = 134
AC = 3.839379290111011

set output sprintf("%i",jvalue).'/HS_'.sprintf("%i",jvalue).'.png'
file = sprintf("%i",jvalue).'/Hspectrum'.sprintf("%i",jvalue).'.dat'

set title 'Energy spectrum LMG Model (J='.sprintf("%i",jvalue).',{/Symbol g}_y=3{/Symbol g}_x)'.sprintf("\n").'N='.Nvalue.', |{/Symbol g}|@_x^{AC} = '.sprintf("%1.15f",AC).' '
	      
#Comandos para el formato

set ylabel 'E_k/J' rotate by 0 left offset -1
set xlabel '|{/Symbol g}_x|'
set grid
set key below
set size square
a = -2.1
b = -1.7
c = 3.63
d = 4.03
set yrange[a:b]
set xrange[c:d]

styles = '"#800000" "#FF0000" "#E9967A" "#FFA500" "#BDB76B" "#556B2F" "#006400" "#8FBC8F" "#3CB371" "#008B8B" "#40E0D0" "#4682B4" "#4B0082" "#8B008B" "#FF1493" "#A0522D" "#BC8F8F"'

do for[t=1:17]{
	set style line t lt rgb word(styles, t) lw 2
}

set arrow 1 from AC,a to AC,b lw 1.3 dt 2 lc 7 nohead


####################################
####      Caja mordada      ########
####################################
set arrow from 3.3,-1.4 to 4.3,-1.4 lw 2 lc 1 nohead
set arrow from 4.3,-1.4 to 4.3,-2.4 lw 2 lc 1 nohead
set arrow from 4.3,-2.4 to 3.3,-2.4 lw 2 lc 1 nohead
set arrow from 3.3,-2.4 to 3.3,-1.4 lw 2 lc 1 nohead



f(x) = -1-(4*x)/(2*(2*(jvalue+2)-1))

#Gráfica
plot for [i=2:jvalue+2] file using 1:i with lines lc 8 notitle,for [n=(first+1):(last+1)] file using 1:n with lines ls n-first title sprintf("%i",n-1), sprintf("%i",jvalue).'/ESQPT'.sprintf("%i",jvalue).'.dat' using 1:(-$2)  with lines lw 2 dt 1 lc 6 title 'ESQPT', f(x) lw  2 dt 4 lc 6 notitle

set terminal pop
set output