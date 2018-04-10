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

sigma     = [[np.zeros((npt[0],npt[0])),np.zeros((npt[0],npt[0]))] ,
[np.zeros((npt[1],npt[1])),np.zeros((npt[1],npt[1]))]]

# Load experimental covariance matrix

sigmadf      = pd.read_table("output/tables/experiments_covmat.csv")
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

       
impactthresh       = [10,10]
covthresh          = [1,0.1]
impactlim          = [10000,10000]
covlim             = [1000,1000]

    
for iexp in range(0,nexp):
    for iset in range(0,nset):

        # Load theoretical covariance matrix (and extracting data from this)

        dict["s_{0}".format(expset[iset])]   = np.loadtxt("res/pyres/pCOV_{0}{1}_{2}.res".format(exp[iexp],
                                                      expset[iexp][iset], element[iexp]))


        s = dict["s_{0}".format(expset[iset])]
   
        # Loading experimental data    
        dict["exp_dat_{0}".format(expset[iset])] = np.loadtxt(
             "data/DATA_{0}{1}.dat".format(exp[iexp],expset[iexp][iset]), 
                         delimiter   = "\t",
                         skiprows    = 1,
                         usecols     = (5,)    
                         )

    # Combining datasets into full experiments for theory cov
    
    scomb                                                 = np.zeros((2*npt[iexp],2*npt[iexp]))
    scomb[0:npt[iexp] , 0:npt[iexp]]                      = dict["s_{0}".format(expset[0])]
    scomb[npt[iexp]:2*npt[iexp] , npt[iexp]:2*npt[iexp]]  = dict["s_{0}".format(expset[1])] 

    expdat  = np.concatenate((dict["exp_dat_{0}".format(expset[0])] , dict["exp_dat_{0}".format(expset[1])]))
    
    # Saving combined cov matrices
    np.savetxt("res/pyres/covcomb_exp_{0}.res".format(exp[iexp]), sigmacomb[iexp])   
    np.savetxt("res/pyres/covcomb_th_{0}.res".format(exp[iexp]), scomb)
    np.savetxt("res/pyres/covcomb_exp_th_{0}.res".format(exp[iexp]), sigmacomb[iexp] + scomb)

    # Plotting combined cov matrices
    
    diag_minus_half        = (np.diagonal(scomb))**(-0.5)
    corrmat_th             =  diag_minus_half*scomb*diag_minus_half[:,np.newaxis]

    diag_minus_half_exp    = (np.diagonal(sigmacomb[iexp]))**(-0.5)
    corrmat_exp            =  diag_minus_half_exp*sigmacomb[iexp]*diag_minus_half_exp[:,np.newaxis]

#####################################################################################
        
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(100*scomb/np.outer(expdat,expdat),
                      cmap=cm.Spectral_r,
                      norm=mcolors.SymLogNorm(linthresh=covthresh[iexp],
                                              linscale=10, vmin=-covlim[iexp],
                                              vmax=covlim[iexp]))
    fig.colorbar(mat, label = "% of central theory")
    plt.title("{0}  theory covariance matrix".format(exp[iexp]))
    plt.savefig("plots/covplot_th_{0}".format(exp[iexp]))

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
    plt.savefig("plots/covplot_exp_{0}".format(exp[iexp]))

#####################################################################################

    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    matrix = (scomb+sigmacomb[iexp])/sigmacomb[iexp]
    mat = ax1.matshow(matrix, 
                      cmap=cm.Spectral_r,
                      norm=mcolors.SymLogNorm(linthresh=impactthresh[iexp],
                                              linscale=10, vmin=-impactlim[iexp], 
                                              vmax=impactlim[iexp]))
    fig.colorbar(mat, label = r"$\frac{\sigma + s}{\sigma}$")
    plt.title("{0} impact".format(exp[iexp]))
    plt.savefig("plots/covplot_impact_{0}".format(exp[iexp]))

#####################################################################################

    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(corrmat_exp, 
                      cmap=cm.Spectral_r,
                      vmin=-1, 
                      vmax=1)
    fig.colorbar(mat)
    plt.title("{0} experiment correlation matrix".format(exp[iexp]))
    plt.savefig("plots/corrplot_exp_{0}".format(exp[iexp]))

#####################################################################################
        
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(corrmat_th, 
                      cmap=cm.Spectral_r,
                      vmin=-1, 
                      vmax=1)
    fig.colorbar(mat)
    plt.title("{0} theory correlation matrix".format(exp[iexp]))
    plt.savefig("plots/corrplot_th_{0}".format(exp[iexp]))

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
    plt.plot(np.sqrt(np.diag(scomb))/expdat,
             '.', 
             label="Theory",
             color="darkorchid")
    plt.plot(np.sqrt(np.diag(scomb + sigmacomb[iexp]))/expdat,
            '.', 
            label="Experiment + Theory", 
            color="teal")
    plt.title("{0}".format(exp[iexp]))
    plt.xlabel("Data point")
    plt.ylabel(r"$\frac{\sqrt{cov_{ii}}}{D_i}$", fontsize=15)
    plt.ylim(0,1)
    plt.legend()
    plt.tight_layout()
    plt.savefig("plots/plot1_{0}".format(exp[iexp]))

#####################################################################################


    fig = plt.figure()
    plt.plot((np.diag(la.inv(sigmacomb[iexp])))**(-0.5)/expdat,
             '.', 
             label="Experiment",
             color="orange")
    plt.plot((np.diag(la.inv(scomb + sigmacomb[iexp])))**(-0.5)/expdat,
             '.', 
             label="Experiment + Theory",
             color="mediumseagreen")
    plt.title("{0}".format(exp[iexp]))
    plt.xlabel("Data point")
    plt.ylabel(r"$\frac{1}{D_i}\frac{1}{\sqrt{cov^{-1}}_{ii}}$", fontsize=15)
    plt.ylim(0,0.5)
    plt.legend()
    plt.tight_layout()
    plt.savefig("plots/plot2_{0}".format(exp[iexp]))

    fig = plt.figure()
    plt.plot(expdat,'.')
    plt.title("{0} Observable".format(exp[iexp]))
    plt.xlabel("Data point")
    plt.ylabel("Observable", fontsize=15)
    plt.tight_layout()
    plt.savefig("plots/observable_{0}".format(exp[iexp]))

