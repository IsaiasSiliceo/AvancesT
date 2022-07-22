# Check for more colors at https://www.rapidtables.com/web/color/RGB_Color.html
# Call this format to get a contour plot from a file with columns x y z. 
set size square
set pm3d map
set xrange[-2:2]
set format x
set format y
unset key
set palette model RGB
#set palette defined ( -1 "#000080", 0 "#008B8B", 1 "#FFFF00" )
set palette defined ( -1 "#000080", 0 "#32CD32", 1 "#FFFF00" )
#set title 'j=100, gmx=-4, gmy=3gmx, k=64'
#unset colorbox
#splot 'Q.dat' using 1:2:3