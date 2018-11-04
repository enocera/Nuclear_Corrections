#!/bin/bash

fl[1]=-3
fl[2]=-2
fl[3]=-1
fl[4]=0
fl[5]=1
fl[6]=2
fl[7]=3

for i in `seq 1 7`
do
./correlations<<EOF
${fl[i]}
EOF
done

exit 0
