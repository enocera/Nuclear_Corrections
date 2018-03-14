infile11="../../res/DSSZ_NLO_Fe56_MC/xPDFs_2.res"
infile12="../../res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_2.res"
infile13="../../res/nCTEQ15_56_26_MC/xPDFs_2.res"

infile21="../../res/DSSZ_NLO_Pb208_MC/xPDFs_2.res"
infile22="../../res/EPPS16nlo_CT14nlo_Pb208_MC/xPDFs_2.res"
infile23="../../res/nCTEQ15_208_82_MC/xPDFs_2.res"

outfile1="../figs/nPDFs_Fe_u.eps"
outfile2="../figs/nPDFs_Pb_u.eps"

set o outfile1
set term post enh col 20 linewidth 1  'Helvetica,20' size 10,7

set logscale x
set xrange[1e-3:1]
set format x "10^{%T}"
set xlabel "x" font 'Helvetica,28'

set key at 0.01,0.22 spacing 1.5 font 'Helvetica,22'
set label "xu^{p/Fe}(x,Q^2)" at 0.22,0.94 font 'Helvetica,22'
set label "Q^2=10 GeV^2" at 0.22,0.86 font 'Helvetica,20'

set yrange[0:1]
set ytics(  0.0 0, "" 0.02 1, "" 0.04 1, "" 0.06 1, "" 0.08 1,\
          ""0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
            0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
          ""0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
            0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
          ""0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
            0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
          ""0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
            0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
          ""0.9 0, "" 0.92 1, "" 0.94 1, "" 0.96 1, "" 0.98 1,\
            1.0 0)

plot infile11 u 2:3 w l lw 3 lt 3 lc rgb "red" notitle,\
     infile11 u 2:($3+$4) w l lw 3 lt 1 lc rgb "red" notitle,\
     infile11 u 2:($3-$4) w l lw 3 lt 1 lc rgb "red" notitle,\
     infile11 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 4\
     lt 1 lc rgb "red" t "DSSZ12",\
     infile12 u 2:3 w l lw 3 lt 3 lc rgb "blue" notitle,\
     infile12 u 2:($3+$4) w l lw 3 lt 1 lc rgb "blue" notitle,\
     infile12 u 2:($3-$4) w l lw 3 lt 1 lc rgb "blue" notitle,\
     infile12 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 5\
     lt 1 lc rgb "blue" t "EPPS16",\
     infile13 u 2:3 w l lw 3 lt 3 lc rgb "#006400" notitle,\
     infile13 u 2:($3+$4) w l lw 3 lt 1 lc rgb "#006400" notitle,\
     infile13 u 2:($3-$4) w l lw 3 lt 1 lc rgb "#006400" notitle,\
     infile13 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 6\
     lt 1 lc rgb "#006400" t "nCTEQ15"

unset label

set o outfile2
set term post enh col 20 linewidth 1  'Helvetica,20' size 10,7

set logscale x
set xrange[1e-3:1]
set yrange[0:1]

set label "xu^{p/Pb}(x,Q^2)" at 0.22,0.94 font 'Helvetica,22'
set label "Q^2=10 GeV^2" at 0.22,0.86 font 'Helvetica,20'

plot infile21 u 2:3 w l lw 3 lt 3 lc rgb "red" notitle,\
     infile21 u 2:($3+$4) w l lw 3 lt 1 lc rgb "red" notitle,\
     infile21 u 2:($3-$4) w l lw 3 lt 1 lc rgb "red" notitle,\
     infile21 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 4\
     lt 1 lc rgb "red" t "DSSZ12",\
     infile22 u 2:3 w l lw 3 lt 3 lc rgb "blue" notitle,\
     infile22 u 2:($3+$4) w l lw 3 lt 1 lc rgb "blue" notitle,\
     infile22 u 2:($3-$4) w l lw 3 lt 1 lc rgb "blue" notitle,\
     infile22 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 5\
     lt 1 lc rgb "blue" t "EPPS16",\
     infile23 u 2:3 w l lw 3 lt 3 lc rgb "#006400" notitle,\
     infile23 u 2:($3+$4) w l lw 3 lt 1 lc rgb "#006400" notitle,\
     infile23 u 2:($3-$4) w l lw 3 lt 1 lc rgb "#006400" notitle,\
     infile23 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 6\
     lt 1 lc rgb "#006400" t "nCTEQ15"


     




