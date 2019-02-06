#!/bin/bash

#DSSZ-Fe
wrapfile="DSSZ_NLO_Fe56_MC"
Q2=10

./Rs<<EOF
"${wrapfile}"
$Q2
EOF

#DSSZ-Pb
wrapfile="DSSZ_NLO_Pb208_MC"
Q2=10
./Rs<<EOF
"${wrapfile}"
$Q2
EOF

#EPPS-Fe
wrapfile="EPPS16nlo_CT14nlo_Fe56_MC"
Q2=10

./Rs<<EOF
"${wrapfile}"
$Q2
EOF

#EPPS-Pb
wrapfile="EPPS16nlo_CT14nlo_Pb208_MC"
Q2=10

./Rs<<EOF
"${wrapfile}"
$Q2
EOF

#EPPS-Cu
wrapfile="EPPS16nlo_CT14nlo_Cu64_MC"
Q2=100

./Rs<<EOF
"${wrapfile}"
$Q2
EOF

#nCTEQ-Fe
wrapfile="nCTEQ15_56_26_MC"
Q2=10

./Rs<<EOF
"${wrapfile}"
$Q2
EOF

#nCTEQ-Pb
wrapfile="nCTEQ15_208_82_MC"
Q2=10

./Rs<<EOF
"${wrapfile}"
$Q2
EOF

#nCTEQ-Cu
wrapfile="nCTEQ15_64_32_MC"
Q2=100

./Rs<<EOF
"${wrapfile}"
$Q2
EOF

exit 0
