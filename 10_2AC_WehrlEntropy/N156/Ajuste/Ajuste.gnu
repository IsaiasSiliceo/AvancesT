reset
set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color

state1 = '72'
state2 = '73'
set output state1.'-'.state2.'(fit).png'
file = state1.'-'.state2.'(fit).dat'
title1 = 'Upper ('.state2.' -> '.state1.')'
title2 = 'Lower ('.state1.' -> '.state2.')'

#set xtics format "%.15f"
#set xrange [4.418950137258950:4.418950137259198]
#set yrange [3.2:3.8]


set title "{/:Bold=16 Wehrl entropy as a function of |{/Symbol g}_x|,  j=100, N=156, Gaussian fit" \

#Comandos para el formato
#set xtics rotate by 45 right
set key top left
set xtics rotate by 45 right

set xlabel '|{/Symbol g}_x|'
set ylabel 'W_E' rotate by 0 offset 2

pi = 3.141592654

h1 = 3.24483
a1 = 0.40351
mu1 = 2.611197808380353
sigma1 = 0.00000000000002*0.9
gauss1(x)= h1 +a1/(sigma1*sqrt(2.*pi))*exp(-(x-mu1)**2./(2.*sigma1**2))
fit gauss1(x) file using 1:3 index 0 via h1, a1, sigma1

h2 = 2.39110
a2 = 0.40351
mu1 = 2.611197808380353
sigma2 = 0.00000000000002*0.45
gauss2(x)= h2 +a2/(sigma2*sqrt(2.*pi))*exp(-(x-mu1)**2./(2.*sigma2**2))
fit gauss2(x) file using 1:3 index 1 via h2, a2, sigma2


plot file using 1:3 index 0 with linespoints title title1 lw 2, file using 1:3 index 1 with linespoints title title2 lw 2, gauss1(x) title 'Upper' lw 2 lc 6, gauss2(x) lw 2 lc 8 title 'Lower'

unset multiplot
set terminal pop
set output
