#Correlation coefficients and nuclear PDFs

#CHORUS
infileDSSZuv = "../../nPDFsets/res/DSSZ_NLO_Pb208_MC/xPDFs_2.res"
infileDSSZdv = "../../nPDFsets/res/DSSZ_NLO_Pb208_MC/xPDFs_1.res"
infileEPPSuv = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Pb208_MC/xPDFs_2.res"
infileEPPSdv = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Pb208_MC/xPDFs_1.res"
infilenCTEQuv = "../../nPDFsets/res/nCTEQ15_208_82_MC/xPDFs_2.res"
infilenCTEQdv = "../../nPDFsets/res/nCTEQ15_208_82_MC/xPDFs_1.res"

#NUTEV
infileDSSZs  = "../../nPDFsets/res/DSSZ_NLO_Fe56_MC/xPDFs_3.res"
infileDSSZsb = "../../nPDFsets/res/DSSZ_NLO_Fe56_MC/xPDFs_-3.res"
infileEPPSs  = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_3.res"
infileEPPSsb = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_-3.res"
infilenCTEQs  = "../../nPDFsets/res/nCTEQ15_56_26_MC/xPDFs_3.res"
infilenCTEQsb = "../../nPDFsets/res/nCTEQ15_56_26_MC/xPDFs_-1.res"

#E605
infileEPPSub = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Cu64_MC/xPDFs_-2.res"
infileEPPSdb = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Cu64_MC/xPDFs_-1.res"
infilenCTEQub = "../../nPDFsets/res/nCTEQ15_64_32_MC/xPDFs_-2.res"
infilenCTEQdb = "../../nPDFsets/res/nCTEQ15_64_32_MC/xPDFs_-1.res"

outfile="../figs/nPDFs.png"

set o outfile
set term pngcairo font 'Helvetica,20' size 1500,750 enh
set multiplot layout 3,4

#First panel - CHORUS - log scale
set border 7
set tmargin at screen 0.945
set bmargin at screen 0.685
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "R@^{Pb}_{u_V} (x,Q^2)" font 'Helvetica,24' at 0.013,1.75
set label "Q^2=10 GeV^2" font 'Helvetica,22' at 0.013,0.35

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)

set yrange[0:2]
set ytics ("" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
              1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
              1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
              2.00 0) nomirror

