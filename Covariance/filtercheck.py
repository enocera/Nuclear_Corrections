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

# Load experimental covariance matrix from filter output

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


# Load experimental + theory  covariance matrix from Nuclear_Corrections
for iexp in range(1,1):
    for iset in range(0,nset):

        # Load theoretical covariance matrix (and extracting data from this)

        prior      = np.loadtxt('res/pyres/cov_exp_th_tot_{0}{1}.res'.format(exp[iexp],
                                                    expset[iexp][iset]))

        ratio      = sigma[iexp][iset]/prior
        
        for i in range(0,len(ratio)):
            for j in range(0,len(ratio)):
                if ratio[i][j] != 1:
                    print("WARNING: Initial and final covariance matrices not equal")
                    print("(i,j,element):  " + str(i) + "  " + str(j) + "  " + str(ratio[i][j]))


        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(ratio)
        fig.colorbar(mat, label = "Ratio")
        plt.show()

                                                
