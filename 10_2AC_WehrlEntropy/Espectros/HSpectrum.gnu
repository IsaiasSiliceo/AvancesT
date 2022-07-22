set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 16' size 1400,800 enhanced color
set output 'HamilonianSpectrum3.png'
file = 'WholeSpectrum25-30.dat'

set title "{/:Bold= Hamiltonian spectrum, Positive Parity, j=100}"
	      
#Comandos para el formato

set ylabel 'E_k' rotate by 0 left
set xlabel '|{/Symbol g}_x|'
set grid
set key below
a = -15
b = -0.5
set yrange[a:b]
set xrange[26:30]

styles = '"#800000" "#FF0000" "#E9967A" "#FFA500" "#BDB76B" "#556B2F" "#006400" "#8FBC8F" "#3CB371" "#008B8B" "#40E0D0" "#4682B4" "#4B0082" "#8B008B" "#FF1493" "#A0522D" "#BC8F8F"'

do for[t=1:17]{
	set style line t lt rgb word(styles, t) lw 2
}

set arrow 1 from 1.148927035687355,a to 1.148927035687355,b lw 1.3 dt 2 lc 7 nohead
set arrow 2 from 1.914878392812259,a to 1.914878392812259,b lw 1.3 dt 2 lc 7 nohead
set arrow 3 from 2.611197808380353,a to 2.611197808380353,b lw 1.3 dt 2 lc 7 nohead
set arrow 4 from 3.829756785624518,a to 3.829756785624518,b lw 1.3 dt 2 lc 7 nohead
set arrow 5 from 4.103310841740555,a to 4.103310841740555,b lw 1.3 dt 2 lc 7 nohead
set arrow 6 from 4.418950137259059,a to 4.418950137259059,b lw 1.3 dt 2 lc 7 nohead
set arrow 7 from 8.206621683481109,a to 8.206621683481109,b lw 1.3 dt 2 lc 7 nohead
set arrow 8 from 28.72317589218388,a to 28.72317589218388,b lw 1.3 dt 2 lc 7 nohead

####################################
####      Caja mordada      ########
####################################
set arrow from 3.6,-1.4 to 4.6,-1.4 lw 2 lc 1 nohead
set arrow from 4.6,-1.4 to 4.6,-2.4 lw 2 lc 1 nohead
set arrow from 4.6,-2.4 to 3.6,-2.4 lw 2 lc 1 nohead
set arrow from 3.6,-2.4 to 3.6,-1.4 lw 2 lc 1 nohead


####################################
####      Caja verde        ########
####################################
set arrow from 1.7,-0.95 to 2.2,-0.95 lw 2 lc 2 nohead
set arrow from 2.2,-0.95 to 2.2,-1.45 lw 2 lc 2 nohead
set arrow from 2.2,-1.45 to 1.7,-1.45 lw 2 lc 2 nohead
set arrow from 1.7,-1.45 to 1.7,-0.95 lw 2 lc 2 nohead

####################################
####      Caja naranja      ########
####################################
set arrow from 1.1,-0.95 to 1.2,-0.95 ls 4 nohead 
set arrow from 1.2,-0.95 to 1.2,-1.05 ls 4 nohead
set arrow from 1.2,-1.05 to 1.1,-1.05 ls 4 nohead
set arrow from 1.1,-1.05 to 1.1,-0.95 ls 4 nohead


####################################
####      Caja marron       ########
####################################
set arrow from 2.35,-1.1 to 2.85,-1.1 ls 1 nohead 
set arrow from 2.85,-1.1 to 2.85,-1.6 ls 1 nohead
set arrow from 2.85,-1.6 to 2.35,-1.6 ls 1 nohead
set arrow from 2.35,-1.6 to 2.35,-1.1 ls 1 nohead

####################################
####      Caja roja         ########
####################################
set arrow from 7.4,-3 to 8.9,-3 ls 2 nohead 
set arrow from 8.9,-3 to 8.9,-4.5 ls 2 nohead
set arrow from 8.9,-4.5 to 7.4,-4.5 ls 2 nohead
set arrow from 7.4,-4.5 to 7.4,-3 ls 2 nohead

#####################################
#########       Labels     ##########
#####################################
set label 1 '{/:Bold= N=100}' at 1.1489-0.1,-2.7
set label 2 '{/:Bold= N=140}' at 1.9148-0.1,-2.7
set label 3 '{/:Bold= N=156}' at 2.6111-0.1,-2.7
set label 4 '{/:Bold= N=170}' at 3.8297-0.1,-2.7
set label 5 '{/:Bold= N=172}' at 4.1033-0.1,-2.7
set label 6 '{/:Bold= N=174}' at 4.4189-0.1,-2.7

f(x) = -1-(4*x)/(2*(2*100-1))

#Gráfica
plot for [i=2:102] file using 1:i with lines lc 8 notitle,'ESQPT3.dat' using 1:(-$2)  with lines lw 2 dt 1 lc 6 title 'ESQPT', f(x) lw  2 dt 4 lc 6 title '-1+C'


set terminal pop
set output
