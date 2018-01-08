#!/bin/bash

PDFsets[1]="nCTEQ15FullNuc_208_82 EPPS16nlo_CT14nlo_Pb208 DSSZ_NLO_Pb208"

PID[1]=21
PID[2]=-3
PID[3]=-1
PID[4]=-2
PID[5]=+3
PID[6]=+11
PID[7]=-11
PID[8]=+22
PID[9]=-22

#This is the energy scale
Q[1]=10     #GeV
Q[2]=3.1622 #GeV
Q[3]=2 #GeV

for iPID in `seq 1 9`
do
for iQ in `seq 1 3`
do
python groupplot.py ${PID[iPID]} ${Q[iQ]} ${PDFsets[1]} 
done
done


exit 0

