#!/usr/bin/python

import numpy as np
import sys
import matplotlib.pyplot as plt

# Read in PDF set names
nuclearpdf  =  raw_input("***** Please choose iron or lead: ")
if nuclearpdf != "iron" and nuclearpdf != "lead":
    print("Error: Invalid choice of element")
    sys.exit()

protonpdf   =  "NNPDF31_nlo_pch_as_0118"
print("----------------------------------------------------")
print("Computing theory covariance matrix for " + nuclearpdf + " relative to proton PDF " + protonpdf)
print("----------------------------------------------------")

# Initialise data files to be read
exp      = ["CHORUS", "NTV"]
expset   = [["NU", "NB"], ["NUDMN", "NBDMN"]]

if nuclearpdf == "iron":

    nuclearpdfs = ["DSSZ_NLO_Fe56_MC_1000_compressed_250",
                   "EPPS16nlo_CT14nlo_Fe56_MC_1000_compressed_250",
                   "nCTEQ15FullNuc_56_26_MC_1000_compressed_250"]

elif nuclearpdf == "lead":

    nuclearpdfs = ["DSSZ_NLO_Pb208_MC_1000_compressed_250",
                   "EPPS16nlo_CT14nlo_Pb208_MC_1000_compressed_250",
                   "nCTEQ15FullNuc_208_82_MC_1000_compressed_250"]

pdfs     = [protonpdf] + nuclearpdfs

nexp      = 2
nset      = 2
npdf      = len(pdfs)
maxpoint  = 1000
maxrep    = 251

nrep      = np.zeros(npdf,dtype=int)
npt       = np.zeros((nexp,nset),dtype=int)
thobs     = np.zeros((npdf,maxrep,maxpoint,nexp,nset))

F_p       = np.zeros((maxpoint,nexp,nset))


 # Read data
for iexp in range(0,nexp):
    for iset in range(0,nset):
        for ipdf in range(0,npdf):

             file = "../Observables/res/pyres/pOBS_{0}{1}_{2}.res".format(exp[iexp],expset[iexp][iset],pdfs[ipdf])
             print("-----------------------------------------------------------------")
             print("File being read is " + str(file))
             print("-----------------------------------------------------------------")
             with open(file) as contents:
                 contents = contents.read()

             lines = contents.split('\n')
             tabs  = [line.split('\t') for line in lines]


             nrep[ipdf]     = int(tabs[0][2])
             print("Number of replicas for pdf " + str(pdfs[ipdf]) + ": " + str(nrep[ipdf]))

             npt[iexp,iset] = int(tabs[0][1])
             print("Number of data points: " + str(npt[iexp,iset]))

             for irep in range(0,nrep[ipdf]):
                 datalines   = [2 + irep*(1 + npt[iexp,iset]),
                                1 + (irep + 1)*(1 + npt[iexp,iset])]


                 for fileline in range(datalines[0],datalines[1]):
                     ipt                            = 1 + fileline - datalines[0]
                     thobs[ipdf,irep,ipt,iexp,iset] = float(tabs[fileline][2])

thobs = thobs[:,1:]

# Calculating central proton observable
for iexp in range(0,nexp):
    for iset in range(0,nset):
        for ipt in range(1,npt[iexp][iset]+1):

            F_p[ipt,iexp,iset] = (1/(float(nrep[0])))*np.sum(thobs[0,1:,ipt,iexp,iset])

# Calculate theory covariance matrix
#   1.  Combine nuclear PDF sets

thobs_nuc = np.zeros(((len(nrep)-1)*maxrep,maxpoint,nexp,nset))

for ipdf in range(1,npdf):

    thobs_nuc[(ipdf-1)*(maxrep-1):ipdf*(maxrep-1)] = thobs[ipdf]

#   2.  Calculate total N_rep for combined set

nrepnuc = np.sum(nrep) - nrep[0] - len(nuclearpdfs)


#   3.  Find covariance matrix

s = np.zeros((maxpoint,maxpoint,nexp,nset))

for iexp in range(0,nexp):
    for iset in range(0,nset):

        for i in range(0,npt[iexp,iset]):
            for j in range(0,npt[iexp,iset]):

                s[i,j,iexp,iset] = (1/float(nrepnuc))*np.sum(
                                     (thobs_nuc[:,i,iexp,iset] - F_p[i,iexp,iset])*(
                                      thobs_nuc[:,j,iexp,iset] - F_p[j,iexp,iset]))


#   4.  Normalise to central theory as percentage

spct = np.zeros((maxpoint,maxpoint,nexp,nset))

for iexp in range(0,nexp):
    for iset in range(0,nset):

        for i in range(0,npt[iexp,iset]):
            for j in range(0,npt[iexp,iset]):

                spct[i,j,iexp,iset] = np.nan_to_num((100*s[i,j,iexp,iset])/(thobs[0,0,i,iexp,iset]*thobs[0,0,j,iexp,iset]))

#   6.  Save and plot covariance matrices

# Setting limits on plotting scale for % plot
if nuclearpdf == "iron":

    plotlims = [[1,3],[10,50]]

elif nuclearpdf == "lead":

    plotlims = [[1,3],[10,50]]

for iexp in range(0,nexp):
    for iset in range(0,nset):

        fig=plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(np.abs(s[:int(npt[iexp,iset]),
                                      :int(npt[iexp,iset]), iexp,iset]))
        fig.colorbar(mat, label = "Absolute value")
        plt.title("{0} {1} {2}".format(exp[iexp], expset[iexp][iset], nuclearpdf))
        plt.savefig("res/pyres/covmat_{0}{1}_{2}".format(exp[iexp], expset[iexp][iset], nuclearpdf))
        plt.show()
        
        np.savetxt('res/pyres/pCOV_{0}{1}_{2}.res'.format(exp[iexp],expset[iexp][iset],nuclearpdf),s[:int(npt[iexp,iset]), :int(npt[iexp,iset]), iexp, iset])
        np.savetxt('res/pyres/pCOV_full_{0}{1}_{2}.res'.format(exp[iexp],expset[iexp][iset],nuclearpdf),s[:,:, iexp, iset])

        fig=plt.figure()
        ax1 = fig.add_subplot(111)
        mat = ax1.matshow(np.abs(spct[:int(npt[iexp,iset]),
                                      :int(npt[iexp,iset]), iexp,iset]), vmin=0, vmax=plotlims[iexp][iset])
        fig.colorbar(mat, label = "% of theory")
        plt.title("{0} {1} {2}".format(exp[iexp], expset[iexp][iset], nuclearpdf))
        plt.savefig("res/pyres/covmat_%_{0}{1}_{2}".format(exp[iexp], expset[iexp][iset], nuclearpdf))
        plt.show()

        np.savetxt('res/pyres/pCOV_%_{0}{1}_{2}.res'.format(exp[iexp],expset[iexp][iset],nuclearpdf),spct[:int(npt[iexp,iset]), :int(npt[iexp,iset]), iexp, iset])
