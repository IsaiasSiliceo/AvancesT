reset
set terminal push
set encoding utf8
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output '74-75(fit).png'

set title "{/:Bold=16 Wehrl entropy as a function of |{/Symbol g}_x|,  j=100, k = 74-75 Gaussian fit" \

#Comandos para el formato
#set xtics rotate by 45 right
set key top left
set xtics rotate by 45 right
set xtics format "%.14f"
set xrange [4.10331084174045:4.103310841740645]
set yrange [2.6:3.9]
set xlabel '|{/Symbol g}_x|'
set ylabel 'W_E' rotate by 0 offset 2
pi = 3.141592654

h = 3.18
a1 = 0.000227604
mu1 = 4.1033108417405550
sigma1 = 0.0000000000000184919
gauss1(x)= h +a1/(sigma1*sqrt(2.*pi))*exp(-(x-mu1)**2./(2.*sigma1**2))
fit gauss1(x) '74-75(copia).dat' using 1:3 index 0 via h, a1, sigma1

h2= 2.7
a2 = 0.0004
mu2 = 4.1033108417405550
sigma2 = 0.000000000000008
gauss2(x)= h2 + a2/(sigma2*sqrt(2.*pi))*exp(-(x-mu2)**2./(2.*sigma2**2))
fit gauss2(x) '74-75(copia).dat' using 1:3 index 1 via h2,a2, sigma2


set arrow 1 from 4.103310841740555,2.6 to 4.103310841740555,3.9 lw 1 dt 2 lc 8 nohead

plot '74-75(copia).dat' using 1:3 index 0 with linespoints  lc 9 lw 2 title 'Upper (75->74)','74-75(copia).dat' using 1:3 index 1 with linespoints  lc 2 lw 2 title 'Lower (74->75)', gauss1(x) lw 2 lc 8 title 'Upper', gauss2(x) lw 2 lc 6 title 'Lower'


unset multiplot
set terminal pop
set output
