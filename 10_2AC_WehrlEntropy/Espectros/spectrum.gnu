set terminal push
set encoding utf8
####################################
#############   names   ############
####################################
file = 'WholeSpectrum25-30.dat'

set terminal pngcairo font 'Helvetica, 14' size 768,768 enhanced color
set output 'Otro.png'
first = 62
last = 75

set title font 'HelveticaBold, 15'
set title 'Energy spectrum LMG Model (j=100,{/Symbol g}_y=3{/Symbol g}_x)'.sprintf("\n").'N=196'
set ylabel 'E_k' rotate by 0 left
set xlabel '|{/Symbol g}_x|'
set grid
set size square
set key out

a=-16
b=-11
c= 28.2
d=29.2
set yrange[a:b]
set xrange[c:d]

styles = '"#800000" "#FF0000" "#E9967A" "#FFA500" "#BDB76B" "#556B2F" "#006400" "#8FBC8F" "#3CB371" "#008B8B" "#40E0D0" "#4682B4" "#4B0082" "#8B008B" "#FF1493" "#A0522D" "#BC8F8F"'

do for[t=1:17]{
	set style line t lt rgb word(styles, t) lw 2
}

f(x) = -1-(4*x)/(2*(2*100-1))

set arrow 1 from 1.148927035687355,a to 1.148927035687355,b lw 1.3 dt 2 lc 8 nohead
set arrow 2 from 1.914878392812259,a to 1.914878392812259,b lw 1.3 dt 2 lc 8 nohead
set arrow 3 from 2.611197808380353,a to 2.611197808380353,b lw 1.3 dt 2 lc 8 nohead
set arrow 4 from 3.829756785624518,a to 3.829756785624518,b lw 1.3 dt 2 lc 8 nohead
set arrow 5 from 4.103310841740555,a to 4.103310841740555,b lw 1.3 dt 2 lc 8 nohead
set arrow 6 from 4.418950137259059,a to 4.418950137259059,b lw 1.3 dt 2 lc 8 nohead
set arrow 7 from 8.206621683481109,a to 8.206621683481109,b lw 1.3 dt 2 lc 8 nohead
set arrow 8 from 28.72317589218388,a to 28.72317589218388,b lw 1.3 dt 2 lc 8 nohead

#set label 1 'N=170' at 3.7,-2.35
#set label 2 'N=172' at 3.97,-2.35
#set label 3 'N=174' at 4.25,-2.35

## Niveles1.png
plot for[i=2:102] file using 1:i with lines lw 1 lc 8 notitle, for [n=(first+1):(last+1)] file using 1:n with lines ls n-first title sprintf("%i",n-1), 'ESQPT3.dat' using 1:(-$2)  with lines lw 2 dt 4 lc 8 title 'ESQPT', f(x) lw  2 dt 4 lc 8 title '-1+C'


set terminal pop
set output
