#!/bin/bash

namePDFset[1]="CT14nlo"
namePDFset[2]="nCTEQ15FullNuc_56_26"
namePDFset[3]="nCTEQ15FullNuc_208_82"
namePDFset[4]="EPPS16nlo_CT14nlo_Fe56"
namePDFset[5]="EPPS16nlo_CT14nlo_Pb208"
namePDFset[6]="cteq6"
namePDFset[7]="nCTEQ15_1"
namePDFset[8]="nCTEQ15_56_26"
namePDFset[9]="nCTEQ15_208_82"
namePDFset[10]="MSTW2008nlo68cl"
namePDFset[11]="DSSZ_NLO_Fe56"
namePDFset[12]="DSSZ_NLO_Pb208"

# Fill in the corresponding proton and mass numbers for each PDF set
A[1]=1
A[2]=56
A[3]=208
A[4]=56
A[5]=208
A[6]=1
A[7]=1
A[8]=56
A[9]=208
A[10]= 1
A[11]=56
A[12]=208

Z[1]=1
Z[2]=26
Z[3]=82
Z[4]=26
Z[5]=82
Z[6]=1
Z[7]=1
Z[8]=26
Z[9]=82
Z[10]=1
Z[11]=26
Z[12]=208

#This is the energy scale
Q[1]=10     #GeV
Q[2]=3.1622 #GeV
Q[3]=2 #GeV

for ipdf in `seq 1 12`
do
for iQ in `seq 1 3`
do
python genpdf.py "${namePDFset[ipdf]}" ${A[ipdf]} ${Z[ipdf]} ${Q[iQ]}
done
done

exit 0
