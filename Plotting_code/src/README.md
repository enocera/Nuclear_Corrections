The code in this folder is for making plots of the nuclear PDFs.

In order to produce data files and plots of the PDFs, run

./generatepdfs.sh

and ensure that the PDF set and Q values desired are included in this script. The LHAPDF files must be present in the LHAPDF folder. 

To produce ratio plots you must first do the above for the nuclear PDF and the proton PDF you are taking a ratio with. Then run

./plotratios.sh

once again making sure that the desired inputs are included. Currently you need to manually input the A and Z values (proton and mass number) for each PDF and I'm not sure how to get around this because I can't think of an automatic way to work out what each PDF set is of. 

Currently I have made up some PIDs to represent the bound proton PDFs (rather than full nuclear). This assumes that the input PDFs are all full nuclear PDFs. The transform is automatically applied to up and down type quarks when generating the pdfs. In summary:

PID	Parton
1	down
-1	antidown
2	up
-2	antiup
3	strange
-3	antistrange
21	gluon
11	transformed down (bound proton)
-11	transformed antidown (bound proton)
22	transformed up (bound proton)
+22	transformed antiup (bound proton)

These made up PIDs could be a source of confusion but I couldn't temporarily think of a better way to do it. I'm going to think how I could change it to be more clear. 

One final thing is that a lot of redunant plots are produced due to the way the inputs are looped over. This isn't really an issue but it does clog up the folders a bit and make it harder to extract what you want.

Output is like:

(pdfname)_(pid)_(Q)_plot.png 

for PDF plots, and 

ratio_(pdfa)_pdf(b)_(pid)_(Q).png 

for ratio plots, where this is a plot of a/b, and Q is in the form e.g. q2p0 = 2.0.

