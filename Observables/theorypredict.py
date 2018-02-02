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

# Initialise data files to be read
exp      = ["CHORUS", "NTV"]
expset   = [["NU", "NB"], ["NUDMN", "NBDMN"]]


# Read in PDF set name from command line and initialise PDF file
pdfset   =  input("Please enter the PDF set name: ")
print("PDF set: " + pdfset)

pdfs     =  lhapdf.mkPDFs(pdfset)
nrep     =  len(pdfs)

nexp     = 2
nset     = 2
maxpoint = 1000

npt      = list2D(nexp,nset)
obs      = list2D(nexp,nset)
x        = list3D(maxpoint,nexp,nset)
Q2       = list3D(maxpoint,nexp,nset)
y        = list3D(maxpoint,nexp,nset)
exobs    = list3D(maxpoint,nexp,nset)
Q        = list3D(maxpoint,nexp,nset)
thobs    = list4D(nrep,maxpoint,nexp,nset)

# Reading data
for iexp in range(0,nexp):
    for iset in range(0,nset):

        file = "./commondata/DATA_{0}{1}.dat".format(exp[iexp],expset[iexp][iset])
        print("-----------------------------------------------------------------")
        print("File being read is " + str(file))
        print("-----------------------------------------------------------------")
        with open(file) as contents:
            contents = contents.read()

        npt[iexp][iset] = getelement(contents,2,0)
        print("Number of data points: " + str(npt[iexp][iset]))

        obs[iexp][iset] = str(getelement(contents,1,1))
        print("Observable: " + obs[iexp][iset])

        for ipt in range(1,int(npt[iexp][iset])+1):

            x[ipt][iexp][iset]     = getelement(contents,2,ipt)
            Q2[ipt][iexp][iset]    = getelement(contents,3,ipt)
            y[ipt][iexp][iset]     = getelement(contents,4,ipt)
            exobs[ipt][iexp][iset] = getelement(contents,5,ipt)

            Q[ipt][iexp][iset]     = str(sqrt(float(Q2[ipt][iexp][iset])))

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

# Compute predictions
for irep in range(1,nrep+1):

    apfel.SetReplica(irep)

    for iexp in range(0, nexp):
        for iset in range(0,nset):
            for ipt in range(1, int(npt[iexp][iset])+1):

                if float(Q[ipt][iexp][iset]) > 1e0:

                    print("Q > 1")
                    apfel.ComputeStructureFunctionsAPFEL(Q0,float(Q[ipt][iexp][iset]))
                    print("Test 1")
                    apfel.SetFKObservable(obs[iexp][iset])
                    print("Test 2")

                    thobs[irep][ipt][iexp][iset] = apfel.FKObservables(x[ipt][iexp][iset],
                                                                        Q[ipt][iexp][iset],
                                                                        y[ipt][iexp][iset])

                    print("Theory observable:  " + str(thobs[irep][ipt][iexp][iset]))

                else:

                     print("Q < 1, setting theory result to 0")
                     thobs[irep][ipt][iexp][iset]  =  0e0

# Writing results to file
for iexp in range(0,nexp):
    for iset in range(0,nset):

        with open('/res/pyres/pOBS_{0}{1}.res'.format(exp[iexp],expset[iset]), 'w') as output:

            output.write(str(obs[iexp][iset]) + "\t" + str(npt[iexp][iset]) + "\n")

            for irep in range (1,nrep+1):

                output.write(str(irep) + "\n")

                for ipt in range(1,int(npt[iexp][iset])+1):

                    output.write(str(ipt) + "\t" + str(x[ipt][iexp][iset])
                                + "\t" + str(thobs[irep][ipt][iexp][iset]) + "\t"
                                + str(exobs[ipt][iexp][iset])+ "\n")
