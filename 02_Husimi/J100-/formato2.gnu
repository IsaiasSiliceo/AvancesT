# Call this format to get a contour plot below a surface from a file with columns x y z

set dgrid3d 60,60
set pm3d at b
set ticslevel 0.8
set view 60,45
#set view 65,333
# set hidden3d
unset colorbox
#set palette model RGB
#set palette defined ( -1 "#000080", 0 "#008B8B", 1 "#FFFF00" )
unset ztics
unset key
#splot 'Q.dat' using 1:2:3 with lines


