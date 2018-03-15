infile1="../res/SP_CHORUSNU.res"
infile2="../res/SP_NTVNUDMN.res"
oufile="../figs/SP_nu.eps"

set o oufile
set term post enh col 20 linewidth 1 'Helvetica,20' size 10,10
set border lw 1

set ticslevel 0.0
set logscale x
set xrange[0.01:1]
set xtics( 1e-2 0, "" 2e-2 1, "" 3e-2 1, "" 4e-2 1, "" 5e-2 1, "" 6e-2 1, "" 7e-2 1, "" 8e-2 1, "" 9e-2 1,\
           1e-1 0, "" 2e-1 1, "" 3e-1 1, "" 4e-1 1, "" 5e-1 1, "" 6e-1 1, "" 7e-1 1, "" 8e-1 1, "" 9e-1 1,\
           1e0  0) offset 0,-.5
set xlabel "x"
set format x "10^{%T}"

set logscale y
set yrange[1:1000]
set ytics("" 1e0 0, "" 2e0 1, "" 3e0 1, "" 4e0 1, "" 5e0 1, "" 6e0 1, "" 7e0 1, "" 8e0 1, "" 9e0 1,\
             1e1 0, "" 2e1 1, "" 3e1 1, "" 4e1 1, "" 5e1 1, "" 6e1 1, "" 7e1 1, "" 8e1 1, "" 9e1 1,\
             1e2 0, "" 2e2 1, "" 3e2 1, "" 4e2 1, "" 5e2 1, "" 6e2 1, "" 7e2 1, "" 8e2 1, "" 9e2 1,\
             1e3 0) offset 1,0
set ylabel "Q^2"
set format y "10^{%T}"

set zrange[0.65:1.35]
set ztics("" 0.65 0, "" 0.66 1, "" 0.67 1, "" 0.68 1, "" 0.69 1,\
             0.70 0, "" 0.71 1, "" 0.72 1, "" 0.73 1, "" 0.74 1,\
          "" 0.75 0, "" 0.76 1, "" 0.77 1, "" 0.78 1, "" 0.79 1,\
             0.80 0, "" 0.81 1, "" 0.82 1, "" 0.83 1, "" 0.84 1,\
          "" 0.85 0, "" 0.86 1, "" 0.87 1, "" 0.88 1, "" 0.89 1,\
             0.90 0, "" 0.91 1, "" 0.92 1, "" 0.93 1, "" 0.94 1,\
          "" 0.95 0, "" 0.96 1, "" 0.97 1, "" 0.98 1, "" 0.99 1,\
             1.00 0, "" 1.01 1, "" 1.02 1, "" 1.03 1, "" 1.04 1,\
          "" 1.05 0, "" 1.06 1, "" 1.07 1, "" 1.08 1, "" 1.09 1,\
             1.10 0, "" 1.11 1, "" 1.12 1, "" 1.13 1, "" 1.14 1,\
          "" 1.15 0, "" 1.16 1, "" 1.17 1, "" 1.18 1, "" 1.19 1,\
             1.20 0, "" 1.21 1, "" 1.22 1, "" 1.23 1, "" 1.24 1,\
          "" 1.25 0, "" 1.26 1, "" 1.27 1, "" 1.28 1, "" 1.29 1,\
             1.30 0, "" 1.31 1, "" 1.32 1, "" 1.33 1, "" 1.34 1,\
          "" 1.25 0)
set zlabel "{/Symbol=\341} O^{nuclear}{/Symbol=\361}/{/Symbol=\341} O^{proton}{/Symbol=\361}" rotate by 90 offset 1,0

set key at 1,700,1.3
set label "neutrino" at 0.5,800,1.1

set view 60,40,1,1

splot infile1 u 2:3:4 w p ps 1 pt 3 lc rgb "red" t "CHORUS",\
      infile2 u 2:3:4 w p ps 1 pt 4 lc rgb "blue" t "NuTeV"



