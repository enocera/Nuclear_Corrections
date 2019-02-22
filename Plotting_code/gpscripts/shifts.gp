#CHORUS
infileCHORUSNU="../../Shifts/res/CHORUSNU_shifts.dat"
infileCHORUSNB="../../Shifts/res/CHORUSNB_shifts.dat"

#NUTEV
infileNUTEVNU="../../Shifts/res/NTVNUDMN_shifts.dat"
infileNUTEVNB="../../Shifts/res/NTVNBDMN_shifts.dat"

#DYE605
infileDYE605="../../Shifts/res/DYE605_shifts.dat"

outfile="../figs/shift.png"

set o outfile
set term pngcairo font 'Helvetica,20' size 1500,1200 enh
set multiplot layout 2,3

#First panel - CHORUS
set tmargin at screen 0.945
set bmargin at screen 0.525
set lmargin at screen 0.055
set rmargin at screen 0.945

set xrange[-6:860]
set xtics("" -6 0, "" 427 0, "" 1272 0)
set yrange[-0.25:0.45]
set ytics(""-0.25 0, ""-0.24 1, ""-0.23 1, ""-0.22 1, ""-0.21 1,\
            -0.20 0, ""-0.19 1, ""-0.18 1, ""-0.17 1, ""-0.16 1,\
          ""-0.15 0, ""-0.14 1, ""-0.13 1, ""-0.12 1, ""-0.11 1,\
            -0.10 0, ""-0.09 1, ""-0.08 1, ""-0.07 1, ""-0.06 1,\
          ""-0.05 0, ""-0.04 1, ""-0.03 1, ""-0.02 1, ""-0.01 1,\
             0.00 0, "" 0.01 1, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
          "" 0.05 0, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1,\
             0.10 0, "" 0.11 1, "" 0.12 1, "" 0.13 1, "" 0.14 1,\
          "" 0.15 0, "" 0.16 1, "" 0.17 1, "" 0.18 1, "" 0.19 1,\
             0.20 0, "" 0.21 1, "" 0.22 1, "" 0.23 1, "" 0.24 1,\
          "" 0.25 0, "" 0.26 1, "" 0.27 1, "" 0.28 1, "" 0.29 1,\
             0.30 0, "" 0.31 1, "" 0.32 1, "" 0.33 1, "" 0.34 1,\
          "" 0.35 0, "" 0.36 1, "" 0.37 1, "" 0.38 1, "" 0.39 1,\
             0.40 0, "" 0.41 1, "" 0.42 1, "" 0.43 1, "" 0.44 1,\
          "" 0.45 0) scale 0.7

set y2tics(""-0.25 0, ""-0.24 1, ""-0.23 1, ""-0.22 1, ""-0.21 1,\
            -0.20 0, ""-0.19 1, ""-0.18 1, ""-0.17 1, ""-0.16 1,\
          ""-0.15 0, ""-0.14 1, ""-0.13 1, ""-0.12 1, ""-0.11 1,\
            -0.10 0, ""-0.09 1, ""-0.08 1, ""-0.07 1, ""-0.06 1,\
          ""-0.05 0, ""-0.04 1, ""-0.03 1, ""-0.02 1, ""-0.01 1,\
             0.00 0, "" 0.01 1, "" 0.02 1, "" 0.03 1, "" 0.04 1,\
          "" 0.05 0, "" 0.06 1, "" 0.07 1, "" 0.08 1, "" 0.09 1,\
             0.10 0, "" 0.11 1, "" 0.12 1, "" 0.13 1, "" 0.14 1,\
          "" 0.15 0, "" 0.16 1, "" 0.17 1, "" 0.18 1, "" 0.19 1,\
             0.20 0, "" 0.21 1, "" 0.22 1, "" 0.23 1, "" 0.24 1,\
          "" 0.25 0, "" 0.26 1, "" 0.27 1, "" 0.28 1, "" 0.29 1,\
             0.30 0, "" 0.31 1, "" 0.32 1, "" 0.33 1, "" 0.34 1,\
          "" 0.35 0, "" 0.36 1, "" 0.37 1, "" 0.38 1, "" 0.39 1,\
             0.40 0, "" 0.41 1, "" 0.42 1, "" 0.43 1, "" 0.44 1,\
          "" 0.45 0) scale 0.7

