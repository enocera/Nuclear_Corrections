#!/bin/bash

namePDFset[1]="nCTEQ15FullNuc_56_26"
namePDFset[2]="nCTEQ15FullNuc_208_82"
namePDFset[3]="EPPS16nlo_CT14nlo_Fe56"
namePDFset[4]="EPPS16nlo_CT14nlo_Pb208"
namePDFset[5]="nCTEQ15_56_26"
namePDFset[6]="nCTEQ15_208_82"
namePDFset[7]="DSSZ_NLO_Fe56"
namePDFset[8]="DSSZ_NLO_Pb208"
namePDFset[9]="DSSZ_NLO_Fe56_MC"
namePDFset[10]="DSSZ_NLO_Fe56_MC_100"
namePDFset[11]="DSSZ_NLO_Pb208_MC"
namePDFset[12]="DSSZ_NLO_Pb208_MC_100"
namePDFset[13]="EPPS16nlo_CT14nlo_Fe56_MC"
namePDFset[14]="EPPS16nlo_CT14nlo_Fe56_MC_100"
namePDFset[15]="EPPS16nlo_CT14nlo_Pb208_MC"
namePDFset[16]="EPPS16nlo_CT14nlo_Pb208_MC_100"
namePDFset[17]="nCTEQ15FullNuc_208_82_MC"
namePDFset[18]="nCTEQ15FullNuc_208_82_MC_100"
namePDFset[19]="nCTEQ15FullNuc_56_26_MC"
namePDFset[20]="nCTEQ15FullNuc_56_26_MC_100"


PDFset[1]="nCTEQ15_1"
PDFset[2]="nCTEQ15_1"
PDFset[3]="CT14nlo"
PDFset[4]="CT14nlo"
PDFset[5]="nCTEQ15_1"
PDFset[6]="nCTEQ15_1"
PDFset[7]="MSTW2008nlo68cl"
PDFset[8]="MSTW2008nlo68cl"
PDFset[9]="MSTW2008nlo68cl"
PDFset[10]="MSTW2008nlo68cl"
PDFset[11]="MSTW2008nlo68cl"
PDFset[12]="MSTW2008nlo68cl"
PDFset[13]="CT14nlo"
PDFset[14]="CT14nlo"
PDFset[15]="CT14nlo"
PDFset[16]="CT14nlo"
PDFset[17]="nCTEQ15_1"
PDFset[18]="nCTEQ15_1"
PDFset[19]="nCTEQ15_1"
PDFset[20]="nCTEQ15_1"

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

for ipdf in `seq 9 20`
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



