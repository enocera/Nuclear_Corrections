#!/usr/bin/python

import numpy as np
import pandas as pd
import sys
import matplotlib.pyplot as plt
import numpy.linalg as la
from matplotlib import cm, colors as mcolors

# Create dictionary for dynamic variable assignment
dict = {}

# Initialise data files to be read
exp       = ["CHORUS", "NTV"]
expset    = [["NU", "NB"], ["NUDMN", "NBDMN"]]
element   = ["lead", "iron"]
npt       = [607, 45]

nexp      = 2
nset      = 2

sigmacomb = [np.zeros((2*npt[0],2*npt[0])) , np.zeros((2*npt[1],2*npt[1]))]
expthcomb = [np.zeros((2*npt[0],2*npt[0])) , np.zeros((2*npt[1],2*npt[1]))]
thcomb    = [np.zeros((2*npt[0],2*npt[0])) , np.zeros((2*npt[1],2*npt[1]))]

sigma     = [[np.zeros((npt[0],npt[0])),np.zeros((npt[0],npt[0]))] ,
[np.zeros((npt[1],npt[1])),np.zeros((npt[1],npt[1]))]]

expth     = [[np.zeros((npt[0],npt[0])),np.zeros((npt[0],npt[0]))] ,
[np.zeros((npt[1],npt[1])),np.zeros((npt[1],npt[1]))]]

th        = [[np.zeros((npt[0],npt[0])),np.zeros((npt[0],npt[0]))] ,
[np.zeros((npt[1],npt[1])),np.zeros((npt[1],npt[1]))]]

# Load experimental covariance matrix

sigmadf      = pd.read_table("covmats_from_validphys/covmat_NNPDF31_nlo_pch_as_0118_1000.csv")
sigma_tot    = sigmadf.iloc[3:,3:].values.astype(np.float)

if len(sigma_tot) != len(npt)*sum(npt):
    print("Error: Experimental covariance matrix dimensions do not match dataset values")
    sys.exit()


# Splitting it up into entries corresponding to the four data sets
sigma[0][0]  = sigma_tot[0:npt[0],0:npt[0]]
sigma[0][1]  = sigma_tot[npt[0]:2*npt[0],npt[0]:2*npt[0]]
sigma[1][0]  = sigma_tot[2*npt[0]:(2*npt[0]+npt[1]),2*npt[0]:(2*npt[0]+npt[1])]
sigma[1][1]  = sigma_tot[(2*npt[0]+npt[1]):2*(npt[0]+npt[1]),(2*npt[0]+npt[1]):2*(npt[0]+npt[1])]

sigmacomb[0] = sigma_tot[0:2*npt[0] , 0:2*npt[0]]
sigmacomb[1] = sigma_tot[2*npt[0]:2*(npt[0]+npt[1]) , 2*npt[0]:2*(npt[0]+npt[1])]

# Load experiment + theory covariance matrix

expthdf      = pd.read_table("covmats_from_validphys/covmat_NNPDF31_nnlo_GLOBAL_nucl_corr.csv")
expth_tot    = expthdf.iloc[3:,3:].values.astype(np.float)

# Splitting it up into entries corresponding to the four data sets
expth[0][0]  = expth_tot[0:npt[0],0:npt[0]]
expth[0][1]  = expth_tot[npt[0]:2*npt[0],npt[0]:2*npt[0]]
expth[1][0]  = expth_tot[2*npt[0]:(2*npt[0]+npt[1]),2*npt[0]:(2*npt[0]+npt[1])]
expth[1][1]  = expth_tot[(2*npt[0]+npt[1]):2*(npt[0]+npt[1]),(2*npt[0]+npt[1]):2*(npt[0]+npt[1])]

expthcomb[0] = expth_tot[0:2*npt[0] , 0:2*npt[0]]
expthcomb[1] = expth_tot[2*npt[0]:2*(npt[0]+npt[1]) , 2*npt[0]:2*(npt[0]+npt[1])]
    
impactthresh       = [10,10]
covthresh          = [1,0.1]
impactlim          = [10000,10000]
covlim             = [1000,1000]

for iexp in range(0,nexp):
    for iset in range(0,nset):
        # Loading experimental data    
        dict["exp_dat_{0}".format(expset[iset])] = np.loadtxt(
             "data/DATA_{0}{1}.dat".format(exp[iexp],expset[iexp][iset]), 
                         delimiter   = "\t",
                         skiprows    = 1,
                         usecols     = (5,)    
                         )

    expdat  = np.concatenate((dict["exp_dat_{0}".format(expset[0])] , dict["exp_dat_{0}".format(expset[1])]))


   
    thcomb[iexp] = expthcomb[iexp]-sigmacomb[iexp]

    # Saving combined cov matrices
    np.savetxt("covmats/res/covcomb_exp_{0}.res".format(exp[iexp]), sigmacomb[iexp])   
    np.savetxt("covmats/res/covcomb_th_{0}.res".format(exp[iexp]), thcomb[iexp])
    np.savetxt("covmats/res/covcomb_exp_th_{0}.res".format(exp[iexp]), sigmacomb[iexp] + thcomb[iexp])

    # Plotting combined cov matrices
    
    diag_minus_half_exp     = (np.diagonal(sigmacomb[iexp]))**(-0.5)
    corrmat_exp             =  diag_minus_half_exp*sigmacomb[iexp]*diag_minus_half_exp[:,np.newaxis]

    diag_minus_half_th    = (np.diagonal(thcomb[iexp]))**(-0.5)
    corrmat_th            =  diag_minus_half_th*thcomb[iexp]*diag_minus_half_th[:,np.newaxis]

