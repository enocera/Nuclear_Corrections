infile11="../../res/DSSZ_NLO_Fe56_MC/xPDFs_0.res"
infile12="../../res/EPPS16nlo_CT14nlo_Fe56_MC/xPDFs_0.res"
infile13="../../res/nCTEQ15_56_26_MC/xPDFs_0.res"

infile21="../../res/DSSZ_NLO_Pb208_MC/xPDFs_0.res"
infile22="../../res/EPPS16nlo_CT14nlo_Pb208_MC/xPDFs_0.res"
infile23="../../res/nCTEQ15_208_82_MC/xPDFs_0.res"

outfile1="../figs/nPDFs_Fe_g.eps"
outfile2="../figs/nPDFs_Pb_g.eps"

set o outfile1
set term post enh col 20 linewidth 1  'Helvetica,20' size 10,7

set logscale x
set xrange[1e-3:1]
set format x "10^{%T}"
set xlabel "x" font 'Helvetica,28'

set key at 0.01,4.4 spacing 1.5 font 'Helvetica,22'
set label "xg^{p/Fe}(x,Q^2)" at 0.22,9.4 font 'Helvetica,22'
#set label "Q^2=10 GeV^2" at 0.22,17.2 font 'Helvetica,20'
unset key

set yrange[0:10]
set ytics(   0 0, "" 0.2 1, "" 0.4 1, "" 0.6 1, "" 0.8 1,\
          "" 1 0, "" 1.2 1, "" 1.4 1, "" 1.6 1, "" 1.8 1,\
             2 0, "" 2.2 1, "" 2.4 1, "" 2.6 1, "" 2.8 1,\
          "" 3 0, "" 3.2 1, "" 3.4 1, "" 3.6 1, "" 3.8 1,\
             4 0, "" 4.2 1, "" 4.4 1, "" 4.6 1, "" 4.8 1,\
          "" 5 0, "" 5.2 1, "" 5.4 1, "" 5.6 1, "" 5.8 1,\
             6 0, "" 6.2 1, "" 6.4 1, "" 6.6 1, "" 6.8 1,\
          "" 7 0, "" 7.2 1, "" 7.4 1, "" 7.6 1, "" 7.8 1,\
             8 0, "" 8.2 1, "" 8.4 1, "" 8.6 1, "" 8.8 1,\
          "" 9 0, "" 9.2 1, "" 9.4 1, "" 9.6 1, "" 9.8 1,\
            10 0, ""10.2 1, ""10.4 1, ""10.6 1, ""10.8 1,\
          ""11 0, ""11.2 1, ""11.4 1, ""11.6 1, ""11.8 1,\
            12 0, ""12.2 1, ""12.4 1, ""12.6 1, ""12.8 1,\
          ""13 0, ""13.2 1, ""13.4 1, ""13.6 1, ""13.8 1,\
            14 0, ""14.2 1, ""14.4 1, ""14.6 1, ""14.8 1,\
          ""15 0, ""15.2 1, ""15.4 1, ""15.6 1, ""15.8 1,\
            16 0, ""16.2 1, ""16.4 1, ""16.6 1, ""16.8 1,\
          ""17 0, ""17.2 1, ""17.4 1, ""17.6 1, ""17.8 1,\
            18 0, ""18.2 1, ""18.4 1, ""18.6 1, ""18.8 1,\
          ""19 0, ""19.2 1, ""19.4 1, ""19.6 1, ""19.8 1,\
            20 0)

plot infile11 u 2:3 w l lw 3 lt 3 lc rgb "blue" notitle,\
     infile11 u 2:($3+$4) w l lw 3 lt 1 lc rgb "blue" notitle,\
     infile11 u 2:($3-$4) w l lw 3 lt 1 lc rgb "blue" notitle,\
     infile11 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 4\
     lt 1 lc rgb "blue" t "DSSZ12",\
     infile12 u 2:3 w l lw 3 lt 3 lc rgb "red" notitle,\
     infile12 u 2:($3+$4) w l lw 3 lt 1 lc rgb "red" notitle,\
     infile12 u 2:($3-$4) w l lw 3 lt 1 lc rgb "red" notitle,\
     infile12 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 5\
     lt 1 lc rgb "red" t "EPPS16",\
     infile13 u 2:3 w l lw 3 lt 3 lc rgb "#006400" notitle,\
     infile13 u 2:($3+$4) w l lw 3 lt 1 lc rgb "#006400" notitle,\
     infile13 u 2:($3-$4) w l lw 3 lt 1 lc rgb "#006400" notitle,\
     infile13 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 6\
     lt 1 lc rgb "#006400" t "nCTEQ15"

