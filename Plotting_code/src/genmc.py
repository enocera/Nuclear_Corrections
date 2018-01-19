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
xs = [x for x in np.logspace(-4, 0, 100)]

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

# Calculating MC errors
for pid in [1,-1,2,-2,3,-3,21,11,-11,22,-22]:
    errordict["f_{0}".format(pid)] = np.sqrt(np.mean(np.square(dict["f_{0}".format(pid)]),axis=0)-np.square(np.mean(dict["f_{0}".format(pid)],axis=0)))
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
