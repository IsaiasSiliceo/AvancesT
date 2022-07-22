
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output "prueba1.png" 

set title 'Standard Deviation {/Symbol s} of Gaussian fits, levels (k=64-75)'
set log x
set grid lw 2
set ylabel 'Standard Deviation {/Symbol s}'
set xlabel '{/Symbol D} E_i'
f(x) = x**(4.95568)

plot 'Tabla2.dat' using 1:2 with linespoints lw 2 title 'Data', f(x) lw 2 lc 8 title 'f(x)'

