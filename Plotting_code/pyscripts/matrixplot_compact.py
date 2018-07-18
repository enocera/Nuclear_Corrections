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
exp      = ["CHORUS", "NTV", "DYE605"]
expset   = [["NU", "NB"], ["NUDMN", "NBDMN"], [""]]
npt      = [607, 45, 119]

nexp     = 3
nset     = [2, 2, 1]

sigmaexp = np.zeros((2*npt[0]+2*npt[1]+npt[2],2*npt[0]+2*npt[1]+npt[2]))
sigmatot = np.zeros((2*npt[0]+2*npt[1]+npt[2],2*npt[0]+2*npt[1]+npt[2]))
sigmanuc = np.zeros((2*npt[0]+2*npt[1]+npt[2],2*npt[0]+2*npt[1]+npt[2]))

# Load experimental covariance matrix
sigmadf  = pd.read_table("../../Covariance/validphys/TOT/baseline/output/tables/experiments_covmat.csv", dtype={'user_id': float})
sigmaexp = sigmadf.iloc[3:,3:].values.astype(np.float)

# Load experiment + theory covariance matrix
expthdf  = pd.read_table("../../Covariance/validphys/TOT/corr/output/tables/experiments_covmat.csv", dtype={'user_id': float})
sigmatot = expthdf.iloc[3:,3:].values.astype(np.float)

impactthresh       = 10
covthresh          = 1
impactlim          = 10000
covlim             = 1000

sigmanuc = sigmatot - sigmaexp
    
diag_minus_half_exp   = (np.diagonal(sigmaexp))**(-0.5)
corrmat_exp           =  diag_minus_half_exp*sigmaexp*diag_minus_half_exp[:,np.newaxis]

diag_minus_half_nuc   = (np.diagonal(sigmanuc))**(-0.5)
corrmat_nuc           =  diag_minus_half_nuc*sigmanuc*diag_minus_half_nuc[:,np.newaxis]

diag_minus_half_tot   = (np.diagonal(sigmatot))**(-0.5)
corrmat_tot           =  diag_minus_half_tot*sigmatot*diag_minus_half_tot[:,np.newaxis]

for iexp in range(0,nexp):
    for iset in range(0,nset[iexp]):
        dict["exp_dat_{0}{1}".format(exp[iexp],expset[iexp][iset])] = np.loadtxt(
            "../../Data/commondata/DATA_{0}{1}nucl.dat".format(exp[iexp],expset[iexp][iset]), 
            delimiter   = "\t",
            skiprows    = 1,
            usecols     = (5,)    
        )
        
expdat = np.concatenate((dict["exp_dat_{0}{1}".format(exp[0],expset[0][0])] , dict["exp_dat_{0}{1}".format(exp[0],expset[0][1])] , 
                         dict["exp_dat_{0}{1}".format(exp[1],expset[1][0])] , dict["exp_dat_{0}{1}".format(exp[1],expset[1][1])] ,
                         dict["exp_dat_{0}{1}".format(exp[2],expset[2][0])]))
    
#####################################################################################

fig = plt.figure()
ax1 = fig.add_subplot(111)
mat = ax1.matshow(100*sigmanuc/np.outer(expdat,expdat),
                  cmap=cm.Spectral_r,
                  norm=mcolors.SymLogNorm(linthresh=covthresh,
                                          linscale=10, vmin=-covlim,
                                          vmax=covlim))
plt.xticks([])
plt.yticks([1,1215,1305],["CHORUS","NUTEV","DYE605"])
fig.colorbar(mat, label = "% of data")
plt.title("Nuclear covariance matrix")
plt.savefig("../figs/covplot_nuc")

#####################################################################################

fig = plt.figure()
ax1 = fig.add_subplot(111)
mat = ax1.matshow(100*sigmaexp/np.outer(expdat,expdat),
                  cmap=cm.Spectral_r,
                  norm=mcolors.SymLogNorm(linthresh=covthresh, 
                                          linscale=10, vmin=-covlim, 
                                          vmax=covlim))
plt.xticks([])
plt.yticks([1,1215,1305],["CHORUS","NUTEV","DYE605"])
fig.colorbar(mat, label = "% of data")
plt.title("Experimental covariance matrix")
plt.savefig("../figs/covplot_exp")