#####################################################################################
        
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(100*thcomb[iexp]/np.outer(expdat,expdat),
                      cmap=cm.Spectral_r,
                      norm=mcolors.SymLogNorm(linthresh=covthresh[iexp],
                                              linscale=10, vmin=-covlim[iexp],
                                              vmax=covlim[iexp]))
    fig.colorbar(mat, label = "% of central theory")
    plt.title("{0}  theory covariance matrix".format(exp[iexp]))
    plt.savefig("covmats/plots/covplot_th_{0}".format(exp[iexp]))

#####################################################################################

    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(100*sigmacomb[iexp]/np.outer(expdat,expdat),
                      cmap=cm.Spectral_r,
                      norm=mcolors.SymLogNorm(linthresh=covthresh[iexp], 
                                              linscale=10, vmin=-covlim[iexp], 
                                              vmax=covlim[iexp]))
    fig.colorbar(mat, label = "% of central theory")
    plt.title("{0} experiment covariance matrix".format(exp[iexp]))
    plt.savefig("covmats/plots/covplot_exp_{0}".format(exp[iexp]))

#####################################################################################

    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    matrix = (expthcomb[iexp])/sigmacomb[iexp]
    mat = ax1.matshow(matrix, 
                      cmap=cm.Spectral_r,
                      norm=mcolors.SymLogNorm(linthresh=impactthresh[iexp],
                                              linscale=10, vmin=-impactlim[iexp], 
                                              vmax=impactlim[iexp]))
    fig.colorbar(mat, label = r"$\frac{\sigma + s}{\sigma}$")
    plt.title("{0} impact".format(exp[iexp]))
    plt.savefig("covmats/plots/covplot_impact_{0}".format(exp[iexp]))

#####################################################################################

    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(corrmat_exp, 
                      cmap=cm.Spectral_r,
                      vmin=-1, 
                      vmax=1)
    fig.colorbar(mat)
    plt.title("{0} experiment correlation matrix".format(exp[iexp]))
    plt.savefig("covmats/plots/corrplot_exp_{0}".format(exp[iexp]))

#####################################################################################
        
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(corrmat_th, 
                      cmap=cm.Spectral_r,
                      vmin=-1, 
                      vmax=1)
    fig.colorbar(mat)
    plt.title("{0} theory correlation matrix".format(exp[iexp]))
    plt.savefig("covmats/plots/corrplot_th_{0}".format(exp[iexp]))

#####################################################################################
#####################################################################################
                # ---- DIAGONAL ELEMENTS PLOTS --- #
#####################################################################################
#####################################################################################
                        
    fig = plt.figure()
    plt.plot(np.sqrt(np.diag(sigmacomb[iexp]))/expdat,
             '.', 
             label="Experiment", 
             color="orange")
    plt.plot(np.sqrt(np.diag(thcomb[iexp]))/expdat,
             '.', 
             label="Theory",
             color="darkorchid")
    plt.plot(np.sqrt(np.diag(expthcomb[iexp]))/expdat,
            '.', 
            label="Experiment + Theory", 
            color="teal")
    plt.title("{0}".format(exp[iexp]))
    plt.xlabel("Data point")
    plt.ylabel(r"$\frac{\sqrt{cov_{ii}}}{D_i}$", fontsize=15)
    plt.ylim(0,1)
    plt.legend()
    plt.tight_layout()
    plt.savefig("covmats/plots/plot1_{0}".format(exp[iexp]))

#####################################################################################


    fig = plt.figure()
    plt.plot((np.diag(la.inv(sigmacomb[iexp])))**(-0.5)/expdat,
             '.', 
             label="Experiment",
             color="orange")
    plt.plot((np.diag(la.inv(expthcomb[iexp])))**(-0.5)/expdat,
             '.', 
             label="Experiment + Theory",
             color="mediumseagreen")
    plt.title("{0}".format(exp[iexp]))
    plt.xlabel("Data point")
    plt.ylabel(r"$\frac{1}{D_i}\frac{1}{\sqrt{cov^{-1}}_{ii}}$", fontsize=15)
    plt.ylim(0,0.5)
    plt.legend()
    plt.tight_layout()
    plt.savefig("covmats/plots/plot2_{0}".format(exp[iexp]))

    fig = plt.figure()
    plt.plot(expdat,'.')
    plt.title("{0} Observable".format(exp[iexp]))
    plt.xlabel("Data point")
    plt.ylabel("Observable", fontsize=15)
    plt.tight_layout()
    plt.savefig("covmats/plots/observable_{0}".format(exp[iexp]))

