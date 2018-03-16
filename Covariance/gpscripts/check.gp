infile1="../res/CK_NTVNBDMN_EPPS16nlo_CT14nlo_Fe56_MC.res"
infile2="../res/CK_NTVNBDMN_DSSZ_NLO_Fe56_MC.res"
infile3="../res/CK_NTVNBDMN_nCTEQ15_56_26_MC.res"

outfile="../figs/CK_NTVNBDMN.eps"

set yrange[-0.5:3.5]
set xrange[0:46]

set xlabel "N_{bin}" font 'Helvetica,28'
set ylabel "O^{p/Fe,(k)}/{/Symbol=\341} O^p{/Symbol=\361}" font 'Helvetica,28'\
offset 2,0

set o outfile
set term post enh col 20 linewidth 1 'Helvetica,20' size 20,10

set key at 46,3.4 font 'Helvetica,28' spacing 1.5
set label "NuTev (antineutrinos)" at 1,3.3 font 'Helvetica,24' 

plot infile2 u ($2-0.2):1 w p lt 7 ps 0.9 lc rgb "blue" t "DSSZ12",\
     infile1 u 2:1 w p lt 7 ps 0.9 lc rgb "red" t "EPPS16",\
     infile3 u ($2+0.2):1 w p lt 7 ps 0.9 lc rgb "#006400" t "nCTEQ15",\
     1 w l lw 3 lt 7 lc rgb "black" notitle

unset label

infile1="../res/CK_NTVNUDMN_EPPS16nlo_CT14nlo_Fe56_MC.res"
infile2="../res/CK_NTVNUDMN_DSSZ_NLO_Fe56_MC.res"
infile3="../res/CK_NTVNUDMN_nCTEQ15_56_26_MC.res"

outfile="../figs/CK_NTVNUDMN.eps"

set yrange[-0.5:3.5]
set xrange[0:46]

set xlabel "N_{bin}" font 'Helvetica,28'
set ylabel "O^{p/Fe,(k)}/{/Symbol=\341} O^p{/Symbol=\361}" font 'Helvetica,28'\
offset 2,0

set o outfile
set term post enh col 20 linewidth 1 'Helvetica,20' size 20,10

set key at 46,3.4 font 'Helvetica,28' spacing 1.5
set label "NuTev (neutrinos)" at 1,3.3 font 'Helvetica,24' 

plot infile2 u ($2-0.2):1 w p lt 7 ps 0.9 lc rgb "blue" t "DSSZ12",\
     infile1 u 2:1 w p lt 7 ps 0.9 lc rgb "red" t "EPPS16",\
     infile3 u ($2+0.2):1 w p lt 7 ps 0.9 lc rgb "#006400" t "nCTEQ15",\
     1 w l lw 3 lt 7 lc rgb "black" notitle

unset label

infile1="../res/CK_CHORUSNB_EPPS16nlo_CT14nlo_Pb208_MC.res"
infile2="../res/CK_CHORUSNB_DSSZ_NLO_Pb208_MC.res"
infile3="../res/CK_CHORUSNB_nCTEQ15_208_82_MC.res"

outfile="../figs/CK_CHORUSNB.eps"

set yrange[-0.5:3.5]
set xrange[0:620]

set xlabel "N_{bin}" font 'Helvetica,28'
set ylabel "O^{p/Fe,(k)}/{/Symbol=\341} O^p{/Symbol=\361}" font 'Helvetica,28'\
offset 2,0

set o outfile
set term post enh col 20 linewidth 1 'Helvetica,20' size 20,10

set key at 620,3.4 font 'Helvetica,28' spacing 1.5
set label "CHORUS (antineutrinos)" at 5,3.3 font 'Helvetica,24' 

plot infile2 u 2:1 w p lt 7 ps 0.9 lc rgb "blue" t "DSSZ12",\
     infile1 u ($2-0.2):1 w p lt 7 ps 0.9 lc rgb "red" t "EPPS16",\
     infile3 u ($2+0.2):1 w p lt 7 ps 0.9 lc rgb "#006400" t "nCTEQ15",\
     1 w l lw 3 lt 7 lc rgb "black" notitle

unset label

infile1="../res/CK_CHORUSNU_EPPS16nlo_CT14nlo_Pb208_MC.res"
infile2="../res/CK_CHORUSNU_DSSZ_NLO_Pb208_MC.res"
infile3="../res/CK_CHORUSNU_nCTEQ15_208_82_MC.res"

outfile="../figs/CK_CHORUSNU.eps"

set yrange[-0.5:3.5]
set xrange[0:620]

set xlabel "N_{bin}" font 'Helvetica,28'
set ylabel "O^{p/Fe,(k)}/{/Symbol=\341} O^p{/Symbol=\361}" font 'Helvetica,28'\
offset 2,0

set o outfile
set term post enh col 20 linewidth 1 'Helvetica,20' size 20,10

set key at 620,3.4 font 'Helvetica,28' spacing 1.5
set label "CHORUS (neutrinos)" at 5,3.3 font 'Helvetica,24' 

plot infile2 u 2:1 w p lt 7 ps 0.9 lc rgb "blue" t "DSSZ12",\
     infile1 u ($2-0.2):1 w p lt 7 ps 0.9 lc rgb "red" t "EPPS16",\
     infile3 u ($2+0.2):1 w p lt 7 ps 0.9 lc rgb "#006400" t "nCTEQ15",\
     1 w l lw 3 lt 7 lc rgb "black" notitle

unset label














