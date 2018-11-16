#!/bin/bash

#DSSZ-Fe
wrapfile="DSSZ_NLO_Fe56_MC"
Q2=10
A=56
Z=26

./xPDFs<<EOF
"${wrapfile}"
$Q2
$A
$Z
EOF

#DSSZ-Pb
wrapfile="DSSZ_NLO_Pb208_MC"
Q2=10
A=208
Z=82

./xPDFs<<EOF
"${wrapfile}"
$Q2
$A
$Z
EOF

#EPPS-Fe
wrapfile="EPPS16nlo_CT14nlo_Fe56_MC"
Q2=10
A=56
Z=26

./xPDFs<<EOF
"${wrapfile}"
$Q2
$A
$Z
EOF

#EPPS-Pb
wrapfile="EPPS16nlo_CT14nlo_Pb208_MC"
Q2=10
A=208
Z=82

./xPDFs<<EOF
"${wrapfile}"
$Q2
$A
$Z
EOF

#EPPS-Cu
wrapfile="EPPS16nlo_CT14nlo_Cu64_MC"
Q2=100
A=64
Z=32

./xPDFs<<EOF
"${wrapfile}"
$Q2
$A
$Z
EOF

#nCTEQ-Fe
wrapfile="nCTEQ15_56_26_MC"
Q2=10
A=56
Z=26

./xPDFs<<EOF
"${wrapfile}"
$Q2
$A
$Z
EOF

#nCTEQ-Pb
wrapfile="nCTEQ15_208_82_MC"
Q2=10
A=208
Z=82

./xPDFs<<EOF
"${wrapfile}"
$Q2
$A
$Z
EOF

#nCTEQ-Cu
wrapfile="nCTEQ15_64_32_MC"
Q2=100
A=64
Z=32

./xPDFs<<EOF
"${wrapfile}"
$Q2
$A
$Z
EOF

exit 0
