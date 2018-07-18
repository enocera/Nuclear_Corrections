#!/usr/bin/python

import numpy as np
import pandas as pd
import sys
import matplotlib.pyplot as plt
import numpy.linalg as la
from matplotlib import cm, colors as mcolors

plt.rcParams.update({'figure.max_open_warning': 0})

# Create dictionary for dynamic variable assignment
dict = {}

# Initialise data files to be read
exp       = ["CHORUS", "NTV", "DYE605"]
expset    = [["NU", "NB"], ["NUDMN", "NBDMN"], [""]]
npt       = [607, 45, 119]

nexp      = 3
nset      = [2, 2, 1]

sigmaexp = [np.zeros((2*npt[0],2*npt[0])) , np.zeros((2*npt[1],2*npt[1])) , np.zeros((npt[2],npt[2]))]
sigmatot = [np.zeros((2*npt[0],2*npt[0])) , np.zeros((2*npt[1],2*npt[1])) , np.zeros((npt[2],npt[2]))]
sigmanuc    = [np.zeros((2*npt[0],2*npt[0])) , np.zeros((2*npt[1],2*npt[1])) , np.zeros((npt[2],npt[2]))]

# Load experimental covariance matrix
sigmadf   = [pd.read_table("../../Covariance/validphys/CHORUS/baseline/output/tables/experiments_covmat.csv", dtype={'user_id': float}) ,
             pd.read_table("../../Covariance/validphys/NTV/baseline/output/tables/experiments_covmat.csv", dtype={'user_id': float}) ,
             pd.read_table("../../Covariance/validphys/DYE605/baseline/output/tables/experiments_covmat.csv", dtype={'user_id': float})]

sigmaexp = [sigmadf[0].iloc[3:,3:].values.astype(np.float) ,
             sigmadf[1].iloc[3:,3:].values.astype(np.float) ,
             sigmadf[2].iloc[3:,3:].values.astype(np.float)]

# Load experiment + theory covariance matrix
expthdf   = [pd.read_table("../../Covariance/validphys/CHORUS/corr/output/tables/experiments_covmat.csv", dtype={'user_id': float}) ,
             pd.read_table("../../Covariance/validphys/NTV/corr/output/tables/experiments_covmat.csv", dtype={'user_id': float}) ,
             pd.read_table("../../Covariance/validphys/DYE605/corr/output/tables/experiments_covmat.csv", dtype={'user_id': float})]

sigmatot = [expthdf[0].iloc[3:,3:].values.astype(np.float) ,
             expthdf[1].iloc[3:,3:].values.astype(np.float) ,
             expthdf[2].iloc[3:,3:].values.astype(np.float)]

impactthresh       = [10,10,10]
covthresh          = [1,1,1]
impactlim          = [10000,10000,10000]
covlim             = [1000,1000,1000]

