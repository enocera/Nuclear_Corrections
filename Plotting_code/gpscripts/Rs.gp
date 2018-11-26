#Rs ratios and related errors

infile="../../strangeness_fraction/res/Rs_1.65.res"
outfile="../figs/Rs_min.png"

set o outfile
set term pngcairo font 'Helvetica,20' size 1000,700 enh

set logscale x
set xrange[0.01:0.75]
set xlabel "x"

set yrange[0.2:1.6]
set ytics(  0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
          ""0.3 1, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
            0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
          ""0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
            0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
          ""0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
            0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
          ""0.9 0, "" 0.92 1, "" 0.94 1, "" 0.96 1, "" 0.98 1,\
            1.0 0, "" 1.02 1, "" 1.04 1, "" 1.06 1, "" 1.08 1,\
          ""1.1 0, "" 1.12 1, "" 1.14 1, "" 1.16 1, "" 1.18 1,\
            1.2 0, "" 1.22 1, "" 1.24 1, "" 1.26 1, "" 1.28 1,\
          ""1.3 0, "" 1.32 1, "" 1.34 1, "" 1.36 1, "" 1.38 1,\
            1.4 0, "" 1.42 1, "" 1.44 1, "" 1.46 1, "" 1.48 1,\
          ""1.5 0, "" 1.52 1, "" 1.54 1, "" 1.56 1, "" 1.58 1,\
            1.6 0)

set label "R_s(x,Q=1.38 GeV)" at 0.012,1.5
set key at 0.05,1.4

plot infile u 2:3 w l lt 3 lw 1 lc rgb "#006400" notitle,\
     infile u 2:($3+$4) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infile u 2:($3-$4) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infile u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 6\
     lt 1 lw 3 lc rgb "#006400" t "Baseline",\
     infile u 2:5 w l lt 3 lw 1 lc rgb "orange" notitle,\
     infile u 2:($5+$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
     infile u 2:($5-$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
     infile u 2:($5+$6):($5-$6) w filledcu fs transparent pattern 5\
     lt 1 lw 3 lc rgb "orange" t "No nuclear",\
     infile u 2:7 w l lt 3 lw 1 lc rgb "blue" notitle,\
     infile u 2:($7+$8) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infile u 2:($7-$8) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infile u 2:($7+$8):($7-$8) w filledcu fs transparent pattern 4\
     lt 1 lw 3 lc rgb "blue" t "Th.Unc. (Def 1)"


# infile u 2:5 w l lt 3 lw 1 lc rgb "orange" notitle,\
#     infile u 2:($5+$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
#     infile u 2:($5-$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
#     infile u 2:($5+$6):($5-$6) w filledcu fs transparent pattern 5\
#     lt 1 lw 3 lc rgb "orange" t "No nuclear",\

unset label

infile="../../strangeness_fraction/res/Rs_91.2.res"
outfile="../figs/Rs_max.png"

set o outfile
set term pngcairo font 'Helvetica,20' size 1000,700 enh

set logscale x
set xrange[0.01:0.75]
set xlabel "x"

set yrange[0.2:1.6]
set ytics(  0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
          ""0.3 1, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
            0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
          ""0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
            0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
          ""0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
            0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
          ""0.9 0, "" 0.92 1, "" 0.94 1, "" 0.96 1, "" 0.98 1,\
            1.0 0, "" 1.02 1, "" 1.04 1, "" 1.06 1, "" 1.08 1,\
          ""1.1 0, "" 1.12 1, "" 1.14 1, "" 1.16 1, "" 1.18 1,\
            1.2 0, "" 1.22 1, "" 1.24 1, "" 1.26 1, "" 1.28 1,\
          ""1.3 0, "" 1.32 1, "" 1.34 1, "" 1.36 1, "" 1.38 1,\
            1.4 0, "" 1.42 1, "" 1.44 1, "" 1.46 1, "" 1.48 1,\
          ""1.5 0, "" 1.52 1, "" 1.54 1, "" 1.56 1, "" 1.58 1,\
            1.6 0)

set label "R_s(x,Q=91.2 GeV)" at 0.012,1.5
set key at 0.05,1.4

plot infile u 2:3 w l lt 3 lw 1 lc rgb "#006400" notitle,\
     infile u 2:($3+$4) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infile u 2:($3-$4) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infile u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 6\
     lt 1 lw 3 lc rgb "#006400" t "Baseline",\
     infile u 2:5 w l lt 3 lw 1 lc rgb "orange" notitle,\
     infile u 2:($5+$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
     infile u 2:($5-$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
     infile u 2:($5+$6):($5-$6) w filledcu fs transparent pattern 5\
     lt 1 lw 3 lc rgb "orange" t "No nuclear",\
     infile u 2:7 w l lt 3 lw 1 lc rgb "blue" notitle,\
     infile u 2:($7+$8) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infile u 2:($7-$8) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infile u 2:($7+$8):($7-$8) w filledcu fs transparent pattern 4\
     lt 1 lw 3 lc rgb "blue" t "Th.Unc. (Def 1)"


# infile u 2:5 w l lt 3 lw 1 lc rgb "orange" notitle,\
#     infile u 2:($5+$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
#     infile u 2:($5-$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
#     infile u 2:($5+$6):($5-$6) w filledcu fs transparent pattern 5\
#     lt 1 lw 3 lc rgb "orange" t "No nuclear",\