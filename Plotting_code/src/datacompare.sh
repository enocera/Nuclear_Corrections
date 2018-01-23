#!/bin/bash

PDFstring[1]=DSSZ_NLO_Fe56
PDFstring[2]=DSSZ_NLO_Pb208
PDFstring[3]=nCTEQ15FullNuc_56_26
PDFstring[4]=nCTEQ15FullNuc_208_82
PDFstring[5]=EPPS16nlo_CT14nlo_Fe56
PDFstring[6]=EPPS16nlo_CT14nlo_Pb208

PID[1]=21
PID[2]=+3
PID[3]=+11
PID[4]=-11
PID[5]=+22
PID[6]=-22

#This is the energy scale
Q[1]=10     #GeV
Q[2]=3.16227766017 #GeV
Q[3]=2 #GeV

for ipdf in `seq 1 6`
do
for iPID in `seq 1 6`
do
for iQ in `seq 2 2`
do
python datacompare.py ${PDFstring[ipdf]} ${PID[iPID]} ${Q[iQ]}
done
done
done
exit 0
