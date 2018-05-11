#! /usr/bin/env python

import lhapdf
import numpy as np
import sys
from math import sqrt
import scipy.integrate as integrate

# Reading in PDF set and setting x and Q values
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

errordict     = {"f_3":None,
               "f_-1":None, 
               "f_-2":None, 
               "f_-3":None}

R = np.zeros(N)

# Loop over flavours and members to fill matrices with values
# (ignoring 0th replica) 
for k in range(0,N):
    for pid in [-1,-2,3,-3]:
        dict["f_{0}".format(pid)][k] = pdfs[k].xfxQ(pid, x, Q)
    R[k] = (dict["f_3"][k] + dict["f_-3"][k])/(dict["f_-2"][k] + dict["f_-1"][k])

R_cent = R[0]
R_err  = np.sqrt(np.mean(np.square(R[1:])) - np.square(np.mean(R[1:])))

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



delRs       = sqrt( (1/(ubar+dbar)**2)*(
                     (errordict["f_3"])**2 + (errordict["f_-3"])**2
              +  (1/(ubar+dbar)**2)*(
                  (errordict["f_-1"])**2 + (errordict["f_-2"])**2)))

# Calculating Ks and error
K = np.zeros(N)
for k in range (0,N):
    numerator    = integrate.quad(lambda t: (pdfs[k].xfxQ(3, t, Q) + p.xfxQ(-3, t, Q)), 0, 1)
    denominator  = integrate.quad(lambda t: (pdfs[k].xfxQ(-1, t, Q) + p.xfxQ(-2, t, Q)), 0, 1)

    K[k] = numerator[0]/denominator[0]

K_cent = K[0]
K_err = np.sqrt(np.mean(np.square(K[1:])) - np.square(np.mean(K[1:])))

print("***********************************************************")
print("PDF set {0}   ".format(pdfset))
print("x = {0}, Q = {1} GeV".format(x,round(Q,3)))
print("Rs:  " + str(round(Rs,4)) + " +/- " + str(round(delRs,4)))
print("R_cent:  " + str(round(R_cent, 4)) + " +/- " + str(round(R_err,4)))
#print("Ks:  " + str(round(Ks,4)))
print("K_cent:  " + str(round(K_cent, 4)) + " +/- " + str(round(K_err,4)))
print("***********************************************************")