plot infileDSSZuv u 2:($3) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZuv u 2:(($3+$4/2)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZuv u 2:(($3-$4/2)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZuv u 2:(($3+$4/2)):(($3-$4/2)) w filledcu fs transparent\
     pattern 4 lt 1 lc rgb "red" notitle,\
     infileEPPSuv u 2:($3) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSuv u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSuv u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSuv u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQuv u 2:($3) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQuv u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQuv u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQuv u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border 
unset ytics
unset label
unset key

#First panel - CHORUS - lin scale
set border 13
set tmargin at screen 0.945
set bmargin at screen 0.685
set lmargin at screen 0.25
set rmargin at screen 0.495

set style rect fc rgb "gray" fs transparent pattern 9 noborder
set obj rect from 0.1,graph 0 to 0.7,2

set xrange[0.1:0.7]
set xtics( "" 0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
           "" 0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
           "" 0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
           "" 0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
           "" 0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
           "" 0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
           "" 0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
           "" 0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
           "" 0.9 0)

set y2range[0:2]
set y2tics ("" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
            "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
            "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
            "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
            "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
            "" 2.00 0) nomirror

plot infileDSSZuv u 2:($3) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZuv u 2:(($3+$4/2)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZuv u 2:(($3-$4/2)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZuv u 2:(($3+$4/2)):(($3-$4/2)) w filledcu fs transparent\
     pattern 4 lt 1 lc rgb "red" notitle,\
     infileEPPSuv u 2:($3) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSuv u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSuv u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSuv u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQuv u 2:($3) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQuv u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQuv u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQuv u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset obj
unset logscale x
unset border 
unset ytics
unset y2tics
unset label
unset key

#First panel - CHORUS - log scale
set border 7
set tmargin at screen 0.945
set bmargin at screen 0.685
set lmargin at screen 0.505
set rmargin at screen 0.65

set label "R@^{Pb}_{d_V} (x,Q^2)" font 'Helvetica,24' at 0.013,1.75

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[0:2]
set ytics ("" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
           "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
           "" 2.00 0) nomirror

plot infileDSSZdv u 2:($3) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZdv u 2:(($3+$4/2)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZdv u 2:(($3-$4/2)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZdv u 2:(($3+$4/2)):(($3-$4/2)) w filledcu fs transparent\
     pattern 4 lt 1 lc rgb "red" notitle,\
     infileEPPSdv u 2:($3) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdv u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdv u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdv u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQdv u 2:($3) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdv u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdv u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdv u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle


unset logscale x
unset border 
unset ytics
unset label

#First panel - CHORUS - lin scale
set border 13
set tmargin at screen 0.945
set bmargin at screen 0.685
set lmargin at screen 0.65
set rmargin at screen 0.895

set style rect fc rgb "gray" fs transparent pattern 9 noborder
set obj rect from 0.2,graph 0 to 0.5,2

set xrange[0.1:0.7]
set xtics( "" 0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
           "" 0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
           "" 0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
           "" 0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
           "" 0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
           "" 0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
           "" 0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
           "" 0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
           "" 0.9 0)
set y2range[0:2]
set y2tics ("" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
            "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
               0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
               1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
               1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
               2.00 0) nomirror

plot infileDSSZdv u 2:($3) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZdv u 2:(($3+$4/2)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZdv u 2:(($3-$4/2)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZdv u 2:(($3+$4/2)):(($3-$4/2)) w filledcu fs transparent\
     pattern 4 lt 1 lc rgb "red" notitle,\
     infileEPPSdv u 2:($3) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdv u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdv u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdv u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQdv u 2:($3) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdv u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdv u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdv u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset obj
unset logscale x
unset border 
unset ytics
unset y2tics
unset label

#Second panel - NuTeV - log scale
set border 7
set tmargin at screen 0.675
set bmargin at screen 0.415
set lmargin at screen 0.1
set rmargin at screen 0.25

set style rect fc rgb "gray" fs transparent pattern 9 noborder
set obj rect from 0.01,graph 0 to 0.1,2

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)

set yrange[0:2]
set ytics ("" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
              1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
              1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
              2.00 0) nomirror

plot infileDSSZs u 2:($3) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZs u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZs u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZs u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 4 lt 1 lc rgb "red" notitle,\
     infileEPPSs u 2:($3) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQs u 2:($3) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border 
unset ytics
unset label

#Second panel - NuTeV - lin scale
set border 13
set tmargin at screen 0.675
set bmargin at screen 0.415
set lmargin at screen 0.25
set rmargin at screen 0.495

set style rect fc rgb "gray" fs transparent pattern 9 noborder
set obj rect from 0.1,graph 0 to 0.2,2

set label "R@^{Fe}_{s}   (x,Q^2)" font 'Helvetica,24' at 0.42,1.75
set label "Q^2=10 GeV^2" font 'Helvetica,22' at 0.40,0.35

set xrange[0.1:0.7]
set xtics( "" 0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
           "" 0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
           "" 0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
           "" 0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
           "" 0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
           "" 0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
           "" 0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
           "" 0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
           "" 0.9 0)

set y2range[0:2]
set ytics (100 0)
set y2tics ("" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
            "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
            "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
            "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
            "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
            "" 2.00 0) nomirror

set key at 0.68,1.5

plot infileDSSZs u 2:($2<0.3?($3):1/0) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZs u 2:($2<0.3?(($3+$4)):1/0) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZs u 2:($2<0.3?(($3-$4)):1/0) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZs u 2:($2<0.3?(($3+$4)):1/0):($2<0.3?(($3-$4)):1/0) w filledcu fs transparent\
     pattern 4 lt 1 lc rgb "red" notitle,\
     infileEPPSs u 2:($2<0.3?($3):1/0) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:($2<0.3?(($3+$4)):1/0) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:($2<0.3?(($3-$4)):1/0) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:($2<0.3?(($3+$4)):1/0):($2<0.3?(($3-$4)):1/0) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQs u 2:($2<0.3?($3):1/0) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:($2<0.3?(($3+$4)):1/0) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:($2<0.3?(($3-$4)):1/0) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:($2<0.3?(($3+$4)):1/0):($2<0.3?(($3-$4)):1/0) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle,\
     infileDSSZs u 2:($3+100):($3+101) w filledcu fs transparent\
     pattern 9 lt 1 lc rgb "gray" t "|{/Symbol r}|>0.5"

unset logscale x
unset border 
unset ytics
unset y2tics
unset label
unset key

#Second panel - NuTeV - log scale
set border 7
set tmargin at screen 0.675
set bmargin at screen 0.415
set lmargin at screen 0.505
set rmargin at screen 0.65

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)

set yrange[0:2]
set ytics ("" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
           "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
           "" 2.00 0) nomirror

plot infileDSSZsb u 2:($3) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZsb u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZsb u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZsb u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 4 lt 1 lc rgb "red" notitle,\
     infileEPPSsb u 2:($3) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQs u 2:($3) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border 
unset ytics
unset label

#Second panel - NuTeV - lin scale
set border 13
set tmargin at screen 0.675
set bmargin at screen 0.415
set lmargin at screen 0.65
set rmargin at screen 0.895

set label "R@^{Fe}_{~s\342\200\276}   (x,Q^2)" font 'Helvetica,24' at 0.42,1.75

set xrange[0.1:0.7]
set xtics( "" 0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
           "" 0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
           "" 0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
           "" 0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
           "" 0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
           "" 0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
           "" 0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
           "" 0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
           "" 0.9 0)

set y2range[0:2]
set y2tics ("" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
            "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
               0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
               1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
               1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
               2.00 0) nomirror

set key at 0.68,1.40

plot infileDSSZsb u 2:($2<0.3?($3):1/0) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZsb u 2:($2<0.3?(($3+$4)):1/0) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZsb u 2:($2<0.3?(($3-$4)):1/0) w l lt 1 lw 3 lc rgb "red" notitle,\
     infileDSSZsb u 2:($2<0.3?(($3+$4)):1/0):($2<0.3?(($3-$4)):1/0) w filledcu fs transparent\
     pattern 4 lt 1 lc rgb "red" t "DSSZ12",\
     infileEPPSsb u 2:($2<0.3?($3):1/0) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:($2<0.3?(($3+$4)):1/0) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:($2<0.3?(($3-$4)):1/0) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:($2<0.3?(($3+$4)):1/0):($2<0.3?(($3-$4)):1/0) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" t "EPPS16",\
     infilenCTEQs u 2:($2<0.3?($3):1/0) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:($2<0.3?(($3+$4)):1/0) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:($2<0.3?(($3-$4)):1/0) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:($2<0.3?(($3+$4)):1/0):($2<0.3?(($3-$4)):1/0) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" t "nCTEQ15"

unset obj
unset logscale x
unset border 
unset ytics
unset y2tics
unset label

#Third panel - E605 - log scale
set border 7
set tmargin at screen 0.405
set bmargin at screen 0.155
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "R@^{Cu}_{~u\342\200\276}   (x,Q^2)" font 'Helvetica,24' at 0.013,1.75
set label "Q^2=100 GeV^2" font 'Helvetica,22' at 0.013,0.35

set xrange[0.01:0.1]
set logscale x
set xtics(    0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)

set yrange[0:2]
set ytics (   0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
              1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
              1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
              2.00 0) nomirror

plot infileEPPSub u 2:($3) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQub u 2:($3) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border 
unset ytics
unset label

#Third panel - E605 - lin scale
set border 13
set tmargin at screen 0.405
set bmargin at screen 0.155
set lmargin at screen 0.25
set rmargin at screen 0.495

set style rect fc rgb "gray" fs transparent pattern 9 noborder
set obj rect from 0.3,graph 0 to 0.7,2

set xrange[0.1:0.7]
set xtics(    0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
           "" 0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
              0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
           "" 0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
              0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
           "" 0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
           "" 0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
           "" 0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
           "" 0.9 0)

set xlabel "x" font 'Helvetica,26' offset -7,+0.5

set y2range[0:2]
set ytics (100 0)
set y2tics ("" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
            "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
            "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
            "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
            "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
            "" 2.00 0) nomirror

plot infileEPPSub u 2:($3) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQub u 2:($3) w l  lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3+$4)) w l  lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3-$4)) w l  lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset obj
unset logscale x
unset border 
unset ytics
unset y2tics
unset label
unset xlabel

#Third panel - NuTeV - log scale
set border 7
set tmargin at screen 0.405
set bmargin at screen 0.155
set lmargin at screen 0.505
set rmargin at screen 0.65

set label "R@^{Cu}_{~d\342\200\276}   (x,Q^2)" font 'Helvetica,24' at 0.013,1.75

set xrange[0.01:0.1]
set logscale x
set xtics(    0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)

set yrange[0:2]
set ytics ("" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
           "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
           "" 2.00 0) nomirror

plot infileEPPSdb u 2:($3) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQub u 2:($3) smooth bezier lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3+$4)) smooth bezier lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3-$4)) smooth bezier lt 1 lw 3 lc rgb "#006400" notitle,\
#     infilenCTEQub u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
#     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border 
unset ytics
unset label

#Third panel - NuTeV - lin scale
set border 13
set tmargin at screen 0.405
set bmargin at screen 0.155
set lmargin at screen 0.65
set rmargin at screen 0.895

set style rect fc rgb "gray" fs transparent pattern 9 noborder
set obj rect from 0.3,graph 0 to 0.7,2

set xrange[0.1:0.7]
set xtics(    0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
           "" 0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
              0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
           "" 0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
              0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
           "" 0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
              0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
           "" 0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
           "" 0.9 0)

set xlabel "x" font 'Helvetica,26' offset -7,+0.5

set y2range[0:2]
set y2tics (   0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
            "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
               0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
               1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
               1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
               2.00 0) nomirror

plot infileEPPSdb u 2:($3) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3+$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3-$4)) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQub u 2:($3) smooth bezier lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3+$4)) smooth bezier  lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3-$4)) smooth bezier lt 1 lw 3 lc rgb "#006400" notitle
#     infilenCTEQub u 2:(($3+$4)):(($3-$4)) w filledcu fs transparent\
#     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border 
unset ytics
unset y2tics
unset label
unset xlabel