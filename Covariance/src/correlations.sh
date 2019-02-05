#!/bin/bash

fl[1]=-3
fl[2]=-2
fl[3]=-1
fl[4]=3

for i in `seq 1 4`
do
./correlations<<EOF
${fl[i]}
EOF
done

exit 0
