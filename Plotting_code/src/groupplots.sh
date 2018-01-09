#!/bin/bash

PDFsets[1]="nCTEQ15FullNuc_208_82 EPPS16nlo_CT14nlo_Pb208 DSSZ_NLO_Pb208"

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

for iPID in `seq 1 7`
do
for iQ in `seq 1 3`
do
python groupplot.py ${PID[iPID]} ${Q[iQ]} ${PDFsets[1]} 
done
done


exit 0

