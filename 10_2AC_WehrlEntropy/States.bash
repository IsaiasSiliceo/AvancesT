#!/bin/bash
clear
echo 'Wehrl Entropy:'

#Vamos a automatizar el cálculo de la entropía por estados.

echo 'Procesando datos para N=196'
#Esto debe hacerlo una vez antes del loop
sed -i '22 d' src/Diagonalizacion.f90
sed -i "22 i\   \string1 =  '28_72/gmx/'//gamma" src/Diagonalizacion.f90
sed -i '23 d' src/Diagonalizacion.f90
sed -i "23 i\   \string2 = '28_72/evals/'//valores" src/Diagonalizacion.f90
sed -i '24 d' src/Diagonalizacion.f90
sed -i "24 i\   \string3 = '28_72/states/'" src/Diagonalizacion.f90


index=("2" "3" "4" "5" "6" "7")
names=("64-65.dat" "66-67.dat" "68-69.dat" "70-71.dat" "72-73.dat" "74-75.dat" "76-77.dat")
#Esto debe hacerlo de forma recursiva

for num in ${index[@]};
do
    sed -i '20 d' src/Diagonalizacion.f90
    sed -i "20 i\   \gamma = 'gmx"$num".dat'" src/Diagonalizacion.f90
    sed -i '21 d' src/Diagonalizacion.f90
    sed -i "21 i\  \ valores = 'Evals"$num".dat'" src/Diagonalizacion.f90
    sed -i '25 d' src/Diagonalizacion.f90
    sed -i "25 i\  \ bb = "$num src/Diagonalizacion.f90
    echo "Files: 'gmx"$num".dat', 'Evals"$num".dat'"
    make clean
    make
    make move
    ./LMG
    mv 'Wehrl.dat' 'N196/'${names[$num-1]}
done
