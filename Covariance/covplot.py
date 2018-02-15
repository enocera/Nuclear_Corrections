#!/usr/bin/python

import numpy as np
import sys
import matplotlib.pyplot as plt

# Initialise data files to be read
exp      = ["CHORUS", "NTV"]
expset   = [["NU", "NB"], ["NUDMN", "NBDMN"]]
element  = ["lead", "iron"]
npt      = [600, 45]

sigma    = [[np.zeros((npt[0],npt[0])),np.zeros((npt[0],npt[0]))] ,
            [np.zeros((npt[1],npt[1])),np.zeros((npt[1],npt[1]))]]

nexp      = 2
nset      = 2

# Load experimental covariance matrix

with open("output/tables/experiments_covmat.csv") as f:
    ncols = len(f.readline().split(','))

sigma_tot = np.loadtxt(open("output/tables/experiments_covmat.csv"), delimiter="\t", skiprows=4, usecols=range(4,ncols))

sigma[0][0] = sigma_tot[3:605,4:606]
sigma[0][1] = sigma_tot[605:1213,606:1214]
sigma[1][0] = sigma_tot[1213:1259,1214:1260]
sigma[1][1] = sigma_tot[1259:1305,1260,1306]

print(str(len(sigma[0][0])) + str(len(sigma[0][1])) + str(len(sigma[1][0])) + str(len(sigma[1][1])))
for iexp in range(0,nexp):
    for iset in range(0,nset):

        # Load theoretical covariance matrix

        s      = np.loadtxt("res/pyres/pCOV_{0}{1}_{2}.res".format(exp[iexp], 
                                                      expset[iexp][iset], element[iexp]))

        spct   = np.loadtxt("res/pyres/pCOV_%_{0}{1}_{2}.res".format(exp[iexp], 
                                                      expset[iexp][iset], element[iexp]))
 
        # Calculate theory central value

        d = np.sqrt(100*s/spct) 
        
        # % matrix plot

        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(spct)
        fig.colorbar(mat, label = "% of central theory")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("plots/covplot_%_{0}{1}_Rosalyn".format(exp[iexp], expset[iexp][iset]))

        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(s)
        fig.colorbar(mat, label = "Absolute value")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.savefig("plots/covplot_{0}{1}_Rosalyn".format(exp[iexp], expset[iexp][iset]))

        # sqrt(diagonal)/data comparison

        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        plt.plot(np.sqrt(np.diag(spct/100)),'bo',linestyle="dashed")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.ylabel("sqrt(s_ii)/D_i")
        plt.savefig("plots/plot1_%_{0}{1}".format(exp[iexp], expset[iexp][iset]))


        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        plt.plot(np.sqrt(np.diag(s)),'g^',linestyle="dashed")
        plt.title("{0} {1}".format(exp[iexp], expset[iexp][iset]))
        plt.ylabel("sqrt(s_ii)")
        plt.savefig("plots/plot2_%_{0}{1}".format(exp[iexp], expset[iexp][iset]))

      #  plt.show()
        

     
