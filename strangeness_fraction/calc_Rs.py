#! /usr/bin/env python

import lhapdf
import numpy as np
import sys
from math import sqrt

# Reading in command line arguments
pdfset      = str(sys.argv[1])
x           = 0.023
Q           = sqrt(1.9)

# Reading in PDF sets
p           = lhapdf.mkPDF(pdfset, 0)
pdfs        = lhapdf.mkPDFs(pdfset)

N           = len(pdfs)

# Creating  dictionaries for dynamic variable assignment
dict        = {"f_3":np.zeros(N),
               "f_-1":np.zeros(N), 
               "f_-2":np.zeros(N), 
               "f_-3":np.zeros(N)}

errordict   = {"f_3":None,
               "f_-1":None, 
               "f_-2":None, 
               "f_-3":None}

# Loop over flavours and members to fill matrices with values
for pid in [-1,-2,3,-3]:
    for k in range(N):
        dict["f_{0}".format(pid)][k] = pdfs[k].xfxQ(pid, x, Q)

# Calculating MC PDF errors
for pid in [-1,-2,3,-3]:
    errordict["f_{0}".format(pid)] = np.sqrt(
        np.mean(np.square(dict["f_{0}".format(pid)]),axis=0)
        - np.square(np.mean(dict["f_{0}".format(pid)],axis=0)))

# Calculating Rs and error
s           = p.xfxQ(3,  x, Q)
sbar        = p.xfxQ(-3, x, Q)
ubar        = p.xfxQ(-2, x, Q)
dbar        = p.xfxQ(-1,  x, Q)

Rs          = (s + sbar)/(ubar + dbar)

delRs       = sqrt( (1/(ubar+dbar))*(
                     (errordict["f_3"])**2 + (errordict["f_-3"])**2
              +  (1/(ubar+dbar))*(
                     (errordict["f_-1"])**2 + (errordict["f_-2"])**2)))


print("***********************************************************")
print("PDF set {0}   ".format(pdfset))
print("x = {0}, Q = {1} GeV".format(x,round(Q,3)))
print("Rs:  ".format(pdfset) + str(round(Rs,4)) + " +/- " + str(round(delRs,4)))
print("***********************************************************")




