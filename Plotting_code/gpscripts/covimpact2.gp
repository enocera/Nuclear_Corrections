#CHORUS
infileCHORUSNU1="../../Covariance/res/covplot_CHORUSNUnucl.res"
infileCHORUSNB1="../../Covariance/res/covplot_CHORUSNBnucl.res"
infileCHORUSNU2="../../Covariance/res/covplot_CHORUSNUnuclshift.res"
infileCHORUSNB2="../../Covariance/res/covplot_CHORUSNBnuclshift.res"

#NUTEV
infileNTVNUDMN1="../../Covariance/res/covplot_NTVNUDMNnucl.res"
infileNTVNBDMN1="../../Covariance/res/covplot_NTVNBDMNnucl.res"
infileNTVNUDMN2="../../Covariance/res/covplot_NTVNUDMNnuclshift.res"
infileNTVNBDMN2="../../Covariance/res/covplot_NTVNBDMNnuclshift.res"

#DYE605
infileDYe6051="../../Covariance/res/covplot_DYE605nucl.res"
infileDYe6052="../../Covariance/res/covplot_DYE605nuclshift.res"

outfile2="../figs/covimpact2.jpg"

set o outfile2
set term pngcairo font 'Helvetica,20' size 1500,600 enh
set multiplot layout 1,3

#First panel - CHORUS
set tmargin at screen 0.945
set bmargin at screen 0.095
set lmargin at screen 0.055
set rmargin at screen 0.495

set xrange[-6:1272]
set xtics("" -6 0, "" 629 0, "" 1272 0)

set yrange [0:1.2]
set ytics(   0.0 0, "" 0.02 1, "" 0.04 1, "" 0.06 1, "" 0.08 1,\
          "" 0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
             0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
          "" 0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
             0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
          "" 0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
             0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
          "" 0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
             0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
          "" 0.9 0, "" 0.92 1, "" 0.94 1, "" 0.96 1, "" 0.98 1,\
             1.0 0, "" 1.02 1, "" 1.04 1, "" 1.06 1, "" 1.08 1,\
          "" 1.1 0, "" 1.12 1, "" 1.14 1, "" 1.16 1, "" 1.18 1,\
             1.2 0) scale 0.5

set label "{/Symbol=\326}cov_{ii}/y_i" at 15,1.06 font 'Helvetica,22'
set label "CHORUS ({/Symbol n})" at 15,1.16
set label "CHORUS (~{/Symbol=\156}\342\200\276 )" at 660,1.16
set key at 425,1 spacing 0.8

plot infileCHORUSNU2 u 1:($2!=0?$2:1/0) w p pt 4 lw 1.5 lc rgb "red" t "cov={/Symbol s}",\
     infileCHORUSNU2 u 1:($3!=0?$3:1/0) w p pt 12 lw 1.5 lc rgb "#006400" t "cov=s",\
     infileCHORUSNU2 u 1:($4!=0?$4:1/0) w p pt 6 lw 1.5 lc rgb "blue" t "cov={/Symbol s}+s",\
     infileCHORUSNB2 u ($1+651):($2!=0?$2:1/0) w p pt 4 lw 1.5 lc rgb "red" notitle,\
     infileCHORUSNB2 u ($1+651):($3!=0?$3:1/0) w p pt 12 lw 1.5 lc rgb "#006400" notitle,\
     infileCHORUSNB2 u ($1+651):($4!=0?$4:1/0) w p pt 6 lw 1.5 lc rgb "blue" notitle

unset xrange
unset yrange
unset xtics
unset ytics
unset label

#Second panel - NuTeV
set tmargin at screen 0.945
set bmargin at screen 0.095
set lmargin at screen 0.505
set rmargin at screen 0.745

set xrange[-1:92]
set xtics("" -1 0, "" 46 0, "" 92 0)

