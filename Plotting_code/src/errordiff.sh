#!/bin/bash

PDFsets[1]="DSSZ_NLO_Fe56"
PDFsets[2]="DSSZ_NLO_Pb208"
PDFsets[3]="nCTEQ15FullNuc_56_26"
PDFsets[4]="nCTEQ15FullNuc_208_82"
PDFsets[5]="EPPS16nlo_CT14nlo_Fe56"
PDFsets[6]="EPPS16nlo_CT14nlo_Pb208"

PID[1]=21
PID[2]=-3
PID[3]=+3
PID[4]=+11
PID[5]=-11
PID[6]=+22
PID[7]=-22

#This is the energy scale
Q[1]=10     #GeV
Q[2]=3.1622 #GeV
Q[3]=2 #GeV

for ipdf in `seq 1 6`
do
for iPID in `seq 1 7`
do
for iQ in `seq 1 3`
do
python errordiff.py ${PID[iPID]} ${Q[iQ]} ${PDFset[ipdf]} "${PDFset[ipdf]}_MC" "${PDFset[ipdf]}_MC_100" "${PDFset[ipdf]}_MC_1000"
done
done
done

exit 0