infile3="../res/SP_CHORUSNB.res"
infile4="../res/SP_NTVNBDMN.res"
oufile="../figs/SP_nb.eps"

unset label

set o oufile
set term post enh col 20 linewidth 1 'Helvetica,20' size 10,10
set border lw 1

set ticslevel 0.0
set logscale x
set xrange[0.01:1]
set xtics( 1e-2 0, "" 2e-2 1, "" 3e-2 1, "" 4e-2 1, "" 5e-2 1, "" 6e-2 1, "" 7e-2 1, "" 8e-2 1, "" 9e-2 1,\
           1e-1 0, "" 2e-1 1, "" 3e-1 1, "" 4e-1 1, "" 5e-1 1, "" 6e-1 1, "" 7e-1 1, "" 8e-1 1, "" 9e-1 1,\
           1e0  0) offset 0,-.5
set xlabel "x"
set format x "10^{%T}"

set logscale y
set yrange[1:1000]
set ytics("" 1e0 0, "" 2e0 1, "" 3e0 1, "" 4e0 1, "" 5e0 1, "" 6e0 1, "" 7e0 1, "" 8e0 1, "" 9e0 1,\
             1e1 0, "" 2e1 1, "" 3e1 1, "" 4e1 1, "" 5e1 1, "" 6e1 1, "" 7e1 1, "" 8e1 1, "" 9e1 1,\
             1e2 0, "" 2e2 1, "" 3e2 1, "" 4e2 1, "" 5e2 1, "" 6e2 1, "" 7e2 1, "" 8e2 1, "" 9e2 1,\
             1e3 0) offset 1,0
set ylabel "Q^2"
set format y "10^{%T}"

set zrange[0.65:1.35]
set ztics("" 0.65 0, "" 0.66 1, "" 0.67 1, "" 0.68 1, "" 0.69 1,\
             0.70 0, "" 0.71 1, "" 0.72 1, "" 0.73 1, "" 0.74 1,\
          "" 0.75 0, "" 0.76 1, "" 0.77 1, "" 0.78 1, "" 0.79 1,\
             0.80 0, "" 0.81 1, "" 0.82 1, "" 0.83 1, "" 0.84 1,\
          "" 0.85 0, "" 0.86 1, "" 0.87 1, "" 0.88 1, "" 0.89 1,\
             0.90 0, "" 0.91 1, "" 0.92 1, "" 0.93 1, "" 0.94 1,\
          "" 0.95 0, "" 0.96 1, "" 0.97 1, "" 0.98 1, "" 0.99 1,\
             1.00 0, "" 1.01 1, "" 1.02 1, "" 1.03 1, "" 1.04 1,\
          "" 1.05 0, "" 1.06 1, "" 1.07 1, "" 1.08 1, "" 1.09 1,\
             1.10 0, "" 1.11 1, "" 1.12 1, "" 1.13 1, "" 1.14 1,\
          "" 1.15 0, "" 1.16 1, "" 1.17 1, "" 1.18 1, "" 1.19 1,\
             1.20 0, "" 1.21 1, "" 1.22 1, "" 1.23 1, "" 1.24 1,\
          "" 1.25 0, "" 1.26 1, "" 1.27 1, "" 1.28 1, "" 1.29 1,\
             1.30 0, "" 1.31 1, "" 1.32 1, "" 1.33 1, "" 1.34 1,\
          "" 1.25 0)
set zlabel "{/Symbol=\341} O^{nuclear}{/Symbol=\361}/{/Symbol=\341} O^{proton}{/Symbol=\361}" rotate by 90 offset 1,0

set key at 1,700,1.3
set label "antineutrino" at 0.3,700,1.1

set view 60,40,1,1

splot infile1 u 2:3:4 w p ps 1 pt 3 lc rgb "red" t "CHORUS",\
      infile2 u 2:3:4 w p ps 1 pt 4 lc rgb "blue" t "NuTeV"