#!/bin/bash

MCset[1]="DSSZ_NLO_Fe56 DSSZ_NLO_Fe56_MC"
MCset[2]="DSSZ_NLO_Fe56 DSSZ_NLO_Fe56_MC_100"
MCset[3]="DSSZ_NLO_Fe56 DSSZ_NLO_Fe56_MC_1000"
MCset[4]="DSSZ_NLO_Fe56 DSSZ_NLO_Fe56_MC_1000_compressed_25"

MCset[5]="DSSZ_NLO_Pb208 DSSZ_NLO_Pb208_MC"
MCset[6]="DSSZ_NLO_Pb208 DSSZ_NLO_Pb208_MC_100"
MCset[7]="DSSZ_NLO_Pb208 DSSZ_NLO_Pb208_MC_1000"
MCset[8]="DSSZ_NLO_Pb208 DSSZ_NLO_Pb208_MC_1000_compressed_25"

MCset[9]="nCTEQ15FullNuc_56_26 nCTEQ15FullNuc_56_26_MC"
MCset[10]="nCTEQ15FullNuc_56_26 nCTEQ15FullNuc_56_26_MC_100"
MCset[11]="nCTEQ15FullNuc_56_26 nCTEQ15FullNuc_56_26_MC_1000"
MCset[12]="nCTEQ15FullNuc_56_26 nCTEQ15FullNuc_56_26_MC_1000_compressed_25"

MCset[13]="nCTEQ15FullNuc_208_82 nCTEQ15FullNuc_208_82_MC"
MCset[14]="nCTEQ15FullNuc_208_82 nCTEQ15FullNuc_208_82_MC_100"
MCset[15]="nCTEQ15FullNuc_208_82 nCTEQ15FullNuc_208_82_MC_1000"
MCset[16]="nCTEQ15FullNuc_208_82 nCTEQ15FullNuc_208_82_MC_1000_compressed_25"

MCset[17]="EPPS16nlo_CT14nlo_Fe56 EPPS16nlo_CT14nlo_Fe56_MC"
MCset[18]="EPPS16nlo_CT14nlo_Fe56 EPPS16nlo_CT14nlo_Fe56_MC_100"
MCset[19]="EPPS16nlo_CT14nlo_Fe56 EPPS16nlo_CT14nlo_Fe56_MC_1000"
MCset[20]="EPPS16nlo_CT14nlo_Fe56 EPPS16nlo_CT14nlo_Fe56_MC_1000_compressed_25"

MCset[21]="EPPS16nlo_CT14nlo_Pb208 EPPS16nlo_CT14nlo_Pb208_MC"
MCset[22]="EPPS16nlo_CT14nlo_Pb208 EPPS16nlo_CT14nlo_Pb208_MC_100"
MCset[23]="EPPS16nlo_CT14nlo_Pb208 EPPS16nlo_CT14nlo_Pb208_MC_1000"
MCset[24]="EPPS16nlo_CT14nlo_Pb208 EPPS16nlo_CT14nlo_Pb208_MC_1000_compressed_25"

PID[1]=21
PID[2]=-3
PID[3]=+3
PID[4]=+1
PID[5]=-1
PID[6]=+2
PID[7]=-2

#This is the energy scale
Q[1]=10     #GeV
Q[2]=3.16227766017 #GeV
Q[3]=2 #GeV

for iMC in `seq 1 24`
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
