#!/bin/bash

namePDFset[1]="DSSZ_NLO_Fe56"
namePDFset[2]="DSSZ_NLO_Pb208"

# This is the energy scale
Q[1]=10     #GeV
Q[2]=3.1622 #GeV
Q[3]=2 #GeV

# Nuclear information
A[1]=56
A[2]=208

Z[1]=26
Z[2]=82



for ipdf in `seq 1 2`
do
for iQ in `seq 1 3`
do
python boundptransform.py "${namePDFset[ipdf]}" "${namePDFset[ipdf]}_bp" ${A[ipdf]} ${Z[ipdf]} ${Q[iQ]}
done
done


exit 0