unset label
unset key

set o outfile2
set term post enh col 20 linewidth 1  'Helvetica,20' size 10,7

set logscale x
set xrange[1e-3:1]
set yrange[0:10]
set ytics(   0 0, "" 0.2 1, "" 0.4 1, "" 0.6 1, "" 0.8 1,\
          "" 1 0, "" 1.2 1, "" 1.4 1, "" 1.6 1, "" 1.8 1,\
             2 0, "" 2.2 1, "" 2.4 1, "" 2.6 1, "" 2.8 1,\
          "" 3 0, "" 3.2 1, "" 3.4 1, "" 3.6 1, "" 3.8 1,\
             4 0, "" 4.2 1, "" 4.4 1, "" 4.6 1, "" 4.8 1,\
          "" 5 0, "" 5.2 1, "" 5.4 1, "" 5.6 1, "" 5.8 1,\
             6 0, "" 6.2 1, "" 6.4 1, "" 6.6 1, "" 6.8 1,\
          "" 7 0, "" 7.2 1, "" 7.4 1, "" 7.6 1, "" 7.8 1,\
             8 0, "" 8.2 1, "" 8.4 1, "" 8.6 1, "" 8.8 1,\
          "" 9 0, "" 9.2 1, "" 9.4 1, "" 9.6 1, "" 9.8 1,\
            10 0, ""10.2 1, ""10.4 1, ""10.6 1, ""10.8 1,\
          ""11 0, ""11.2 1, ""11.4 1, ""11.6 1, ""11.8 1,\
            12 0, ""12.2 1, ""12.4 1, ""12.6 1, ""12.8 1,\
          ""13 0, ""13.2 1, ""13.4 1, ""13.6 1, ""13.8 1,\
            14 0, ""14.2 1, ""14.4 1, ""14.6 1, ""14.8 1,\
          ""15 0, ""15.2 1, ""15.4 1, ""15.6 1, ""15.8 1,\
            16 0, ""16.2 1, ""16.4 1, ""16.6 1, ""16.8 1,\
          ""17 0, ""17.2 1, ""17.4 1, ""17.6 1, ""17.8 1,\
            18 0, ""18.2 1, ""18.4 1, ""18.6 1, ""18.8 1,\
          ""19 0, ""19.2 1, ""19.4 1, ""19.6 1, ""19.8 1,\
            20 0)

set label "xg^{p/Pb}(x,Q^2)" at 0.22,9.4 font 'Helvetica,22'
#set label "Q^2=10 GeV^2" at 0.22,17.2 font 'Helvetica,20'

plot infile21 u 2:3 w l lw 3 lt 3 lc rgb "blue" notitle,\
     infile21 u 2:($3+$4) w l lw 3 lt 1 lc rgb "blue" notitle,\
     infile21 u 2:($3-$4) w l lw 3 lt 1 lc rgb "blue" notitle,\
     infile21 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 4\
     lt 1 lc rgb "blue" t "DSSZ12",\
     infile22 u 2:3 w l lw 3 lt 3 lc rgb "red" notitle,\
     infile22 u 2:($3+$4) w l lw 3 lt 1 lc rgb "red" notitle,\
     infile22 u 2:($3-$4) w l lw 3 lt 1 lc rgb "red" notitle,\
     infile22 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 5\
     lt 1 lc rgb "red" t "EPPS16",\
     infile23 u 2:3 w l lw 3 lt 3 lc rgb "#006400" notitle,\
     infile23 u 2:($3+$4) w l lw 3 lt 1 lc rgb "#006400" notitle,\
     infile23 u 2:($3-$4) w l lw 3 lt 1 lc rgb "#006400" notitle,\
     infile23 u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 6\
     lt 1 lc rgb "#006400" t "nCTEQ15"


     




