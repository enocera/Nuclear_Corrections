#!/bin/bash


#DSSZ-Fe
wrapfile[1]="DSSZ_NLO_Fe56"
wrapfile[2]="DSSZ_NLO_Fe56_MC"
wrapfile[3]="DSSZ_NLO_Fe56_MC_100"
wrapfile[4]="DSSZ_NLO_Fe56_MC_1000"
wrapfile[5]="DSSZ_NLO_Fe56_MC_1000_compressed_25"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
"${wrapfile[3]}"
"${wrapfile[4]}"
"${wrapfile[5]}"
EOF

#DSSZ-Pb
wrapfile[1]="DSSZ_NLO_Pb208"
wrapfile[2]="DSSZ_NLO_Pb208_MC"
wrapfile[3]="DSSZ_NLO_Pb208_MC_100"
wrapfile[4]="DSSZ_NLO_Pb208_MC_1000"
wrapfile[5]="DSSZ_NLO_Pb208_MC_1000_compressed_25"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
"${wrapfile[3]}"
"${wrapfile[4]}"
"${wrapfile[5]}"
EOF

#EPPS-Fe
wrapfile[1]="EPPS16nlo_CT14nlo_Fe56"
wrapfile[2]="EPPS16nlo_CT14nlo_Fe56_MC"
wrapfile[3]="EPPS16nlo_CT14nlo_Fe56_MC_100"
wrapfile[4]="EPPS16nlo_CT14nlo_Fe56_MC_1000"
wrapfile[5]="EPPS16nlo_CT14nlo_Fe56_MC_1000_compressed_25"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
"${wrapfile[3]}"
"${wrapfile[4]}"
"${wrapfile[5]}"
EOF

#EPPS-Pb
wrapfile[1]="EPPS16nlo_CT14nlo_Pb208"
wrapfile[2]="EPPS16nlo_CT14nlo_Pb208_MC"
wrapfile[3]="EPPS16nlo_CT14nlo_Pb208_MC_100"
wrapfile[4]="EPPS16nlo_CT14nlo_Pb208_MC_1000"
wrapfile[5]="EPPS16nlo_CT14nlo_Pb208_MC_1000_compressed_25"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
"${wrapfile[3]}"
"${wrapfile[4]}"
"${wrapfile[5]}"
EOF

#nCTEQ-Fe
wrapfile[1]="nCTEQ15FullNuc_56_26"
wrapfile[2]="nCTEQ15FullNuc_56_26_MC"
wrapfile[3]="nCTEQ15FullNuc_56_26_MC_100"
wrapfile[4]="nCTEQ15FullNuc_56_26_MC_1000"
wrapfile[5]="nCTEQ15FullNuc_56_26_MC_1000_compressed_25"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
"${wrapfile[3]}"
"${wrapfile[4]}"
"${wrapfile[5]}"
EOF

#nCTEQ-Pb
wrapfile[1]="nCTEQ15FullNuc_208_82"
wrapfile[2]="nCTEQ15FullNuc_208_82_MC"
wrapfile[3]="nCTEQ15FullNuc_208_82_MC_100"
wrapfile[4]="nCTEQ15FullNuc_208_82_MC_1000"
wrapfile[5]="nCTEQ15FullNuc_208_82_MC_1000_compressed_25"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
"${wrapfile[3]}"
"${wrapfile[4]}"
"${wrapfile[5]}"
EOF

exit 0
