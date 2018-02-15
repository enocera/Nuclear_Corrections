#!/usr/bin/python

import numpy as np
import sys
import matplotlib.pyplot as plt

# Initialise data files to be read
exp      = ["CHORUS", "NTV"]
expset   = [["NU", "NB"], ["NUDMN", "NBDMN"]]
element  = ["lead", "iron"]

nexp      = 2
nset      = 2

for iexp in range(0,nexp):
    for iset in range(0,nset):

        # Read data

        Ecov = np.loadtxt("res/COV_{0}{1}.res".format(exp[iexp],expset[iexp][iset]))

        Rcov = np.loadtxt("res/pyres/pCOV_{0}{1}_{2}.res".format(exp[iexp], 
                                                      expset[iexp][iset], element[iexp]))

        # Plot covariance matrices

## Setting limits on plotting scale for % plot
#if nuclearpdf == "iron":

#    plotlims = [[1,3],[10,50]]

#elif nuclearpdf == "lead":

#    plotlims = [[1,3],[10,50]]

        fig=plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(Rcov)
        fig.colorbar(mat, label = "Absolute value")
        plt.title("{0} {1} Rosalyn".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("res/comparison/covplot_{0}{1}_Rosalyn".format(exp[iexp], expset[iexp][iset]))

        fig=plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(Ecov)
        fig.colorbar(mat, label = "Absolute value")
        plt.title("{0} {1} Emanuele".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("res/comparison/covplot_{0}{1}_Emanuele".format(exp[iexp], expset[iexp][iset]))

     
