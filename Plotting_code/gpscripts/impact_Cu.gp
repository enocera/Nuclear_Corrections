#Correlation coefficients and nuclear PDFs
infilecorr_up_1="../../Covariance/res/corrs_DYE605_2.res"
infilecorr_ub_1="../../Covariance/res/corrs_DYE605_-2.res"
infilecorr_do_1="../../Covariance/res/corrs_DYE605_1.res"
infilecorr_db_1="../../Covariance/res/corrs_DYE605_-1.res"
infilecorr_st_1="../../Covariance/res/corrs_DYE605_3.res"
infilecorr_sb_1="../../Covariance/res/corrs_DYE605_-3.res"
infilecorr_gl_1="../../Covariance/res/corrs_DYE605_0.res"

infileEPPSu  = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_2.res"
infileEPPSd  = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_1.res"
infileEPPSs  = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_3.res"
infileEPPSub = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_-2.res"
infileEPPSdb = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_-1.res"
infileEPPSsb = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_-3.res"
infileEPPSg  = "../../nPDFsets/res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_0.res"

infilenCTEQu  = "../../nPDFsets/res/nCTEQ15_56_26_MC/xPDFs_2.res"
infilenCTEQd  = "../../nPDFsets/res/nCTEQ15_56_26_MC/xPDFs_1.res"
infilenCTEQs  = "../../nPDFsets/res/nCTEQ15_56_26_MC/xPDFs_3.res"
infilenCTEQub = "../../nPDFsets/res/nCTEQ15_56_26_MC/xPDFs_-2.res"
infilenCTEQdb = "../../nPDFsets/res/nCTEQ15_56_26_MC/xPDFs_-1.res"
infilenCTEQsb = "../../nPDFsets/res/nCTEQ15_56_26_MC/xPDFs_-1.res"
infilenCTEQg  = "../../nPDFsets/res/nCTEQ15_56_26_MC/xPDFs_0.res"

outfile="../figs/impact_DYE605.png"

set o outfile
set term pngcairo font 'Helvetica,20' size 1500,2000 enh
set multiplot layout 7,2

#First panel - nPDFs - log scale
set border 7
set tmargin at screen 0.895
set bmargin at screen 0.8025
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "R_g(x,Q^2)" font 'Helvetica,24' at 0.013,1.5

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[0.25:1.75]
set ytics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
              1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
              1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0) nomirror

set label "DYE605" font 'Helvetica,28' at 550,1.5
set label "Q^2=100 GeV" font 'Helvetica,24' at 300,0.0
set key font 'Helvetica,24' at 2400,1.25 spacing 1.2

plot infileEPPSg u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSg u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSg u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSg u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" t "EPPS16",\
     infilenCTEQg u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQg u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQg u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQg u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" t "nCTEQ15"

unset logscale x
unset border
unset ytics
unset label
unset key

#First panel - nPDFs - lin scale
set border 13
set tmargin at screen 0.895
set bmargin at screen 0.8025
set lmargin at screen 0.25
set rmargin at screen 0.495

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

set y2range[0.25:1.75]
set y2tics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
            "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
            "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
            "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0) nomirror

plot infileEPPSg u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSg u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSg u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSg u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQg u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQg u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQg u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQg u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset y2tics
unset label

#First panel - corrs - log scale
set border 7
set tmargin at screen 0.7975
set bmargin at screen 0.705
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "{/Symbol r}_g(x,Q^2)" font 'Helvetica,24' at 0.013,0.75

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[-1:1]
set ytics(  -1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
          ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
            -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
          ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
             0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
          "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
             0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
          "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
             1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_gl_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset logscale x
unset border 
unset ytics
unset label

#First panel - corrs - lin scale
set border 13
set tmargin at screen 0.7975
set bmargin at screen 0.705
set lmargin at screen 0.25
set rmargin at screen 0.495

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
set y2range[-1:1]
set y2tics(""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
           ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
           ""-0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
           "" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0) nomirror

set key font 'Helvetica,24' at 1.75,0.77

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_gl_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset y2tics
unset label

#Second panel - nPDFs - log scale
set border 7
set tmargin at screen 0.695
set bmargin at screen 0.6025
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "R_u(x,Q^2)" font 'Helvetica,24' at 0.013,1.5

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[0.25:1.75]
set ytics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
              1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
              1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0) nomirror

plot infileEPPSu u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSu u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSu u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSu u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQu u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQu u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQu u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQu u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border
unset label

#Second panel - nPDFs - lin scale
set border 13
set tmargin at screen 0.695
set bmargin at screen 0.6025
set lmargin at screen 0.25
set rmargin at screen 0.495

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

set y2range[0.25:1.75]
set ytics (100 0)
set y2tics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
            "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
            "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
            "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0) nomirror

plot infileEPPSu u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSu u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSu u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSu u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQu u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQu u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQu u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQu u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset y2tics
unset label

