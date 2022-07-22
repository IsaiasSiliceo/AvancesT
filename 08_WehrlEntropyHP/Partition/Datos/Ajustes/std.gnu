
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output "StdDev.png" 

set title 'Parameter {/Symbol s} of Gaussian fits, levels (k=64-75)'
set log y
set log x
set grid lw 2
set ylabel 'Parameter {/Symbol s}'
set xlabel '{/Symbol D} E_i'
f(x) = m*x
set label '{/Helvetica y=4.95568x }' at 1e-7, 1e-7
fit f(x) 'Tabla2.dat' using 1:2 via m

plot 'Tabla2.dat' using 1:2:3 with yerrorbars lw 2 title 'Data', f(x) lw 2 lc 8 title 'Linear fit'

