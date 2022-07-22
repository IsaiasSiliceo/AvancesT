
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output "Pendiente.png" 
file= 'datos.dat'

set title '{/:Bold=16 Slope of linear fits as a function of N_{even}}'

set grid lw 2
set key top left
set ylabel 'Slope' rotate by 0
set xlabel 'N_{even}'


plot file using 1:2 lw 2 lc 1 ps 2 pt 1 notitle
