#!/bin/bash

#DSSZ-Fe
wrapfile="DSSZ_NLO_Fe56_MC"

./xPDFs<<EOF
"${wrapfile}"
EOF

#DSSZ-Pb
wrapfile="DSSZ_NLO_Pb208_MC"

./xPDFs<<EOF
"${wrapfile}"
EOF

#EPPS-Fe
wrapfile="EPPS16nlo_CT14nlo_Fe56_MC"

./xPDFs<<EOF
"${wrapfile}"
EOF

#EPPS-Pb
wrapfile="EPPS16nlo_CT14nlo_Pb208_MC"

./xPDFs<<EOF
"${wrapfile}"
EOF

#EPPS-Cu
wrapfile="EPPS16nlo_CT14nlo_Cu64_MC"

./xPDFs<<EOF
"${wrapfile}"
EOF

#nCTEQ-Fe
wrapfile="nCTEQ15_56_26_MC"

./xPDFs<<EOF
"${wrapfile}"
EOF

#nCTEQ-Pb
wrapfile="nCTEQ15_208_82_MC"

./xPDFs<<EOF
"${wrapfile}"
EOF

#nCTEQ-Cu
wrapfile="nCTEQ15_64_32_MC"

./xPDFs<<EOF
"${wrapfile}"
EOF

exit 0