for iexp in range(0,nexp):
    for iset in range(0,nset[iexp]):
        dict["exp_dat_{0}{1}".format(exp[iexp],expset[iexp][iset])] = np.loadtxt(
            "../../Data/commondata/DATA_{0}{1}nucl.dat".format(exp[iexp],expset[iexp][iset]), 
            delimiter   = "\t",
            skiprows    = 1,
            usecols     = (5,)    
        )

    if(iexp==0):
        expdat = np.concatenate((dict["exp_dat_{0}{1}".format(exp[iexp],expset[iexp][0])] , dict["exp_dat_{0}{1}".format(exp[iexp],expset[iexp][1])] ))
    elif iexp==1:
        expdat = np.concatenate((dict["exp_dat_{0}{1}".format(exp[iexp],expset[iexp][0])] , dict["exp_dat_{0}{1}".format(exp[iexp],expset[iexp][1])] ))
    else:
        expdat = dict["exp_dat_{0}{1}".format(exp[iexp],expset[iexp][0])]

    sigmanuc[iexp] = sigmatot[iexp] - sigmaexp[iexp]
    
    diag_minus_half_exp   = (np.diagonal(sigmaexp[iexp]))**(-0.5)
    corrmat_exp           =  diag_minus_half_exp*sigmaexp[iexp]*diag_minus_half_exp[:,np.newaxis]
    
    diag_minus_half_nuc   = (np.diagonal(sigmanuc[iexp]))**(-0.5)
    corrmat_nuc           =  diag_minus_half_nuc*sigmanuc[iexp]*diag_minus_half_nuc[:,np.newaxis]
    
    diag_minus_half_tot   = (np.diagonal(sigmatot[iexp]))**(-0.5)
    corrmat_tot           =  diag_minus_half_tot*sigmatot[iexp]*diag_minus_half_tot[:,np.newaxis]
    
    #####################################################################################
    
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(100*sigmanuc[iexp]/np.outer(expdat,expdat),
                      cmap=cm.Spectral_r,
                      norm=mcolors.SymLogNorm(linthresh=covthresh[iexp],
                                              linscale=10, vmin=-covlim[iexp],
                                              vmax=covlim[iexp]))
    fig.colorbar(mat, label = "% of central theory")
    plt.title("{0}  theory covariance matrix".format(exp[iexp]))
    plt.savefig("../figs/covplot_nuc_{0}".format(exp[iexp]))
    
    #####################################################################################
    
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(100*sigmaexp[iexp]/np.outer(expdat,expdat),
                      cmap=cm.Spectral_r,
                      norm=mcolors.SymLogNorm(linthresh=covthresh[iexp], 
                                              linscale=10, vmin=-covlim[iexp], 
                                              vmax=covlim[iexp]))
    fig.colorbar(mat, label = "% of central theory")
    plt.title("{0} experimental covariance matrix".format(exp[iexp]))
    plt.savefig("../figs/covplot_exp_{0}".format(exp[iexp]))
    
    #####################################################################################
    
    #Plotting impact matrices
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    matrix = (sigmatot[iexp])/sigmaexp[iexp]
    mat = ax1.matshow(matrix, 
                      cmap=cm.Spectral_r,
                      norm=mcolors.SymLogNorm(linthresh=impactthresh[iexp],
                                              linscale=10, vmin=-impactlim[iexp], 
                                              vmax=impactlim[iexp]))
    fig.colorbar(mat, label = r"$\frac{\sigma + s}{\sigma}$")
    plt.title("{0} impact".format(exp[iexp]))
    plt.savefig("../figs/covplot_tot_{0}".format(exp[iexp]))
    
    #####################################################################################
    
    #Plotting correlation matrices
    #-Exp
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(corrmat_exp, 
                      cmap=cm.Spectral_r,
                      vmin=-1, 
                      vmax=1)
    fig.colorbar(mat)
    plt.title("{0} experimental correlation matrix".format(exp[iexp]))
    plt.savefig("../figs/corrplot_exp_{0}".format(exp[iexp]))
    
    #-Nuc
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(corrmat_nuc, 
                      cmap=cm.Spectral_r,
                      vmin=-1, 
                      vmax=1)
    fig.colorbar(mat)
    plt.title("{0} nuclear correlation matrix".format(exp[iexp]))
    plt.savefig("../figs/corrplot_nuc_{0}".format(exp[iexp]))

    #-Tot
    fig = plt.figure()
    ax1 = fig.add_subplot(111)
    mat = ax1.matshow(corrmat_tot, 
                      cmap=cm.Spectral_r,
                      vmin=-1, 
                      vmax=1)
    fig.colorbar(mat)
    plt.title("{0} total correlation matrix".format(exp[iexp]))
    plt.savefig("../figs/corrplot_tot_{0}".format(exp[iexp]))
    
    #####################################################################################
    #####################################################################################
    # ---- DIAGONAL ELEMENTS PLOTS --- #
    #####################################################################################
    #####################################################################################
    
    fig = plt.figure()
    plt.plot(np.sqrt(np.diag(sigmaexp[iexp]))/expdat,
             '.', 
             label="Experiment", 
             color="orange")
    plt.plot(np.sqrt(np.diag(sigmanuc[iexp]))/expdat,
             '.', 
             label="Theory",
             color="darkorchid")
    plt.plot(np.sqrt(np.diag(sigmatot[iexp]))/expdat,
             '.', 
             label="Experiment + Theory", 
             color="teal")
    plt.title("{0}".format(exp[iexp]))
    plt.xlabel("Data point")
    plt.ylabel(r"$\frac{\sqrt{cov_{ii}}}{D_i}$", fontsize=15)
    plt.ylim(0,1)
    plt.legend()
    plt.tight_layout()
    plt.savefig("../figs/plot1_{0}".format(exp[iexp]))
     
    #####################################################################################
    
    fig = plt.figure()
    plt.plot((np.diag(la.inv(sigmaexp[iexp])))**(-0.5)/expdat,
             '.', 
             label="Experiment",
             color="orange")
    plt.plot((np.diag(la.inv(sigmatot[iexp])))**(-0.5)/expdat,
             '.', 
             label="Experiment + Theory",
             color="mediumseagreen")
    plt.title("{0}".format(exp[iexp]))
    plt.xlabel("Data point")
    plt.ylabel(r"$\frac{1}{D_i}\frac{1}{\sqrt{cov^{-1}}_{ii}}$", fontsize=15)
    plt.ylim(0,0.5)
    plt.legend()
    plt.tight_layout()
    plt.savefig("../figs/plot2_{0}".format(exp[iexp]))
     
    fig = plt.figure()
    plt.plot(expdat,'.')
    plt.title("{0} Observable".format(exp[iexp]))
    plt.xlabel("Data point")
    plt.ylabel("Observable", fontsize=15)
    plt.tight_layout()
    plt.savefig("../figs/observable_{0}".format(exp[iexp]))

    
    
    
