#!/usr/bin/python

import lhapdf
import apfel
import numpy as np
import sys
from math import sqrt

def getelement(datafile,x,y):
    element = (datafile.split("\n")[y]).split("\t")[x]
    return element

def list2D(a, b):
    lst = [['#' for col in range(b)] for row in range(a)]
    return lst

def list3D(a, b, c):
    lst = [[ ['#' for col in range(c)] for col in range(b)] for row in range(a)]
    return lst

def list4D(a, b, c, d):
    lst = [[ [['#' for col in range(d)] for col in range(c)] for col in range(b)] for row in range(a)]
    return lst

def list5D(a, b, c, d, e):
    lst = [[ [[ ['#' for col in range(e)] for col in range(d)] for col in range(c)] for col in range(b)] for row in range(a)]
    return lst

# Read in PDF set names
nuclearpdf  =  raw_input("***** Please choose iron or lead: ")
if nuclearpdf != "iron" and nuclearpdf != "lead":
    print("Error: Invalid choice of element")
    sys.exit()

protonpdf   =  "NNPDF31_nlo_pch_as_0118"
print("----------------------------------------------------")
print("Computing theory covariance matrix for " + nuclearpdf + " relative to proton PDF " + protonpdf)
print("----------------------------------------------------")

# nucpdfs     =  lhapdf.mkPDFs(nuclearpdf)
# ppdfs       =  lhapdf.mkPDFs(protonpdf)
# nnucrep     =  len(nucpdfs)
# nprep       =  len(ppdfs)


# Initialise data files to be read
exp      = ["CHORUS", "NTV"]
expset   = [["NU", "NB"], ["NUDMN", "NBDMN"]]

if nuclearpdf = "iron":

    nuclearpdfs = ["DSSZ_NLO_Fe56_MC_1000_compressed_250",
                   "EPPS16nlo_CT14nlo_Fe56_MC_1000_compressed_250",
                   "nCTEQ15FullNuc_56_26_MC_1000_compressed_250"]

else if nuclearpdf = "lead":

    nuclearpdfs = ["DSSZ_NLO_Pb208_MC_1000_compressed_250",
                   "EPPS16nlo_CT14nlo_Pb208_MC_1000_compressed_250",
                   "nCTEQ15FullNuc_208_82_MC_1000_compressed_250"]

nexp     = 2
nset     = 2
npdf     = 2
maxpoint = 1000

npt      = list2D(nexp,nset)
thobs    = list5D(npdf,nrep+1,maxpoint,nexp,nset)
datpoint =
nrep     = ['#','#']

#
#
# # Reading data
# for iexp in range(0,nexp):
#     for iset in range(0,nset):
#         for ipdf in range(0,npdf):
#
#             file = "res/pyres/pOBS_{0}{1}_{2}.res".format(exp[iexp],expset[iexp][iset],pdfset)
#             print("-----------------------------------------------------------------")
#             print("File being read is " + str(file))
#             print("-----------------------------------------------------------------")
#             with open(file) as contents:
#                 contents = contents.read()
#
#             nrep[ipdf] = getelement(contents,2,0)
#             print("Number of replicas for pdf " + str(pdfset[ipdf]) ": "+ str(npt[iexp][iset]))
#
#             npt[iexp][iset] = getelement(contents,1,0)
#             print("Number of data points: " + str(npt[iexp][iset]))
#
#             for irep in range(0,int(nrep[ipdf])):
#
#                 datpoint[i]
#                 thobs[ipt][iexp][iset] = getelement(contents,5,ipt)
#
#                 Q[ipt][iexp][iset]     = str(sqrt(float(Q2[ipt][iexp][iset])))
