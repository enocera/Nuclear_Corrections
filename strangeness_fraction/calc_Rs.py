#! /usr/bin/env python

import lhapdf
import numpy as np
import sys
from math import sqrt
import scipy.integrate as integrate
from IPython import embed

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

##############################
# Calculating R_s and errors #
##############################

# Loop over flavours and members to fill matrices with values
# (ignoring 0th replica) 
for k in range(0,N):
    for pid in [-1,-2,3,-3]:
        dict["f_{0}".format(pid)][k] = pdfs[k].xfxQ(pid, x, Q)
    R[k] = (dict["f_3"][k] + dict["f_-3"][k])/(dict["f_-2"][k] + dict["f_-1"][k])

R_cent = R[0]

# 1 sigma errors (cutting off 1st entry as this is the 0th replica):
R_err         = np.sqrt(np.mean(np.square(R[1:])) - np.square(np.mean(R[1:])))

# 68%CL errors:
R_sorted_68   = np.sort(R[1:])[16:84]
R_err2        = 0.5*np.ptp(R_sorted_68)

# Computing mid-point of 68%CL interval
R_mid         = 0.5*(R_sorted_68[67]+R_sorted_68[0]) 

# Calculating MC PDF errors
for pid in [-1,-2,3,-3]:
    errordict["f_{0}".format(pid)] = np.sqrt(
        np.mean(np.square(dict["f_{0}".format(pid)]),axis=0)
        - np.square(np.mean(dict["f_{0}".format(pid)],axis=0)))

##########################
# Doing the same for K_s #
##########################

K = np.zeros(N)
for k in range (0,N):
    numerator    = integrate.quad(lambda t: (pdfs[k].xfxQ(3, t, Q) +
                                             pdfs[k].xfxQ(-3, t, Q)), 
                                10**(-5), 1, limit=1000)
    denominator  = integrate.quad(lambda t: (pdfs[k].xfxQ(-1, t, Q) + 
                                             pdfs[k].xfxQ(-2, t, Q)),
                                10**(-5), 1, limit=1000)

    K[k] = numerator[0]/denominator[0]

K_cent        = K[0]
K_err         = np.sqrt(np.mean(np.square(K[1:])) - np.square(np.mean(K[1:])))
K_sorted_68   = np.sort(K[1:])[16:84]
K_err2        = 0.5*np.ptp(K_sorted_68)

K_mid         = 0.5*(K_sorted_68[67]+K_sorted_68[0])
#embed()

####################
# Printing results #
####################

print("***********************************************************")
print("PDF set {0}   ".format(pdfset))
print("x = {0}, Q = {1} GeV".format(x,round(Q,3)))
print("R_s:  " + str(round(R_cent, 4)) + " +/- " + 
       str(round(R_err,4)) + "   (1 sigma)")
print("R_s:  " + str(round(R_mid,4)) + " +/- " +
       str(round(R_err2,4)) + "    (68%CL)")
print("K_s:  " + str(round(K_cent, 4)) + " +/- " + 
       str(round(K_err,4)) + "   (1 sigma)")
print("K_s:  " + str(round(K_mid,4)) + " +/- " +
       str(round(K_err2,4)) + "    (68%CL)")
print("***********************************************************")
