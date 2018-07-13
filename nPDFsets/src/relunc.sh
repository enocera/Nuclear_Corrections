#!/bin/bash


#DSSZ-Fe
wrapfile[1]="DSSZ_NLO_Fe56"
wrapfile[2]="DSSZ_NLO_Fe56_MC"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
EOF

#DSSZ-Pb
wrapfile[1]="DSSZ_NLO_Pb208"
wrapfile[2]="DSSZ_NLO_Pb208_MC"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
EOF

#EPPS-Fe
wrapfile[1]="EPPS16nlo_CT14nlo_Fe56_bd"
wrapfile[2]="EPPS16nlo_CT14nlo_Fe56_MC"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
EOF

#EPPS-Pb
wrapfile[1]="EPPS16nlo_CT14nlo_Pb208_bd"
wrapfile[2]="EPPS16nlo_CT14nlo_Pb208_MC"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
EOF

#EPPS-Cu
wrapfile[1]="EPPS16nlo_CT14nlo_Cu64_bd"
wrapfile[2]="EPPS16nlo_CT14nlo_Cu64_MC"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
EOF

#nCTEQ-Fe
wrapfile[1]="nCTEQ15_56_26"
wrapfile[2]="nCTEQ15_56_26_MC"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
EOF

#nCTEQ-Pb
wrapfile[1]="nCTEQ15_208_82"
wrapfile[2]="nCTEQ15_208_82_MC"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
EOF

#nCTEQ-Pb
wrapfile[1]="nCTEQ15_64_32"
wrapfile[2]="nCTEQ15_64_32_MC"

./relunc<<EOF
"${wrapfile[1]}"
"${wrapfile[2]}"
EOF

exit 0
