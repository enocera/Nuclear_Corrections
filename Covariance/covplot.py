#!/usr/bin/python

import numpy as np
import pandas as pd
import sys
import matplotlib.pyplot as plt
import numpy.linalg as la
from matplotlib import cm, colors as mcolors

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

impactthresh       = [[10,10],[10,10]]
covthresh          = [[1,1],[1,1]]
impactlim          = [[10000,10000],[10000,10000]]
covlim             = [[1000,1000],[1000,1000]]



    
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
 #       uplim    = plotlims[iexp][iset]
 #       if isinstance(uplim,int) == True:
 #           lowlim = -uplim
 #       else:
 #           lowlim = None

        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(spct, cmap=cm.Spectral_r, norm=mcolors.SymLogNorm(linthresh=covthresh[iexp][iset], linscale=10, vmin=-covlim[iexp][iset], vmax=covlim[iexp][iset]))
        fig.colorbar(mat, label = "% of central theory")
        plt.title("{0} {1} theory covariance matrix".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("plots/covplot_pc_{0}{1}".format(exp[iexp], expset[iexp][iset]))

        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(100*sigma[iexp][iset]/np.sqrt(np.outer(data,data)), cmap=cm.Spectral_r, norm=mcolors.SymLogNorm(linthresh=covthresh[iexp][iset], linscale=10, vmin=-covlim[iexp][iset], vmax=covlim[iexp][iset]))
        fig.colorbar(mat, label = "% of central theory")
        plt.title("{0} {1} experiment covariance matrix".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("plots/covplot_exp_{0}{1}".format(exp[iexp], expset[iexp][iset]))

     #   fig = plt.figure()
     #   ax1 = fig.add_subplot(111)
     #   mat = ax1.matshow(s, cmap=cm.Spectral_r, norm=mcolors.SymLogNorm(linthresh=0.1, linscale=10, vmin=-s.max(), vmax=s.max()))
     #   fig.colorbar(mat, label = "Absolute value")
     #   plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
     #   plt.savefig("plots/covplot_{0}{1}_Rosalyn".format(exp[iexp], expset[iexp][iset]))

        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        matrix = (s+sigma[iexp][iset])/sigma[iexp][iset]
        mat = ax1.matshow(matrix, cmap=cm.Spectral_r, norm=mcolors.SymLogNorm(linthresh=impactthresh[iexp][iset], linscale=10, vmin=-impactlim[iexp][iset], vmax=impactlim[iexp][iset]))
        fig.colorbar(mat, label = r"$\frac{\sigma + s}{\sigma}$")
        plt.title("{0} {1} impact".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("plots/covplot_impact_{0}{1}_Rosalyn".format(exp[iexp], expset[iexp][iset]))

        
        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(corrmat_th, cmap=cm.Spectral_r, vmin=-1, vmax=1)
        fig.colorbar(mat)
        plt.title("{0} {1} theory correlation matrix".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("plots/corrplot_{0}{1}".format(exp[iexp], expset[iexp][iset]))

        # sqrt(diagonal)/data comparison

        fig = plt.figure()
        plt.plot(np.sqrt(np.diag(sigma[iexp][iset]))/data,'.', label="Experiment", color="orange")
        plt.plot(np.sqrt(np.diag(s))/data,'.', label="Theory", color="darkorchid")
        plt.plot(np.sqrt(np.diag(s+sigma[iexp][iset]))/data,'.', label="Experiment + Theory", color="teal")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.xlabel("Data point")
        plt.ylabel(r"$\frac{\sqrt{cov_{ii}}}{T_i}$", fontsize=15)
        plt.ylim(0,1)
        plt.legend()
        plt.tight_layout()
        plt.savefig("plots/plot1_{0}{1}".format(exp[iexp], expset[iexp][iset]))

      #  fig = plt.figure()
       # plt.plot(np.sqrt(np.diag(sigma[iexp][iset])),'.', label="Experiment", color="orange")
      #  plt.plot(np.sqrt(np.diag(s)),'.', label="Theory", color="darkorchid")
      #  plt.plot(np.sqrt(np.diag(s+sigma[iexp][iset])),'.', label="Experiment + Theory", color="teal")
      #  plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
      #  plt.xlabel("Data point")
      #  plt.ylabel(r"$\sqrt{cov_{ii}}$", fontsize=15)
      #  plt.legend()
      #  plt.tight_layout()
      #  plt.savefig("plots/plot3_{0}{1}".format(exp[iexp], expset[iexp][iset]))

        fig = plt.figure()
        plt.plot((np.diag(la.inv(sigma[iexp][iset])))**(-0.5)/data,'.', label="Experiment", color="orange")
        plt.plot((np.diag(la.inv(s + sigma[iexp][iset])))**(-0.5)/data,'.', label="Experiment + Theory", color="mediumseagreen")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.xlabel("Data point")
        plt.ylabel(r"$\frac{1}{T_i}\frac{1}{\sqrt{cov^{-1}}_{ii}}$", fontsize=15)
        plt.ylim(0,0.5)
        plt.legend()
        plt.tight_layout()
        plt.savefig("plots/plot2_{0}{1}".format(exp[iexp], expset[iexp][iset]))

     #   fig = plt.figure()
     #   plt.plot((np.diag(la.inv(sigma[iexp][iset])))**(-0.5),'.', label="Experiment", color="orange")
     #   plt.plot((np.diag(la.inv(s + sigma[iexp][iset])))**(-0.5),'.', label="Experiment + Theory", color="mediumseagreen")
     #   plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
     #   plt.xlabel("Data point")
     #   plt.ylabel(r"$\frac{1}{\sqrt{cov^{-1}}_{ii}}$", fontsize=15)
     #   plt.legend()
     #   plt.tight_layout()
     #   plt.savefig("plots/plot4_{0}{1}".format(exp[iexp], expset[iexp][iset]))

    
