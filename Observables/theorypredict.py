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

nexp = 2
nset = 2
maxpoint = 1000
npt = list2D(nexp,nset)
obs = list2D(nexp,nset)
x = list3D(nexp,nset,maxpoint)
Q2 = list3D(nexp,nset,maxpoint)
y = list3D(nexp,nset,maxpoint)
exobs = list3D(nexp,nset,maxpoint)
Q = list3D(nexp,nset,maxpoint)

# Initialise data files to be read
exp = ["CHORUS", "NTV"]
expset = [["NU", "NB"], ["NUDMN", "NBDMN"]]


# Read in PDF set name from command line
pdfset=input("Please enter the PDF set name: ")
print("PDF set: " + pdfset)

# Reading data
for iexp in range(0,nexp):
    for iset in range(0,nset):
        file = "./commondata/DATA_{0}{1}.dat".format(exp[iexp],expset[iexp][iset])
        print("File being read is " + str(file))
        with open(file) as contents:
            contents = contents.read()

        npt[iexp][iset] = getelement(contents,2,0)
        print("Number of data points: " + str(npt[iexp][iset]))

        obs[iexp][iset] = str(getelement(contents,1,1))
        print("Observable: " + obs[iexp][iset])  
  
        for ipt in range(1,int(npt[iexp][iset])+1):
            x[iexp][iset][ipt] = getelement(contents,2,ipt)
            Q2[iexp][iset][ipt] = getelement(contents,3,ipt)
            y[iexp][iset][ipt] = getelement(contents,4,ipt)
            exobs[iexp][iset][ipt] = getelement(contents,5,ipt)      
            Q[iexp][iset][ipt] = str(sqrt(float(Q2[iexp][iset][ipt])))

# Initialise theory details
ptord        = 1
HQms         = "FONLL-B"
alphaQCDref  = 0.118e0
QalphaQCDref = 91.2
alphaQEDref  = 0.007496252e0
QalphaQEDref = 1.777e0
mcpole       = 1.51e0
mbpole       = 4.92e0
mtpole       = 172.5e0
nflmax       = 5
Q0           = 1.65e0

apfel.SetPDFSet(pdfset); 
apfel.SetPerturbativeOrder(ptord);   
apfel.SetMassScheme(HQms)
apfel.SetAlphaQCDRef(alphaQCDref,QalphaQCDref) 
apfel.SetAlphaQEDRef(alphaQEDref,QalphaQEDref)
apfel.SetPoleMasses(mcpole,mbpole,mtpole)
apfel.EnableIntrinsicCharm(True)
apfel.EnableDampingFONLL(False)
apfel.EnableTargetMassCorrections(True)
apfel.SetPDFEvolution("truncated")
apfel.SetMaxFlavourAlpha(nflmax)
apfel.SetMaxFlavourPDFs(nflmax)

apfel.InitializeAPFEL()
apfel.InitializeAPFEL_DIS()







    
