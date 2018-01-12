#!/bin/bash

PDFsets[1]="nCTEQ15FullNuc_208_82 EPPS16nlo_CT14nlo_Pb208 DSSZ_NLO_Pb208"
PDFsets[2]="nCTEQ15FullNuc_56_26 EPPS16nlo_CT14nlo_Fe56 DSSZ_NLO_Fe56"
PDFsets[3]="DSSZ_NLO_Fe56 DSSZ_NLO_Fe56_MC DSSZ_NLO_Fe56_MC_100"
PDFsets[4]="DSSZ_NLO_Pb208 DSSZ_NLO_Pb208_MC DSSZ_NLO_Pb208_MC_100"
PDFsets[5]="nCTEQ15FullNuc_56_26 nCTEQ15FullNuc_56_26_MC nCTEQ15FullNuc_56_26_MC_100"
PDFsets[6]="nCTEQ15FullNuc_208_82 nCTEQ15FullNuc_208_82_MC nCTEQ15FullNuc_208_82_MC_100"
PDFsets[7]="EPPS16nlo_CT14nlo_Fe56 EPPS16nlo_CT14nlo_Fe56_MC EPPS16nlo_CT14nlo_Fe56_MC_100"
PDFsets[8]="EPPS16nlo_CT14nlo_Pb208 EPPS16nlo_CT14nlo_Pb208_MC EPPS16nlo_CT14nlo_Pb208_MC_100"

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

for icomb in `seq 5 6`
do
for iPID in `seq 1 7`
do
for iQ in `seq 2 3`
do
python groupplot.py ${PID[iPID]} ${Q[iQ]} ${PDFsets[icomb]} 
done
done
done

exit 0