set label "CHORUS ({/Symbol n})" at 6,0.42
set label "CHORUS (~{/Symbol=\156}\342\200\276 )" at 430,0.42

plot 0 w l lw 1 lt 3 lc rgb "black" notitle,\
     infileCHORUSNU u 1:2 w p pt 6 ps 1.3 lw 2 lc rgb "blue" notitle,\
     infileCHORUSNU u 1:3 w p pt 4 ps 1.3 lw 2 lc rgb "violet" notitle,\
     infileCHORUSNU u 1:4 w p pt 2 ps 1.3 lw 2 lc rgb "#006400" notitle,\
     infileCHORUSNB u ($1+429):(-1*$2/30) w p pt 6 ps 1.3 lw 2 lc rgb "blue" t "NucUnc",\
     infileCHORUSNB u ($1+429):(-1*$3/25) w p pt 4 ps 1.3 lw 2 lc rgb "violet" t "NucCor",\
     infileCHORUSNB u ($1+429):4 w p pt 2 ps 1.3 lw 2 lc rgb "#006400" t "{/Symbol d}T_i@^N"


unset xrange
unset yrange
unset xtics
unset label
unset y2tics

#Second panel - NuTeV
set tmargin at screen 0.515
set bmargin at screen 0.095
set lmargin at screen 0.055
set rmargin at screen 0.495

set label "NuTeV ({/Symbol n})" at 5,3.2
set label "NuTeV (~{/Symbol=\156}\342\200\276 )" at 47,3.2

set xrange[-1:92]
set xtics("" -1 0, "" 44 0, "" 92 0)

set yrange[-3.5:3.5]
set ytics(""-3.5 0, ""-3.4 1, ""-3.3 1, ""-3.2 1, ""-3.1 1,\
            -3.0 0, ""-2.9 1, ""-2.8 1, ""-2.7 1, ""-2.6 1,\
          ""-2.5 0, ""-2.4 1, ""-2.3 1, ""-2.2 1, ""-2.1 1,\
            -2.0 0, ""-1.9 1, ""-1.8 1, ""-1.7 1, ""-1.6 1,\
          ""-1.5 0, ""-1.4 1, ""-1.3 1, ""-1.2 1, ""-1.1 1,\
            -1.0 0, ""-0.9 1, ""-0.8 1, ""-0.7 1, ""-0.6 1,\
          ""-0.5 0, ""-0.4 1, ""-0.3 1, ""-0.2 1, ""-0.1 1,\
             0.0 0, "" 0.1 1, "" 0.2 1, "" 0.3 1, "" 0.4 1,\
          "" 0.5 0, "" 0.6 1, "" 0.7 1, "" 0.8 1, "" 0.9 1,\
             1.0 0, "" 1.1 1, "" 1.2 1, "" 1.3 1, "" 1.4 1,\
          "" 1.5 0, "" 1.6 1, "" 1.7 1, "" 1.8 1, "" 1.9 1,\
             2.0 0, "" 2.1 1, "" 2.2 1, "" 2.3 1, "" 2.4 1,\
          "" 2.5 0, "" 2.6 1, "" 2.7 1, "" 2.8 1, "" 2.9 1,\
             3.0 0, "" 3.1 1, "" 3.2 1, "" 3.3 1, "" 3.4 1,\
          "" 3.5 0) scale 0.7

plot 0 w l lw 1 lt 3 lc rgb "black" notitle,\
     infileNUTEVNU u 1:2 w p pt 6 ps 1.3 lw 2 lc rgb "blue" notitle,\
     infileNUTEVNU u 1:3 w p pt 4 ps 1.3 lw 2 lc rgb "violet" notitle,\
     infileNUTEVNU u 1:4 w p pt 2 ps 1.3 lw 2 lc rgb "#006400" notitle,\
     infileNUTEVNB u ($1+47):2 w p pt 6 ps 1.3 lw 2 lc rgb "blue" notitle,\
     infileNUTEVNB u ($1+47):3 w p pt 4 ps 1.3 lw 2 lc rgb "violet" notitle,\
     infileNUTEVNB u ($1+47):4 w p pt 2 ps 1.3 lw 2 lc rgb "#006400" notitle

