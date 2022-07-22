
set terminal pngcairo font 'Helvetica, 16' size 1024,768 enhanced color
set output "Std2.png" 
file= 'tabla.dat'

set title '{/:Bold=16  Log({/Symbol s}) of Gaussian fits as a function of energy difference}'
set grid lw 2
set key top left
set ylabel 'Log({/Symbol s_N})'
set xlabel 'Log({/Symbol D} E_N)'
set yrange [*:0]

f(x) = A*x+a
g(x) = B*x+b
h(x) = C*x+c
i(x) = D*x+d
j(x) = E*x+e
k(x) = F*x+f

#styles = '"#FF0000" "#FF4500" "#006400" "#008080" "#4B0082" "#FF1493" #"#778899" "#000000"'

#do for[t=1:8]{
#	set style line t lt rgb word(styles, t) lw 2
#}

fit f(x) file using (log($1)):(log($2)) index 0 via A,a
fit g(x) file using (log($1)):(log($2)) index 1 via B,b
#fit h(x) file using (log($1)):(log($2)) index 2 via C,c
#fit i(x) file using (log($1)):(log($2)) index 3 via D,d
#fit j(x) file using (log($1)):(log($2)) index 4 via E,e
#fit k(x) file using (log($1)):(log($2)) index 5 via F,f

set label '{/Helvetica y_{170}=1.03204x+1.60843 }' at -15, -22
set label '{/Helvetica y_{340}=1.04221x+2.28601 }' at -15, -24
#set label '{/Helvetica y_{170}=1.03204x+1.60843 }' at -15, -26
#set label '{/Helvetica y_{174}=1.05406x+2.0883 }' at -15, -28
#set label '{/Helvetica y_{186}=1.01634+2.44515}' at -15, -30
#set label '{/Helvetica y_{196}=1.05312x+4.18118 }' at -15, -32


plot for [i=0:1] file using (log($1)):(log($2)) index i ls i+1 notitle, f(x) lw 2 lc 1 title 'N=170, J=100', g(x) lw 2 lc 2 title 'N=340, J=200'

