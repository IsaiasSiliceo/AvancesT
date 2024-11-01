#!/bin/bash

echo 'Graficando'

index=("0" "1" "2" "3" "4" "5")
states=("66" "67" "68" "69" "70" "71" "72" "73" "74" "75" "76" "77")
names=("66-67" "68-69" "70-71" "72-73" "74-75" "76-77")

for num in ${index[@]};
do
    sed -i '5 d' WvsGmx1.gnu
    sed -i "5 i set output '"${names[$num]}".png'" WvsGmx1.gnu
    sed -i '6 d' WvsGmx1.gnu
    sed -i "6 i file = 'N196/"${names[$num]}".dat'" WvsGmx1.gnu
    sed -i '7 d' WvsGmx1.gnu
    sed -i "7 i state1 = 'k="${states[2*$num]}"'" WvsGmx1.gnu
    sed -i '8 d' WvsGmx1.gnu
    sed -i "8 i state2 = 'k="${states[2*$num+1]}"'" WvsGmx1.gnu
    gnuplot -persist <<EOF
load 'WvsGmx1.gnu'
quit
EOF
done
