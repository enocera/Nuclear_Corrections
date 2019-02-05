#!/bin/bash

#fl[1]=-3
fl[1]=-2
fl[2]=-1
#fl[4]=3

for i in `seq 1 2`
do
./correlations<<EOF
${fl[i]}
EOF
done

exit 0