set yrange [0:1.2]
set ytics("" 0.0 0, "" 0.02 1, "" 0.04 1, "" 0.06 1, "" 0.08 1,\
          "" 0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
          "" 0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
          "" 0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
          "" 0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
          "" 0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
          "" 0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
          "" 0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
          "" 0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
          "" 0.9 0, "" 0.92 1, "" 0.94 1, "" 0.96 1, "" 0.98 1,\
          "" 1.0 0, "" 1.02 1, "" 1.04 1, "" 1.06 1, "" 1.08 1,\
          "" 1.1 0, "" 1.12 1, "" 1.14 1, "" 1.16 1, "" 1.18 1,\
          "" 1.2 0) scale 0.5

set label "NuTeV ({/Symbol n})" at 2,1.16
set label "NuTeV (~{/Symbol=\156}\342\200\276 )" at 49,1.16

plot infileNTVNUDMN2 u 1:($2!=0?$2:1/0) w p pt 4 lw 1.5 lc rgb "red" notitle,\
     infileNTVNUDMN2 u 1:($3!=0?$3:1/0) w p pt 12 lw 1.5 lc rgb "#006400" notitle,\
     infileNTVNUDMN2 u 1:($4!=0?$4:1/0) w p pt 6 lw 1.5 lc rgb "blue" notitle,\
     infileNTVNBDMN2 u ($1+47):($2!=0?$2:1/0) w p pt 4 lw 1.5 lc rgb "red" notitle,\
     infileNTVNBDMN2 u ($1+47):($3!=0?$3:1/0) w p pt 12 lw 1.5 lc rgb "#006400" notitle,\
     infileNTVNBDMN2 u ($1+47):($4!=0?$4:1/0) w p pt 6 lw 1.5 lc rgb "blue" notitle

unset xrange
unset yrange
unset xtics
unset ytics
unset label

#Third panel - E605
set tmargin at screen 0.945
set bmargin at screen 0.095
set lmargin at screen 0.755
set rmargin at screen 0.995

set xrange[-2:121]
set xtics("" -2 0)

set yrange [0:1.2]
set ytics("" 0.0 0, "" 0.02 1, "" 0.04 1, "" 0.06 1, "" 0.08 1,\
          "" 0.1 0, "" 0.12 1, "" 0.14 1, "" 0.16 1, "" 0.18 1,\
          "" 0.2 0, "" 0.22 1, "" 0.24 1, "" 0.26 1, "" 0.28 1,\
          "" 0.3 0, "" 0.32 1, "" 0.34 1, "" 0.36 1, "" 0.38 1,\
          "" 0.4 0, "" 0.42 1, "" 0.44 1, "" 0.46 1, "" 0.48 1,\
          "" 0.5 0, "" 0.52 1, "" 0.54 1, "" 0.56 1, "" 0.58 1,\
          "" 0.6 0, "" 0.62 1, "" 0.64 1, "" 0.66 1, "" 0.68 1,\
          "" 0.7 0, "" 0.72 1, "" 0.74 1, "" 0.76 1, "" 0.78 1,\
          "" 0.8 0, "" 0.82 1, "" 0.84 1, "" 0.86 1, "" 0.88 1,\
          "" 0.9 0, "" 0.92 1, "" 0.94 1, "" 0.96 1, "" 0.98 1,\
          "" 1.0 0, "" 1.02 1, "" 1.04 1, "" 1.06 1, "" 1.08 1,\
          "" 1.1 0, "" 1.12 1, "" 1.14 1, "" 1.16 1, "" 1.18 1,\
          "" 1.2 0) scale 0.5

set label "E605" at 1,1.16

plot infileDYe6052 u 1:($2!=0?$2:1/0) w p pt 4 lw 1.5 lc rgb "red" notitle,\
     infileDYe6052 u 1:($3!=0?$3:1/0) w p pt 12 lw 1.5 lc rgb "#006400" notitle,\
     infileDYe6052 u 1:($4!=0?$4:1/0) w p pt 6 lw 1.5 lc rgb "blue" notitle,\
