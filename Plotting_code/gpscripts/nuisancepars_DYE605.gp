#DYE605
infile1="../../Covariance/res/RATIOS_DYE605.res"
infile2="../../Covariance/res/shifts_ratios_DYE605.res"
outfile="../figs/ratio_DYE605.png"

set o outfile
#set term post enh col 20 linewidth 1 'Helvetica,20' size 20,8
#set term pdf colour enh font 'Helvetica,20' size 20,8
set term pngcairo font 'Helvetica,20' size 2000,800 enh

set tmargin at screen 0.95
set bmargin at screen 0.05
set lmargin at screen 0.05
set rmargin at screen 0.95

set label "O@^{Cu,(k)}_i          /{/Symbol=\341}O@^p_i {/Symbol=\361}" font 'Helvetica,28' at 1.2,3.25
set label "DYE605" font 'Helvetica,28' at 109,3.25

set xrange[0:120]
set xtics("" 17.5 0, "" 35.5 0, "" 53.5 0, "" 71.5 0, "" 89.5 0, "" 107.5 0)

set label "50 GeV^2 < M^2 < 286 GeV^2" at 1,1.25 font 'Helvetica,26'
set label "{/Symbol h}=-0.2" at 1,-0.3 font 'Helvetica,26'
set label "{/Symbol h}=-0.1" at 18,-0.3 font 'Helvetica,26'
set label "{/Symbol h}=0.0" at 36,-0.3 font 'Helvetica,26'
set label "{/Symbol h}=0.1" at 54,-0.3 font 'Helvetica,26'
set label "{/Symbol h}=0.2" at 72,-0.3 font 'Helvetica,26'
set label "{/Symbol h}=0.3" at 90,-0.3 font 'Helvetica,26'
set label "{/Symbol h}=0.4" at 108,-0.3 font 'Helvetica,26'

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
             3.50 0) font 'Helvetica,24'

set key at 120,3.0 font 'Helvetica,26' spacing 1.3

plot infile1 using ($1-0.2):2 w p pt 7 ps 0.9 lc rgb "blue" t "EPPS16",\
     for [i=2:301] infile1 using ($1-0.2):i w p pt 7 ps 0.9 lc rgb "blue" notitle,\
     infile1 using 1:302 w p pt 5 ps 0.9 lc rgb "#006400" t "nCTEQ15",\
     for [i=302:601] infile1 using 1:i w p pt 5 ps 0.9 lc rgb "#006400" notitle,\
     infile2 using ($1-0.5):(1/$2) w steps lt 3 lw 3 lc rgb "#FFD700"\
     t "{/Symbol=\341}O@^{Cu}_i   {/Symbol=\361} /{/Symbol=\341}O@^p_i {/Symbol=\361}",\
     1 w l lw 1 lt 3 lc rgb "black" notitle


