#du ratio and related errors

infile="../../strangeness_fraction/res/sval_10.0.res"
outfile="../figs/sval_min.png"

set o outfile
set term pngcairo font 'Helvetica,20' size 1000,700 enh

set logscale x
set xrange[0.01:0.75]
set xlabel "x"

set yrange[-0.07:0.07]
set ytics(""-0.07 0, ""-0.068 1, ""-0.066 1, ""-0.064 1, ""-0.062 1,\
            -0.06 0, ""-0.058 1, ""-0.056 1, ""-0.054 1, ""-0.052 1,\
          ""-0.05 0, ""-0.048 1, ""-0.046 1, ""-0.044 1, ""-0.042 1,\
            -0.04 0, ""-0.038 1, ""-0.036 1, ""-0.034 1, ""-0.032 1,\
          ""-0.03 0, ""-0.028 1, ""-0.026 1, ""-0.024 1, ""-0.022 1,\
            -0.02 0, ""-0.018 1, ""-0.016 1, ""-0.014 1, ""-0.012 1,\
          ""-0.01 0, ""-0.008 1, ""-0.006 1, ""-0.004 1, ""-0.002 1,\
             0.00 0, "" 0.002 1, "" 0.004 1, "" 0.006 1, "" 0.008 1,\
          "" 0.01 0, "" 0.012 1, "" 0.014 1, "" 0.016 1, "" 0.018 1,\
             0.02 0, "" 0.022 1, "" 0.024 1, "" 0.026 1, "" 0.028 1,\
          "" 0.03 0, "" 0.032 1, "" 0.034 1, "" 0.036 1, "" 0.038 1,\
             0.04 0, "" 0.042 1, "" 0.044 1, "" 0.046 1, "" 0.048 1,\
          "" 0.05 0, "" 0.052 1, "" 0.054 1, "" 0.056 1, "" 0.058 1,\
             0.06 0, "" 0.062 1, "" 0.064 1, "" 0.066 1, "" 0.068 1,\
          "" 0.07 0)

set label "xs^-(x,Q=10 GeV)" at 0.15,0.06 font 'Helvetica,28'
set key top left

plot infile u 2:3 w l lt 3 lw 1 lc rgb "#006400" notitle,\
     infile u 2:($3+$4) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infile u 2:($3-$4) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infile u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 6\
     lt 1 lw 3 lc rgb "#006400" t "Baseline",\
     infile u 2:5 w l lt 3 lw 1 lc rgb "orange" notitle,\
     infile u 2:($5+$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
     infile u 2:($5-$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
     infile u 2:($5+$6):($5-$6) w filledcu fs transparent pattern 5\
     lt 1 lw 3 lc rgb "orange" t "NoNuc",\
     infile u 2:7 w l lt 3 lw 1 lc rgb "blue" notitle,\
     infile u 2:($7+$8) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infile u 2:($7-$8) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infile u 2:($7+$8):($7-$8) w filledcu fs transparent pattern 4\
     lt 1 lw 3 lc rgb "blue" t "NucUnc",\
     infile u 2:9 w l lt 3 lw 1 lc rgb "violet" notitle,\
     infile u 2:($9+$10) w l lt 1 lw 3 lc rgb "violet" notitle,\
     infile u 2:($9-$10) w l lt 1 lw 3 lc rgb "violet" notitle,\
     infile u 2:($9+$10):($9-$10) w filledcu fs transparent pattern 7\
     lt 1 lw 3 lc rgb "violet" t "NucCor"

unset label

infile="../../strangeness_fraction/res/sval_91.2.res"
outfile="../figs/sval_max.png"

set o outfile
set term pngcairo font 'Helvetica,20' size 1000,700 enh

set logscale x
set xrange[0.01:0.75]
set xlabel "x"

#set yrange[0.5:2.5]
#set ytics(  0.50 0, "" 0.55 1, "" 0.60 1, "" 0.65 1, "" 0.70 1,\
#          ""0.75 0, "" 0.80 1, "" 0.85 1, "" 0.90 1, "" 0.95 1,\
#            1.00 0, "" 1.05 1, "" 1.10 1, "" 1.15 1, "" 1.20 1,\
#          ""1.25 0, "" 1.30 1, "" 1.35 1, "" 1.40 1, "" 1.45 1,\
#            1.50 0, "" 1.55 1, "" 1.60 1, "" 1.65 1, "" 1.70 1,\
#          ""1.75 0, "" 1.80 1, "" 1.85 1, "" 1.90 1, "" 1.95 1,\
#            2.00 0, "" 2.05 1, "" 2.10 1, "" 2.15 1, "" 2.20 1,\
#          ""2.25 0, "" 2.30 1, "" 2.35 1, "" 2.40 1, "" 2.45 1,\
#            2.50 0)
#            

#set label "{~d\342\200\276} /{~u\342\200\276} (x,Q=91.2 GeV)" at 0.012,2.4
#set key at 0.035,2.3

plot infile u 2:3 w l lt 3 lw 1 lc rgb "#006400" notitle,\
     infile u 2:($3+$4) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infile u 2:($3-$4) w l lt 1 lw 3 lc rgb "#006400" notitle,\
     infile u 2:($3+$4):($3-$4) w filledcu fs transparent pattern 6\
     lt 1 lw 3 lc rgb "#006400" t "Baseline",\
     infile u 2:5 w l lt 3 lw 1 lc rgb "orange" notitle,\
     infile u 2:($5+$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
     infile u 2:($5-$6) w l lt 1 lw 3 lc rgb "orange" notitle,\
     infile u 2:($5+$6):($5-$6) w filledcu fs transparent pattern 5\
     lt 1 lw 3 lc rgb "orange" t "NoNuc",\
     infile u 2:7 w l lt 3 lw 1 lc rgb "blue" notitle,\
     infile u 2:($7+$8) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infile u 2:($7-$8) w l lt 1 lw 3 lc rgb "blue" notitle,\
     infile u 2:($7+$8):($7-$8) w filledcu fs transparent pattern 4\
     lt 1 lw 3 lc rgb "blue" t "NucUnc"

unset label

