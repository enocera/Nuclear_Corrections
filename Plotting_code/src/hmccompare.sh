#!/bin/bash

MCset[1]="DSSZ_NLO_Fe56 DSSZ_NLO_Fe56_MC"
MCset[2]="DSSZ_NLO_Fe56 DSSZ_NLO_Fe56_MC_100"
MCset[3]="DSSZ_NLO_Fe56 DSSZ_NLO_Fe56_MC_1000"
MCset[4]="DSSZ_NLO_Fe56 DSSZ_NLO_Fe56_MC_1000_compressed_25"

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

for iMC in `seq 1 4`
do
for iPID in `seq 1 7`
do
for iQ in `seq 2 2`
do
python hmccompare.py ${PID[iPID]} ${Q[iQ]} ${MCset[iMC]}
done
done
done
exit 0
