#Correlation coefficients and nuclear PDFs

#CHORUS
infilecorr_ub_1="../../Covariance/res/corrs_CHORUSNU_-2.res"
infilecorr_ub_2="../../Covariance/res/corrs_CHORUSNB_-2.res"
infilecorr_db_1="../../Covariance/res/corrs_CHORUSNU_-1.res"
infilecorr_db_2="../../Covariance/res/corrs_CHORUSNB_-1.res"

#NUTEV
infilecorr_st_1="../../Covariance/res/corrs_NTVNUDMN_3.res"
infilecorr_st_2="../../Covariance/res/corrs_NTVNBDMN_3.res"
infilecorr_sb_1="../../Covariance/res/corrs_NTVNUDMN_-3.res"
infilecorr_sb_2="../../Covariance/res/corrs_NTVNBDMN_-3.res"

#E605
infilecorr_ub_1_DY="../../Covariance/res/corrs_DYE605_-2.res"
infilecorr_db_1_DY="../../Covariance/res/corrs_DYE605_-1.res"

outfile="../figs/correlations.png"

set o outfile
set term pngcairo font 'Helvetica,20' size 1500,750 enh
set multiplot layout 3,4

#First panel - CHORUS - log scale
set border 7
set tmargin at screen 0.945
set bmargin at screen 0.685
set lmargin at screen 0.1
set rmargin at screen 0.25

set label "{/Symbol r}_{~u\342\200\276} (x,Q^2)" font 'Helvetica,24' at 0.013,0.75

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)

set yrange[-1:1]
set ytics(""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
          ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
            -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
          ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
             0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
          "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
             0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
          "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
          "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_ub_1 u 2:4 w p pt 5 ps 1.5 lc rgb "#1E90FF" notitle,\
     infilecorr_ub_2 u 2:4 w p pt 2 ps 1.5 lc rgb "#FF6347" notitle

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

set key font 'Helvetica,20' at 0.74,0.0 spacing 1.1

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_ub_1 u 2:4 w p pt 5 ps 1.5 lc rgb "#1E90FF"\
     t "CHORUS ({/Symbol=\156})",\
     infilecorr_ub_2 u 2:4 w p pt 2 ps 1.5 lc rgb "#FF6347"\
     t "CHORUS (~{/Symbol=\156}\342\200\276 )"

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
     infilecorr_db_1 u 2:4 w p pt 5 ps 1.5 lc rgb "#1E90FF" notitle,\
     infilecorr_db_2 u 2:4 w p pt 2 ps 1.5 lc rgb "#FF6347" notitle

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
             -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
              0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_db_1 u 2:4 w p pt 5 ps 1.5 lc rgb "#1E90FF" t"neutrinos",\
     infilecorr_db_2 u 2:4 w p pt 2 ps 1.5 lc rgb "#FF6347" t "antineutrinos"

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

set label "{/Symbol r}_{s} (x,Q^2)" font 'Helvetica,24' at 0.013,0.75

set xrange[0.01:0.1]
set logscale x
set xtics( "" 0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)

set yrange[-1:1]
set ytics(""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
          ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
            -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
          ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
             0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
          "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
             0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
          "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
          "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_st_1 u 2:4 w p pt 5 ps 1.5 lc rgb "blue" notitle,\
     infilecorr_st_2 u 2:4 w p pt 2 ps 1.5 lc rgb "red" notitle

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

set key font 'Helvetica,20' at 0.73,0.0 spacing 1.1

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_st_1 u 2:4 w p pt 5 ps 1.5 lc rgb "blue"\
     t "NuTeV ({/Symbol=\156})",\
     infilecorr_st_2 u 2:4 w p pt 2 ps 1.5 lc rgb "red"\
     t "NuTeV (~{/Symbol=\156}\342\200\276 )"

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

set label "{/Symbol r}_{~s\342\200\276} (x,Q^2)" font 'Helvetica,24' at 0.013,0.75

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
     infilecorr_sb_1 u 2:4 w p pt 5 ps 1.5 lc rgb "blue" notitle,\
     infilecorr_sb_2 u 2:4 w p pt 2 ps 1.5 lc rgb "red" notitle

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
             -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
              0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_sb_1 u 2:4 w p pt 5 ps 1.5 lc rgb "blue" notitle,\
     infilecorr_sb_2 u 2:4 w p pt 2 ps 1.5 lc rgb "red" notitle

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

set label "{/Symbol r}_{~u\342\200\276} (x,s)" font 'Helvetica,24' at 0.013,0.75

set xrange[0.01:0.1]
set logscale x
set xtics(    0.01 0, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
           "" 0.05 1, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1)

set yrange[-1:1]
set ytics(""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
          ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
            -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
          ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
             0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
          "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
             0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
          "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
          "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_ub_1_DY u 2:4 w p pt 5 ps 1.5 lc rgb "#2E8B57" notitle

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

set key font 'Helvetica,20' at 0.73,0.0 spacing 1.1

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_ub_1_DY u 2:4 w p pt 5 ps 1.5 lc rgb "#2E8B57"\
     t "E605"

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

set label "{/Symbol r}_{~d\342\200\276} (x,Q^2)" font 'Helvetica,24' at 0.013,0.75

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
     infilecorr_db_1_DY u 2:4 w p pt 5 ps 1.5 lc rgb "#2E8B57" notitle

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

set y2range[-1:1]
set y2tics(""-1.00 0, ""-0.95 1, ""-0.90 1, ""-0.85 1, ""-0.80 1,\
           ""-0.75 0, ""-0.70 1, ""-0.65 1, ""-0.60 1, ""-0.55 1,\
             -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
           ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
              0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
           "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
              0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
           "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
           "" 1.00 0) nomirror

plot 0 w l lw 1 lc rgb "black" notitle,\
     infilecorr_db_1_DY u 2:4 w p pt 5 ps 1.5 lc rgb "#2E8B57" notitle

unset logscale x
unset border 
unset ytics
unset y2tics
unset label
unset xlabel