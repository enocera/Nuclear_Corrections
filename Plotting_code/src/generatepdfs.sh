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

#This is the energy scale
Q[1]=10     #GeV
Q[2]=3.1622 #GeV

PID[1]=21
PID[2]=-3
PID[3]=-1
PID[4]=-2
PID[5]=+2
PID[6]=+1
PID[7]=+3


for ipdf in `seq 1 9`
do
for iQ in `seq 1 2`
do
for iPID in `seq 1 7`
do
python genpdf.py "${namePDFset[ipdf]}" ${PID[iPID]} ${Q[iQ]}
done
done
done

exit 0
