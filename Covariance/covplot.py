#!/usr/bin/python

import numpy as np
import pandas as pd
import sys
import matplotlib.pyplot as plt
import numpy.linalg as la

# Initialise data files to be read
exp      = ["CHORUS", "NTV"]
expset   = [["NU", "NB"], ["NUDMN", "NBDMN"]]
element  = ["lead", "iron"]
npt      = [607, 45]

nexp     = 2
nset     = 2

sigma    = [[np.zeros((npt[0],npt[0])),np.zeros((npt[0],npt[0]))] ,
[np.zeros((npt[1],npt[1])),np.zeros((npt[1],npt[1]))]]

# Load experimental covariance matrix

sigmadf      = pd.read_table("output/tables/experiments_covmat.csv")
sigma_tot    = sigmadf.iloc[3:,3:].values.astype(np.float)

if len(sigma_tot) != len(npt)*sum(npt):
    print("Error: Experimental covariance matrix dimensions do not match dataset values")
    sys.exit()


# Splitting it up into entries corresponding to the four data sets
sigma[0][0] = sigma_tot[0:npt[0],0:npt[0]]
sigma[0][1] = sigma_tot[npt[0]:2*npt[0],npt[0]:2*npt[0]]
sigma[1][0] = sigma_tot[2*npt[0]:(2*npt[0]+npt[1]),2*npt[0]:(2*npt[0]+npt[1])]
sigma[1][1] = sigma_tot[(2*npt[0]+npt[1]):2*(npt[0]+npt[1]),(2*npt[0]+npt[1]):2*(npt[0]+npt[1])]

plotlims       = [[3,3],[None,None]]
corrplotlims   = [[3,3],[None,None]]

    
for iexp in range(0,nexp):
    for iset in range(0,nset):

        # Load theoretical covariance matrix (and extracting data from this)

        s      = np.loadtxt("res/pyres/pCOV_{0}{1}_{2}.res".format(exp[iexp],
                                                      expset[iexp][iset], element[iexp]))

        spct   = np.loadtxt("res/pyres/pCOV_%_{0}{1}_{2}.res".format(exp[iexp],
                                                      expset[iexp][iset], element[iexp]))


        diag_minus_half = (np.diagonal(s))**(-0.5)
        corrmat_th      = np.nan_to_num( diag_minus_half*s*diag_minus_half[:,np.newaxis])
        
        # Calculate theory central value
        
        norms  = 100*s/spct

        data   = np.nan_to_num(np.sqrt(np.diag(norms))) 
        
        #  matrix plots

        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(abs(spct), vmin=0, vmax=plotlims[iexp][iset])
        fig.colorbar(mat, label = "% of central theory")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("plots/covplot_%_{0}{1}_Rosalyn".format(exp[iexp], expset[iexp][iset]))

        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(abs(s))
        fig.colorbar(mat, label = "Absolute value")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("plots/covplot_{0}{1}_Rosalyn".format(exp[iexp], expset[iexp][iset]))

        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(abs((s+sigma[iexp][iset])/sigma[iexp][iset]),vmin=0, vmax=plotlims[iexp][iset])
        fig.colorbar(mat, label = r"$\frac{\sigma + s}{\sigma}$")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("plots/covplot_impact_{0}{1}_Rosalyn".format(exp[iexp], expset[iexp][iset]))

        
        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(abs(corrmat_th))
        fig.colorbar(mat, label = "Absolute value")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("plots/corrplot_{0}{1}_Rosalyn".format(exp[iexp], expset[iexp][iset]))

        # sqrt(diagonal)/data comparison

        fig = plt.figure()
        plt.plot(np.sqrt(np.diag(sigma[iexp][iset]))/data,'.', label="Experiment", color="orange")
        plt.plot(np.sqrt(np.diag(s))/data,'.', label="Theory", color="darkorchid")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.xlabel("Data point")
        plt.ylabel(r"$\frac{\sqrt{cov_{ii}}}{T_i}$", fontsize=15)
        plt.legend()
        plt.tight_layout()
        plt.savefig("plots/plot1_%_{0}{1}".format(exp[iexp], expset[iexp][iset]))

        fig = plt.figure()
        plt.plot(np.sqrt(np.diag(sigma[iexp][iset])),'.', label="Experiment", color="orange")
        plt.plot(np.sqrt(np.diag(s)),'.', label="Theory", color="darkorchid")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.xlabel("Data point")
        plt.ylabel(r"$\sqrt{cov_{ii}}$", fontsize=15)
        plt.legend()
        plt.tight_layout()
        plt.savefig("plots/plot3_%_{0}{1}".format(exp[iexp], expset[iexp][iset]))

        fig = plt.figure()
        plt.plot((np.diag(la.inv(sigma[iexp][iset])))**(-0.5)/data,'.', label="Experiment", color="orange")
        plt.plot((np.diag(la.inv(s + sigma[iexp][iset])))**(-0.5)/data,'.', label="Experiment + Theory", color="mediumseagreen")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.xlabel("Data point")
        plt.ylabel(r"$\frac{1}{T_i}\frac{1}{\sqrt{cov^{-1}}_{ii}}$", fontsize=15)
        plt.legend()
        plt.tight_layout()
        plt.savefig("plots/plot2_%_{0}{1}".format(exp[iexp], expset[iexp][iset]))

        fig = plt.figure()
        plt.plot((np.diag(la.inv(sigma[iexp][iset])))**(-0.5),'.', label="Experiment", color="orange")
        plt.plot((np.diag(la.inv(s + sigma[iexp][iset])))**(-0.5),'.', label="Experiment + Theory", color="mediumseagreen")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.xlabel("Data point")
        plt.ylabel(r"$\frac{1}{\sqrt{cov^{-1}}_{ii}}$", fontsize=15)
        plt.legend()
        plt.tight_layout()
        plt.savefig("plots/plot4_%_{0}{1}".format(exp[iexp], expset[iexp][iset]))

    
