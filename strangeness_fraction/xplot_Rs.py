#! /usr/bin/env python

import lhapdf
import numpy as np
import sys
from math import sqrt
import scipy.integrate as integrate
import matplotlib.pyplot as plt
from IPython import embed


pdfsets = ["NNPDF31_nnlo_as_0118",
           "NNPDF31_nnlo_as_0118_NUTEV_DBG", 
           "NNPDF31_nnlo_GLOBAL_nucl_corr"]

# Dictionary to label fit names
namedict = {"NNPDF31_nnlo_as_0118_NUTEV_DBG":"NuTeV updated BRs",
            "NNPDF31_nnlo_GLOBAL_nucl_corr": "Nuclear corrections", 
            "NNPDF31_nnlo_as_0118":"NNPDF3.1 baseline"}
# Creating sub-dictionaries 
dict      = {}
errordict = {}
for pdfset in pdfsets:
    dict["dict_{0}".format(pdfset)]      = {}
    errordict["dict_{0}".format(pdfset)] = {}

Q_values = [sqrt(1.9), 91.2] # Q (GeV)

x_values = np.logspace(-4, 0, num = 100)
#x_values = np.linspace(10**(-4), 1, num = 100)

for Q in Q_values:
    for pdfset in pdfsets:

        # Reading in PDF sets
        p           = lhapdf.mkPDF(pdfset, 0)
        pdfs        = lhapdf.mkPDFs(pdfset)

        N           = len(pdfs)

        # Adding PDF arrays to dictionary
        dict["dict_{0}".format(pdfset)]   = {"f_3":np.zeros((N, len(x_values))),
                                             "f_-1":np.zeros((N, len(x_values))), 
                                             "f_-2":np.zeros((N, len(x_values))), 
                                             "f_-3":np.zeros((N, len(x_values))),
                                             "R":np.zeros(len(x_values))}

        errordict["dict_{0}".format(pdfset)]   = {"f_3":np.zeros(len(x_values)),
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
                     dict["dict_{0}".format(pdfset)]["f_{0}".format(pid)][k,x_index] = pdfs[k].xfxQ(pid, x, Q)
                R[k, x_index] = (dict["dict_{0}".format(pdfset)]["f_3"][k,x_index] +
                                 dict["dict_{0}".format(pdfset)]["f_-3"][k,x_index])/(
                                    dict["dict_{0}".format(pdfset)]["f_-2"][k,x_index] +
                                    dict["dict_{0}".format(pdfset)]["f_-1"][k,x_index])

            # 68%CL errors:
            R_sorted_68   = np.sort(R[1:,x_index])[16:84]
            errordict["dict_{0}".format(pdfset)]["Rerr"][x_index] = 0.5*np.ptp(R_sorted_68[:])

            # Computing mid-point of 68%CL interval
            dict["dict_{0}".format(pdfset)]["R"][x_index]  = 0.5*(R_sorted_68[67]
                                                                  + R_sorted_68[0])  

    ##########################################
    # Plotting Rs against x for each Q value #
    ##########################################
    fig = plt.figure()
    for pdfset in pdfsets:
        
        dict["ax_{0}".format(pdfset)] = fig.add_subplot(111)
        dict["ax_{0}".format(pdfset)].set_xscale('log')
        dict["ax_{0}".format(pdfset)].plot(x_values,
                                      dict["dict_{0}".format(pdfset)]["R"], 
                                           label=namedict[pdfset])
        dict["ax_{0}".format(pdfset)].fill_between(x_values,
                                    dict["dict_{0}".format(pdfset)]["R"]
                                + np.absolute(errordict["dict_{0}".format(pdfset)]["Rerr"]),
                                    dict["dict_{0}".format(pdfset)]["R"]
                                - np.absolute(errordict["dict_{0}".format(pdfset)]["Rerr"]),
                                                   alpha=0.5)
        plt.legend()
        plt.title("Q = {0} GeV".format(round(Q,2)))
        plt.xlabel("x")
        plt.ylabel("$R_s$")
        plt.ylim(0.1, 1.7)
        plt.xlim(1e-4,1)
    qstring = str(round(Q,2))
    qstring = qstring.replace(".","p")
    plt.savefig('./plots/q_{0}.png'.format(qstring))



