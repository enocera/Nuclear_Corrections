#! /usr/bin/env python

import lhapdf
import numpy as np
import sys
from math import sqrt
import scipy.integrate as integrate
from IPython import embed


pdfsets = ["NNPDF31_nnlo_as_0118_NUTEV_DBG", 
           "NNPDF31_nnlo_GLOBAL_nucl_corr"]

# Dictionary to label fit names
namedict = {"NNPDF31_nnlo_as_0118_NUTEV_DBG":"NuTeV updated BRs",
            "NNPDF31_nnlo_GLOBAL_nucl_corr": "Nuclear corrections" }

# Creating sub-dictionaries 
dict      = {}
errordict = {}
for pdfset in pdfsets:
    dict["dict_{0}.format{pdfset}"]      = {}
    errordict["dict_{0}.format{pdfset}"] = {}

Q_values = [sqrt(1.9), 91.2] # Q (GeV)

x_values = np.linspace(10**-5, 1, num = 100)

for Q in Q_values:
    for pdfset in pdfsets:

        # Reading in PDF sets
        p           = lhapdf.mkPDF(pdfset, 0)
        pdfs        = lhapdf.mkPDFs(pdfset)

        N           = len(pdfs)

        # Adding PDF arrays to dictionary
        dict["dict_{0}.format{pdfset}"]   = {"f_3":np.zeros((N, len(x_values))),
                                             "f_-1":np.zeros((N, len(x_values))), 
                                             "f_-2":np.zeros((N, len(x_values))), 
                                             "f_-3":np.zeros((N, len(x_values))),
                                             "R":np.zeros(len(x_values))}

        errordict["dict_{0}.format{pdfset}"]   = {"f_3":np.zeros(len(x_values)),
                                             "f_-1":np.zeros(len(x_values)), 
                                             "f_-2":np.zeros(len(x_values)), 
                                             "f_-3":np.zeros(len(x_values)),
                                             "Rerr":np.zeros(len(x_values))}

        R = np.zeros((N, len(x_values)))

                     ##############################
                     # Calculating R_s and errors #
                     ##############################
        x_index = -1
        for x in x_values:
            x_index = x_index +1
            # Loop over flavours and members to fill matrices with values
            # (ignoring 0th replica) 
            for k in range(0,N):
                for pid in [-1,-2,3,-3]:
                     dict["dict_{0}.format{pdfset}"]["f_{0}".format(pid)][k] = pdfs[k].xfxQ(pid, x, Q)
                     R[k] = (dict["dict_{0}.format{pdfset}"]["f_3"][k] +
                               dict["dict_{0}.format{pdfset}"]["f_-3"][k])/(
                               dict["dict_{0}.format{pdfset}"]["f_-2"][k] +
                               dict["dict_{0}.format{pdfset}"]["f_-1"][k])

# 68%CL errors:
            R_sorted_68   = np.sort(R[1:])[16:84]
           # embed()
            errordict["dict_{0}.format{pdfset}"]["Rerr"][x_index] = 0.5*np.ptp(R_sorted_68[:,x_index])

# Computing mid-point of 68%CL interval
            dict["dict_{0}.format{pdfset}"]["R"][x_index]  = 0.5*(R_sorted_68[67,x_index]+R_sorted_68[0,x_index]) 