#Second panel - corrs - log scale
set border 7
set tmargin at screen 0.5975
set bmargin at screen 0.505
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "{/Symbol r}_u(x,Q^2)" font 'Helvetica,24' at 0.013,0.75

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[-1:1]
set ytics(  -1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
          ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
            -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
          ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
             0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
          "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
             0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
          "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
             1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" lt 7 notitle,\
     infilecorr_up_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset logscale x
unset border 
unset label

#Second panel - corrs - lin scale
set border 13
set tmargin at screen 0.5975
set bmargin at screen 0.505
set lmargin at screen 0.25
set rmargin at screen 0.495

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
set y2range[-1:1]
set ytics (100 0)
set y2tics(""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
           ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
           ""-0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
           "" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_up_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset y2tics
unset label

#Third panel - nPDFs - log scale
set border 7
set tmargin at screen 0.495
set bmargin at screen 0.4025
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "R_d(x,Q^2)" font 'Helvetica,24' at 0.013,1.5

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[0.25:1.75]
set ytics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
              1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
              1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0) nomirror

plot infileEPPSd u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSd u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSd u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSd u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQd u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQd u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQd u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQd u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border
unset label

#Third panel - nPDFs - lin scale
set border 13
set tmargin at screen 0.495
set bmargin at screen 0.4025
set lmargin at screen 0.25
set rmargin at screen 0.495

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

set y2range[0.25:1.75]
set ytics (100 0)
set y2tics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
            "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
            "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
            "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0) nomirror

plot infileEPPSd u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSd u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSd u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSd u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQd u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQd u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQd u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQd u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset y2tics
unset label

#Third panel - corrs - log scale
set border 7
set tmargin at screen 0.3975
set bmargin at screen 0.305
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "{/Symbol r}_d(x,Q^2)" font 'Helvetica,24' at 0.013,0.75

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[-1:1]
set ytics(  -1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
          ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
            -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
          ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
             0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
          "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
             0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
          "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
             1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_do_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset logscale x
unset border 
unset label

#Third panel - corrs - lin scale
set border 13
set tmargin at screen 0.3975
set bmargin at screen 0.305
set lmargin at screen 0.25
set rmargin at screen 0.495

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
set y2range[-1:1]
set ytics (100 0)
set y2tics(""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
           ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
           ""-0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
           "" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_do_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset y2tics
unset label

#Fourth panel - nPDFs - log scale
set border 7
set tmargin at screen 0.295
set bmargin at screen 0.2025
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "R_s(x,Q^2)" font 'Helvetica,24' at 0.013,1.5

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[0.25:1.75]
set ytics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
              1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
              1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0) nomirror

plot infileEPPSs u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQs u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border
unset label

#Fourth panel - nPDFs - lin scale
set border 13
set tmargin at screen 0.295
set bmargin at screen 0.2025
set lmargin at screen 0.25
set rmargin at screen 0.495

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

set y2range[0.25:1.75]
set ytics (100 0)
set y2tics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
            "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
            "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
            "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0) nomirror

plot infileEPPSs u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSs u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQs u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQs u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset y2tics
unset label

#Fourth panel - corrs - log scale
set border 7
set tmargin at screen 0.1975
set bmargin at screen 0.105
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "{/Symbol r}_s(x,Q^2)" font 'Helvetica,24' at 0.013,0.75

set xrange[0.01:0.1]
set logscale x
set xtics(    0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[-1:1]
set ytics(  -1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
          ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
            -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
          ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
             0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
          "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
             0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
          "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
             1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_st_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset logscale x
unset border 
unset label

#Fourth panel - corrs - lin scale
set border 13
set tmargin at screen 0.1975
set bmargin at screen 0.105
set lmargin at screen 0.25
set rmargin at screen 0.495

set xrange[0.1:0.7]
set xtics(    0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
           "" 0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
              0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
           "" 0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
              0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
           "" 0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
           "" 0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
           "" 0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
              0.9 0)
set xlabel "x" font 'Helvetica,26' offset -7,0

set y2range[-1:1]
set ytics (100 0)
set y2tics(""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
           ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
           ""-0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
           "" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_st_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset y2tics
unset label
unset xlabel














#Second panel - nPDFs - log scale
set border 7
set tmargin at screen 0.695
set bmargin at screen 0.6025
set lmargin at screen 0.505
set rmargin at screen 0.65

set label "R_{~u\342\200\276} (x,Q^2)" font 'Helvetica,24' at 0.013,1.5

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[0.25:1.75]
set ytics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
           "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0) nomirror

plot infileEPPSub u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQub u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border
unset label

#Second panel - nPDFs - lin scale
set border 13
set tmargin at screen 0.695
set bmargin at screen 0.6025
set lmargin at screen 0.65
set rmargin at screen 0.9

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

set y2range[0.25:1.75]
set ytics (100 0)
set y2tics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
               0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
               1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
               1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0) nomirror

plot infileEPPSub u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSub u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQub u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQub u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset y2tics
unset label

#Second panel - corrs - log scale
set border 7
set tmargin at screen 0.5975
set bmargin at screen 0.505
set lmargin at screen 0.505
set rmargin at screen 0.65

set label "{/Symbol r}_{~u\342\200\276} (x,Q^2)" font 'Helvetica,24' at 0.013,0.75

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[-1:1]
set ytics( ""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
           ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
           ""-0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
           "" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_ub_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset logscale x
unset border 
unset ytics
unset label

#Second panel - corrs - lin scale
set border 13
set tmargin at screen 0.5975
set bmargin at screen 0.505
set lmargin at screen 0.65
set rmargin at screen 0.9

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
set y2range[-1:1]
set y2tics(  -1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
           ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
             -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
              0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
              1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_ub_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset y2tics
unset label

#Third panel - nPDFs - log scale
set border 7
set tmargin at screen 0.495
set bmargin at screen 0.4025
set lmargin at screen 0.505
set rmargin at screen 0.65

set label "R_{~d\342\200\276} (x,Q^2)" font 'Helvetica,24' at 0.013,1.5

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[0.25:1.75]
set ytics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
           "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0) nomirror

plot infileEPPSdb u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQdb u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdb u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdb u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdb u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border
unset ytics
unset label

#Third panel - nPDFs - lin scale
set border 13
set tmargin at screen 0.495
set bmargin at screen 0.4025
set lmargin at screen 0.65
set rmargin at screen 0.9

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

set y2range[0.25:1.75]
set y2tics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
               0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
               1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
               1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0) nomirror

plot infileEPPSdb u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSdb u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQdb u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdb u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdb u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQdb u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset y2tics
unset label

#Third panel - corrs - log scale
set border 7
set tmargin at screen 0.3975
set bmargin at screen 0.305
set lmargin at screen 0.505
set rmargin at screen 0.65

set label "{/Symbol r}_{~d\342\200\276} (x,Q^2)" font 'Helvetica,24' at 0.013,0.75

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[-1:1]
set ytics(""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
          ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
          ""-0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
          ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
          "" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
          "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
          "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
          "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
          "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_db_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset logscale x
unset border 
unset ytics
unset label

#Third panel - corrs - lin scale
set border 13
set tmargin at screen 0.3975
set bmargin at screen 0.305
set lmargin at screen 0.65
set rmargin at screen 0.9

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
set y2range[-1:1]
set y2tics(  -1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
           ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
             -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
              0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
              1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_db_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset y2tics
unset label

#Fourth panel - nPDFs - log scale
set border 7
set tmargin at screen 0.295
set bmargin at screen 0.2025
set lmargin at screen 0.505
set rmargin at screen 0.65

set label "R_{~s\342\200\276} (x,Q^2)" font 'Helvetica,24' at 0.013,1.5

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[0.25:1.75]
set ytics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
           "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
           "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
           "" 1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
           "" 1.75 0) nomirror

plot infileEPPSsb u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQsb u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQsb u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQsb u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQsb u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset logscale x
unset border
unset ytics
unset label

#Fourth panel - nPDFs - lin scale
set border 13
set tmargin at screen 0.295
set bmargin at screen 0.2025
set lmargin at screen 0.65
set rmargin at screen 0.9

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

set y2range[0.25:1.75]
set y2tics ("" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
               0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
            "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
               1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
            "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
               1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
            "" 1.75 0) nomirror

plot infileEPPSsb u 2:($3/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infileEPPSsb u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 5 lt 1 lc rgb "blue" notitle,\
     infilenCTEQsb u 2:($3/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQsb u 2:(($3+$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQsb u 2:(($3-$4)/$5) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infilenCTEQsb u 2:(($3+$4)/$5):(($3-$4)/$5) w filledcu fs transparent\
     pattern 6 lt 1 lc rgb "#006400" notitle

unset y2tics
unset label

#Fourth panel - corrs - log scale
set border 7
set tmargin at screen 0.1975
set bmargin at screen 0.105
set lmargin at screen 0.505
set rmargin at screen 0.65

set label "{/Symbol r}_{~s\342\200\276} (x,Q^2)" font 'Helvetica,24' at 0.013,0.75

set xrange[0.01:0.1]
set logscale x
set xtics(    0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)
set yrange[-1:1]
set ytics(""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
          ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
          ""-0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
          ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
          "" 0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
          "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
          "" 0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
          "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
          "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_sb_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset logscale x
unset border 
unset ytics
unset label

#Fourth panel - corrs - lin scale
set border 13
set tmargin at screen 0.1975
set bmargin at screen 0.105
set lmargin at screen 0.65
set rmargin at screen 0.9

set xrange[0.1:0.7]
set xtics(    0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
           "" 0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
              0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
           "" 0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
              0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
           "" 0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
              0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
           "" 0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
              0.9 0)
set xlabel "x" font 'Helvetica,26' offset -7,0

set y2range[-1:1]
set y2tics(  -1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
           ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
             -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
              0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
              1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_sb_1 u 2:4 w p pt 5 ps 1.5 lc rgb "gray" notitle

unset y2tics
unset label