#!/bin/bash

namePDFset[1]="nCTEQ15FullNuc_56_26"
namePDFset[2]="nCTEQ15FullNuc_208_82"
namePDFset[3]="EPPS16nlo_CT14nlo_Fe56"
namePDFset[4]="EPPS16nlo_CT14nlo_Pb208"
namePDFset[5]="nCTEQ15_56_26"
namePDFset[6]="nCTEQ15_208_82"
namePDFset[7]="DSSZ_NLO_Fe56"
namePDFset[8]="DSSZ_NLO_Pb208"

PDFset[1]="nCTEQ15_1"
PDFset[2]="nCTEQ15_1"
PDFset[3]="CT14nlo"
PDFset[4]="CT14nlo"
PDFset[5]="nCTEQ15_1"
PDFset[6]="nCTEQ15_1"
PDFset[7]="MSTW2008nlo68cl"
PDFset[8]="MSTW2008nlo68cl"


PID[1]=21
PID[2]=-3
PID[3]=-1
PID[4]=-2
PID[5]=+2
PID[6]=+1
PID[7]=+3

#This is the energy scale
Q[1]=10     #GeV
Q[2]=3.1622 #GeV
Q[3]=2 #GeV

for ipdf in `seq 7 8`
do
for iPID in `seq 1 7`
do
for iQ in `seq 1 3`
do
python plotratio.py "${namePDFset[ipdf]}" "${PDFset[ipdf]}" ${PID[iPID]} ${Q[iQ]}
done
done
done

exit 0



