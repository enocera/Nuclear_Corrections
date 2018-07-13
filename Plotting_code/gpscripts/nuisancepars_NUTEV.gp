#NUTEV
infile1="../../Covariance/res/RATIOS_NTVNUDMN.res"
infile2="../../Covariance/res/shifts_ratios_NTVNUDMN.res"
infile3="../../Covariance/res/RATIOS_NTVNBDMN.res"
infile4="../../Covariance/res/shifts_ratios_NTVNBDMN.res"
outfile="../figs/ratio_NUTEV.eps"

set o outfile
set term post enh col 20 linewidth 1 'Helvetica,20' size 20,16
set multiplot layout 2,1

#First panel
set tmargin at screen 0.95
set bmargin at screen 0.51
set lmargin at screen 0.05
set rmargin at screen 0.95

set label "O@^{p/Fe,(k)}_i          /{/Symbol=\341}O@^p_i {/Symbol=\361}" font 'Helvetica,28' at 0.8,3.25
set label "NTVNUDMN" font 'Helvetica,28' at 39.5,3.25

set xrange[0.38:45.62]
set xtics("" 5.5 0, "" 10.5 0, "" 15.5 0, "" 20.5 0, "" 25.5 0, "" 30.5 0, "" 35.5 0, "" 40.5 0)

set label "0.021 < x < 0.326" at 0.7,2.75 font 'Helvetica,22'
set label "E_{/Symbol n}=90.18 GeV" at 0.7,-0.1 font 'Helvetica,22'
set label "y=0.334" at 0.7,-0.35 font 'Helvetica,22'
set label "y=0.573" at 5.7,-0.35 font 'Helvetica,22'
set label "y=0.790" at 10.7,-0.35 font 'Helvetica,22'
set label "E_{/Symbol n}=174.37 GeV" at 15.7,-0.1 font 'Helvetica,22'
set label "y=0.334" at 15.7,-0.35 font 'Helvetica,22'
set label "y=0.573" at 20.7,-0.35 font 'Helvetica,22'
set label "y=0.790" at 25.7,-0.35 font 'Helvetica,22'
set label "E_{/Symbol n}=244.72 GeV" at 30.7,-0.1 font 'Helvetica,22'
set label "y=0.334" at 30.7,-0.35 font 'Helvetica,22'
set label "y=0.573" at 35.7,-0.35 font 'Helvetica,22'
set label "y=0.790" at 40.7,-0.35 font 'Helvetica,22'

set yrange[-0.5:3.5]
set ytics(  -0.50 0, ""-0.45 1, ""-0.40 1, ""-0.35 1, ""-0.30 1,\
          ""-0.25 0, ""-0.20 1, ""-0.15 1, ""-0.10 1, ""-0.05 1,\
             0.00 0, "" 0.05 1, "" 0.10 1, "" 0.15 1, "" 0.20 1,\
          "" 0.25 0, "" 0.30 1, "" 0.35 1, "" 0.40 1, "" 0.45 1,\
             0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
          "" 0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
             1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
          "" 1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
             1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
          "" 1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
             2.00 0, "" 2.05 1, "" 2.10 1, "" 2.15 1, "" 2.20 1,\
          "" 2.25 0, "" 2.30 1, "" 2.35 1, "" 2.40 1, "" 2.45 1,\
             2.50 0, "" 2.55 1, "" 2.60 1, "" 2.65 1, "" 2.70 1,\
          "" 2.75 0, "" 2.80 1, "" 2.85 1, "" 2.90 1, "" 2.95 1,\
             3.00 0, "" 3.05 1, "" 3.10 1, "" 3.15 1, "" 3.20 1,\
          "" 3.25 0, "" 3.30 1, "" 3.35 1, "" 3.40 1, "" 3.45 1,\
             3.50 0)

set key at 45.5,3.0 font 'Helvetica,26' spacing 1.7

plot infile1 using ($1-0.2):602 w p pt 5 ps 0.9 lc rgb "red" t "DSSZ12",\
     for [i=602:901] infile1 using ($1-0.2):i w p pt 5 ps 0.9 lc rgb "red" notitle,\
     infile1 using 1:2 w p pt 7 ps 0.9 lc rgb "blue" t "EPPS16",\
     for [i=2:301] infile1 using 1:i w p pt 7 ps 0.9 lc rgb "blue" notitle,\
     infile1 using ($1+0.2):302 w p pt 63 ps 0.9 lc rgb "#006400" t "nCTEQ15",\
     for [i=302:601] infile1 using ($1+0.2):i w p pt 63 ps 0.9 lc rgb "#006400" notitle,\
     infile2 using ($1-0.5):(1/$2) w steps lt 1 lw 6 lc rgb "#FFD700"\
     t "{/Symbol=\341}O^{p/Fe}{/Symbol=\361}/{/Symbol=\341}O^p{/Symbol=\361}",\
     1 w l lw 5 lt 3 lc rgb "black" notitle

unset label

#Second panel
set tmargin at screen 0.49
set bmargin at screen 0.05
set lmargin at screen 0.05
set rmargin at screen 0.95

set label "NTVNBDMN" font 'Helvetica,28' at 39.5,3.25

plot for [i=602:901] infile3 using ($1-0.2):i w p lt 7 ps 0.9 lc rgb "red" notitle,\
     for [i=2:301] infile3 using 1:i w p lt 7 ps 0.9 lc rgb "blue" notitle,\
     for [i=302:601] infile3 using ($1+0.2):i w p lt 7 ps 0.9 lc rgb "#006400" notitle,\
     infile4 using ($1-0.5):(1/$2) w steps lt 1 lw 6 lc rgb "#FFD700" notitle,\
     1 w l lw 5 lt 3 lc rgb "black" notitle








