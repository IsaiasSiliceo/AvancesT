reset
set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color

set output '73-74(fit).png'
file = '73-74(fit).dat'
title1 = 'Upper (74 -> 73)'
title2 = 'Lower (73 -> 74)'
set xtics format "%.15f"
set xrange [3.829756785624401:3.829756785624621]
set yrange [3:3.77]


set title "{/:Bold=16 Wehrl entropy as a function of |{/Symbol g}_x|,  j=100, N=170, Gaussian fit" \

#Comandos para el formato
#set xtics rotate by 45 right
set key top left
set xtics rotate by 45 right

set xlabel '|{/Symbol g}_x|'
set ylabel 'W_E' rotate by 0 offset 2

pi = 3.141592654

h1 = 3.5160
a1 = 0.000227604
mu1 = 3.829756785624518
sigma1 = 0.0000000000002*0.25
gauss1(x)= h1 +a1/(sigma1*sqrt(2.*pi))*exp(-(x-mu1)**2./(2.*sigma1**2))
fit gauss1(x) file using 1:3 index 0 via h1, a1, sigma1

h2 = 3.1661
a2 = 0.000227604
mu1 = 3.829756785624518
sigma2 = 0.0000000000002*0.21
gauss2(x)= h2 +a2/(sigma2*sqrt(2.*pi))*exp(-(x-mu1)**2./(2.*sigma2**2))
fit gauss2(x) file using 1:3 index 1 via h2, a2, sigma2


plot file using 1:3 index 0 with linespoints title title1 lw 2, file using 1:3 index 1 with linespoints title title2 lw 2, gauss1(x) title 'Upper' lw 2 lc 6, gauss2(x) lw 2 lc 8 title 'Lower'

unset multiplot
set terminal pop
set output