####################################################################################

#Plotting impact matrices
fig = plt.figure()
ax1 = fig.add_subplot(111)
matrix = (sigmatot)/sigmaexp
mat = ax1.matshow(matrix, 
                  cmap=cm.Spectral_r,
                  norm=mcolors.SymLogNorm(linthresh=impactthresh,
                                          linscale=10, vmin=-impactlim, 
                                          vmax=impactlim))
plt.xticks([])
plt.yticks([1,1215,1305],["CHORUS","NUTEV","DYE605"])
fig.colorbar(mat, label = r"$\frac{\sigma + s}{\sigma}$")
plt.title("Impact matrix")
plt.savefig("../figs/covplot_tot")

#####################################################################################
    
#Plotting correlation matrices
#-Exp
fig = plt.figure()
ax1 = fig.add_subplot(111)
mat = ax1.matshow(corrmat_exp, 
                  cmap=cm.Spectral_r,
                  vmin=-1, 
                  vmax=1)
plt.xticks([])
plt.yticks([1,1215,1305],["CHORUS","NUTEV","DYE605"])
fig.colorbar(mat)
plt.title("Experimental correlation matrix")
plt.savefig("../figs/corrplot_exp")


#-Nuc
fig = plt.figure()
ax1 = fig.add_subplot(111)
mat = ax1.matshow(corrmat_nuc, 
                  cmap=cm.Spectral_r,
                  vmin=-1, 
                  vmax=1)
plt.xticks([])
plt.yticks([1,1215,1305],["CHORUS","NUTEV","DYE605"])
fig.colorbar(mat)
plt.title("Nuclear correlation matrix")
plt.savefig("../figs/corrplot_nuc")

#-Tot
fig = plt.figure()
ax1 = fig.add_subplot(111)
mat = ax1.matshow(corrmat_tot, 
                  cmap=cm.Spectral_r,
                  vmin=-1, 
                  vmax=1)
plt.xticks([])
plt.yticks([1,1215,1305],["CHORUS","NUTEV","DYE605"])
fig.colorbar(mat)
plt.title("Experimental+Nuclear correlation matrix")
plt.savefig("../figs/corrplot_tot")

#####################################################################################
#####################################################################################
# ---- DIAGONAL ELEMENTS PLOTS --- #
#####################################################################################
#####################################################################################

fig = plt.figure(figsize=(20,10))
plt.plot(np.sqrt(np.diag(sigmaexp))/expdat,
         '.', 
         label="cov=\u03C3", 
         color="orange")
plt.plot(np.sqrt(np.diag(sigmanuc))/expdat,
         '.', 
         label="cov=s",
         color="darkorchid")
plt.plot(np.sqrt(np.diag(sigmatot))/expdat,
         '.', 
         label="cov=\u03C3+s", 
         color="teal")
plt.legend()
plt.xticks([1,1215,1305],["CHORUS","NUTEV","DYE605"], fontsize=20)
plt.yticks(fontsize=20)
plt.ylabel(r"$\frac{\sqrt{cov_{ii}}}{D_i}$", fontsize=35)
plt.ylim(0.01,1)
plt.xlim(0,1430)
plt.legend(loc=2, fontsize=20)
plt.tight_layout()
plt.savefig("../figs/plot1")
     
#####################################################################################

fig = plt.figure()
plt.plot((np.diag(la.inv(sigmaexp)))**(-0.5)/expdat,
         '.', 
         label="Experimental",
         color="orange")
plt.plot((np.diag(la.inv(sigmatot)))**(-0.5)/expdat,
         '.', 
        label="Experimental + Nuclear",
         color="mediumseagreen")
plt.title("Total")
plt.xlabel("Data point")
plt.ylabel(r"$\frac{1}{D_i}\frac{1}{\sqrt{cov^{-1}}_{ii}}$", fontsize=15)
plt.ylim(0,0.5)
plt.legend()
plt.tight_layout()
plt.savefig("../figs/plot2")

fig = plt.figure()
plt.plot(expdat,'.')
plt.title("Observable")
plt.xlabel("Data point")
plt.ylabel("Observable", fontsize=15)
plt.tight_layout()
plt.savefig("../figs/observable")

    
    
    