unset xrange
unset xtics
unset ytics
unset label

#Third panel - E605
set tmargin at screen 0.515
set bmargin at screen 0.095
set lmargin at screen 0.505
set rmargin at screen 0.945

set xrange[-2:122]
set xtics("" -2 0)
set yrange[-7:7]
set ytics( ""-7 0, ""-6.8 1, ""-6.6 1, ""-6.4 1, ""-6.2 1,\
           ""  -6 0, ""-5.8 1, ""-5.6 1, ""-5.4 1, ""-5.2 1,\
           ""-5 0, ""-4.8 1, ""-4.6 1, ""-4.4 1, ""-4.2 1,\
           ""-4 0, ""-3.8 1, ""-3.6 1, ""-3.4 1, ""-3.2 1,\
           ""-3 0, ""-2.8 1, ""-2.6 1, ""-2.4 1, ""-2.2 1,\
           ""-2 0, ""-1.8 1, ""-1.6 1, ""-1.4 1, ""-1.2 1,\
           ""-1 0, ""-0.8 1, ""-0.6 1, ""-0.4 1, ""-0.2 1,\
           "" 0 0, "" 0.2 1, "" 0.4 1, "" 0.6 1, "" 0.8 1,\
           "" 1 0, "" 1.2 1, "" 1.4 1, "" 1.6 1, "" 1.8 1,\
           "" 2 0, "" 2.2 1, "" 2.4 1, "" 2.6 1, "" 2.8 1,\
           "" 3 0, "" 3.2 1, "" 3.4 1, "" 3.6 1, "" 3.8 1,\
           "" 4 0, "" 4.2 1, "" 4.4 1, "" 4.6 1, "" 4.8 1,\
           "" 5 0, "" 5.2 1, "" 5.4 1, "" 5.6 1, "" 5.8 1,\
           "" 6 0, "" 6.2 1, "" 6.4 1, "" 6.6 1, "" 6.8 1,\
           "" 7 0) scale 0.7

set y2tics(""-7 0, ""-6.8 1, ""-6.6 1, ""-6.4 1, ""-6.2 1,\
             -6 0, ""-5.8 1, ""-5.6 1, ""-5.4 1, ""-5.2 1,\
           ""-5 0, ""-4.8 1, ""-4.6 1, ""-4.4 1, ""-4.2 1,\
             -4 0, ""-3.8 1, ""-3.6 1, ""-3.4 1, ""-3.2 1,\
           ""-3 0, ""-2.8 1, ""-2.6 1, ""-2.4 1, ""-2.2 1,\
             -2 0, ""-1.8 1, ""-1.6 1, ""-1.4 1, ""-1.2 1,\
           ""-1 0, ""-0.8 1, ""-0.6 1, ""-0.4 1, ""-0.2 1,\
              0 0, "" 0.2 1, "" 0.4 1, "" 0.6 1, "" 0.8 1,\
           "" 1 0, "" 1.2 1, "" 1.4 1, "" 1.6 1, "" 1.8 1,\
              2 0, "" 2.2 1, "" 2.4 1, "" 2.6 1, "" 2.8 1,\
           "" 3 0, "" 3.2 1, "" 3.4 1, "" 3.6 1, "" 3.8 1,\
              4 0, "" 4.2 1, "" 4.4 1, "" 4.6 1, "" 4.8 1,\
           "" 5 0, "" 5.2 1, "" 5.4 1, "" 5.6 1, "" 5.8 1,\
              6 0, "" 6.2 1, "" 6.4 1, "" 6.6 1, "" 6.8 1,\
           "" 7 0) scale 0.7


set label "E605" at 0,6.4
set key at 90,-2.2

plot 0 w l lw 1 lt 3 lc rgb "black" notitle,\
     infileDYE605 u 1:2 w p pt 6 ps 1.3 lw 2 lc rgb "blue" notitle,\
     infileDYE605 u 1:(-1*$3) w p pt 4 ps 1.3 lw 2 lc rgb "violet" notitle,\
     infileDYE605 u 1:4 w p pt 2 ps 1.3 lw 2 lc rgb "#006400" notitle	


