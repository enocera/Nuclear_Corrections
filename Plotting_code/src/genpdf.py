#! /usr/bin/env python

import lhapdf
import numpy as np
import sys
import matplotlib.pyplot as plt

# Reading in command line arguments
pdfset = str(sys.argv[1])
A = int(sys.argv[2])
Z = int(sys.argv[3])
q = float(sys.argv[4])
boundppdfset = "{0}_bp".format(pdfset)

# Need to remove decimal place for the Q appearing in filenames
qstring=str(q)
qstring=qstring.replace(".","p")

# Reading in PDF sets
p = lhapdf.mkPDF(pdfset, 0)
#pset = lhapdf.getPDFSet(pdfset)
pdfs2 = lhapdf.mkPDFs(pdfset)

# Generating PDFs member by member and writing them to an array
N=len(pdfs2)
npair = int((N-1)/2)
#xs = [x for x in np.logspace(-4, 0, 100)]
xs = [x for x in [1e-4,2e-4,3e-4,4e-4,5e-4,6e-4,7e-4,8e-4,9e-4,1e-3,2e-3,3e-3,4e-3,5e-3,6e-3,7e-3,8e-3,9e-3,1e-2,2e-2,3e-2,4e-2,5e-2,6e-2,7e-2,8e-2,9e-2,1e-1,2e-1,3e-1,4e-1,5e-1,6e-1,7e-1,8e-1,9e-1]]
# Creating  dictionaries for dynamic variable assignment
dict = {"f_1":np.zeros([N,len(xs)]), "f_2":np.zeros([N,len(xs)]), "f_3":np.zeros([N,len(xs)]),"f_-1":np.zeros([N,len(xs)]), "f_-2":np.zeros([N,len(xs)]), "f_-3":np.zeros([N,len(xs)]), "f_21":np.zeros([N,len(xs)]),"f_11":np.zeros([N,len(xs)]), "f_22":np.zeros([N,len(xs)]),"f_-11":np.zeros([N,len(xs)]), "f_-22":np.zeros([N,len(xs)])}

errordict = {"f_1":np.zeros([len(xs)]), "f_2":np.zeros([len(xs)]), "f_3":np.zeros([len(xs)]),"f_-1":np.zeros([len(xs)]), "f_-2":np.zeros([len(xs)]), "f_-3":np.zeros([len(xs)]), "f_21":np.zeros([len(xs)]),"f_11":np.zeros([len(xs)]), "f_22":np.zeros([len(xs)]),"f_-11":np.zeros([len(xs)]), "f_-22":np.zeros([len(xs)])}

# Loop over PIDs to fill these matrices
for pid in [1,-1,2,-2,3,-3,21]:
    for k in range(N):
        for ix, x in enumerate(xs):
            dict["f_{0}".format(pid)][k,ix] = pdfs2[k].xfxQ(pid, x, q)
# Transforming up and down type quarks from full nuclear to bound proton. Giving them new PIDs which don't conflict with the ones we already have:
# dbp = 11, dbbp=-11, ubp=22, ubbp=-22
for pid in [1,-1,2,-2]:
    dict["f_22"] = ((A-Z)*dict["f_1"]-Z*dict["f_2"])/(A-2*Z)
    dict["f_11"] = ((A-Z)*dict["f_2"]-Z*dict["f_1"])/(A-2*Z)
    dict["f_-22"] = ((A-Z)*dict["f_-1"]-Z*dict["f_-2"])/(A-2*Z)
    dict["f_-11"] = ((A-Z)*dict["f_-2"]-Z*dict["f_-1"])/(A-2*Z)

# Calculating Hessian errors
fdiff=np.zeros([npair,len(xs)])
fdiff_sq_sum=np.zeros([len(xs)])

for pid in [1,-1,2,-2,3,-3,21,11,-11,22,-22]:
    for i in range(0,npair):
        fdiff[i]=dict["f_{0}".format(pid)][i+1]-dict["f_{0}".format(pid)][i+npair+1]
    fdiff_sq=np.square(fdiff)
    for i in range(len(xs)):
        fdiff_sq_sum[i]=np.sum(fdiff_sq[:,i])
    errordict["f_{0}".format(pid)]=0.5*np.sqrt(fdiff_sq_sum)

    with open('../res/{0}/data_{1}_{0}_q{2}.txt'.format(pdfset,pid,qstring), 'w') as output:
        for index in range(len(xs)):
            output.write(str(xs[index]) + "\t" + str(dict["f_{0}".format(pid)][0,index]) + "\t" + str(errordict["f_{0}".format(pid)][index]) + "\n")

    # Now to plot central pdf with errors
    fig=plt.figure()
    ax = fig.add_subplot(111)
    ax.set_xscale('log')
    ax.plot(xs,dict["f_{0}".format(pid)][0])
    #ax.plot(xs,f[0],errors)
    ax.fill_between(xs, dict["f_{0}".format(pid)][0]+np.absolute(errordict["f_{0}".format(pid)]), dict["f_{0}".format(pid)][0]-np.absolute(errordict["f_{0}".format(pid)]),alpha=0.5,facecolor="turquoise")
    plt.title("{0} PID = {1} Q = {2} GeV".format(pdfset, pid, q))
    plt.xlabel("x")
    plt.ylabel("xf")
    #plt.ylim(-2,10)
    plt.xlim(1e-3,1)
    plt.savefig('../plots/{0}/{0}_{1}_q{2}_plot'.format(pdfset,pid,qstring))
