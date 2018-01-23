#! /usr/bin/env python
import lhapdf
import numpy as np
import sys
import matplotlib.pyplot as plt

# Reading in command line arguments
pdfset = str(sys.argv[1])
# A = int(sys.argv[2])
# Z = int(sys.argv[3])
# q = float(sys.argv[4])
# boundppdfset = "{0}_bp".format(pdfset)
#
# # Need to remove decimal place for the Q appearing in filenames
# qstring=str(q)
# qstring=qstring.replace(".","p")
p = lhapdf.mkPDF(pdfset, 0)
q=2
A=26
Z=56
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

N=len(pdfs2)
print("N="+str(N))
npair = int((N-1)/2)
print("npair="+str(npair))
# Calculating Hessian errors
fdiff=np.zeros([npair,len(xs)])
fdiff_sq_sum=np.zeros([len(xs)])
print("f_21=")
print(dict["f_21"])
print("f_21[1]=")
print(dict["f_21"][1])
# for pid in [1,-1,2,-2,3,-3,21,11,-11,22,-22]:
for pid in [21]:
    for i in range(0,npair):
        print("pair numbers are "+str(i+1)+ " and "+str(i+npair+1))
        print("f_{0}=".format(pid))
        fdiff[i]=dict["f_{0}".format(pid)][i+1]-dict["f_{0}".format(pid)][i+npair+1]
        print("fdiff[{0}]=".format(i))
        print(fdiff[i])
    fdiff_sq=np.square(fdiff)
    for i in range(len(xs)):
        fdiff_sq_sum[i]=np.sum(fdiff_sq[:,i])
    errordict["f_{0}".format(pid)]=0.5*np.sqrt(fdiff_sq_sum)
print("fdiff=")
print(fdiff)


# dict={}
# for k in range(N):
#     dict["p_{0}".format(k)]=lhapdf.mkPDF(pdfset,k).xfxQ(21, 1e-4, 3.1622)
# for k in range(N):
#     dict["q_{0}".format(k)] = pdfs2[k].xfxQ(21, 1e-4, 3.1622)
#
# print("Cental member at x=0.0001, Q=3.1622 GeV")
# print(p.xfxQ(21, 1e-4, 3.1622))
# print("p_0 at x=0.0001, Q=3.1622 GeV")
# print(dict["p_{0}".format(0)])
# print("p_1000 at x=0.0001, Q=3.1622 GeV")
# print(dict["p_{0}".format(1000)])
# print("q_0 at x=0.0001, Q=3.1622 GeV")
# print(dict["q_{0}".format(0)])
# print("q_1000 at x=0.0001, Q=3.1622 GeV")
# print(dict["q_{0}".format(1000)])
#
# xs = [x for x in np.logspace(-4, 0, 100)]
# # Creating  dictionaries for dynamic variable assignment
# #dict = {"f_1":np.zeros([N,len(xs)]), "f_2":np.zeros([N,len(xs)]), "f_3":np.zeros([N,len(xs)]),"f_-1":np.zeros([N,len(xs)]), "f_-2":np.zeros([N,len(xs)]), "f_-3":np.zeros([N,len(xs)]), "f_21":np.zeros([N,len(xs)]),"f_11":np.zeros([N,len(xs)]), "f_22":np.zeros([N,len(xs)]),"f_-11":np.zeros([N,len(xs)]), "f_-22":np.zeros([N,len(xs)])}
# dict = {"f_21":np.zeros([N,len(xs)]),"g_21_0":np.zeros([len(xs)]),"g_21_2":np.zeros([len(xs)]), "g_21_1000":np.zeros([len(xs)]),"g_21_999":np.zeros([len(xs)])}
# errordict = {"f_1":np.zeros([len(xs)]), "f_2":np.zeros([len(xs)]), "f_3":np.zeros([len(xs)]),"f_-1":np.zeros([len(xs)]), "f_-2":np.zeros([len(xs)]), "f_-3":np.zeros([len(xs)]), "f_21":np.zeros([len(xs)]),"f_11":np.zeros([len(xs)]), "f_22":np.zeros([len(xs)]),"f_-11":np.zeros([len(xs)]), "f_-22":np.zeros([len(xs)]),"g_21_0":np.zeros([len(xs)]),"g_21_2":np.zeros([len(xs)]), "g_21_1000":np.zeros([len(xs)]),"g_21_999":np.zeros([len(xs)])}
# dictmember = {}
# print("initialised dictionaries")
# print("range(N)=" + str(range(N)))
# for k in range(N):
#     new_key = str("g_21_{0}".format(k))
#     dictmember[new_key] = np.zeros([len(xs)])
# print("filled dictionaries")
# # Loop over PIDs to fill these matrices
# q=3.1622
#
# for pid in [21]:
#     for k in range(N):
#         for ix, x in enumerate(xs):
#             dict["f_{0}".format(pid)][k,ix] = pdfs2[k].xfxQ(pid, x, q)
#             dictmember["g_21_{0}".format(k)][ix] = pdfs2[k].xfxQ(pid, x, q)
#             dictmember["g_21_{0}".format(k)][ix] = pdfs2[k].xfxQ(pid, x, q)
#             dictmember["g_21_{0}".format(k)][ix] = pdfs2[k].xfxQ(pid, x, q)
#             dictmember["g_21_{0}".format(k)][ix] = pdfs2[k].xfxQ(pid, x, q)
# print("looped over pdfs")
#
# #print("f for gluon=")
# #print(dict["f_21"])
# #print("g for gluon member 0=")
# #print(dictmember["g_21_0"])
# #print("g for gluon member 2=")
# #print(dictmember["g_21_2"])
#
# # Calculating errors by matrix manipulation
# for pid in [21]:
#     errordict["f_{0}".format(pid)] = np.sqrt(np.mean(np.square(dict["f_{0}".format(pid)]),axis=0)-np.square(np.mean(dict["f_{0}".format(pid)],axis=0)))
# #     with open('../res/{0}/data_{1}_{0}_q{2}.txt'.format(pdfset,pid,qstring), 'w') as output:
# #         for index in range(len(xs)):
# #             output.write(str(xs[index]) + "\t" + str(dict["f_{0}".format(pid)][0,index]) + "\t" + str(errordict["f_{0}".format(pid)][index]) + "\n")
# print("matrix errors=")
# print(errordict["f_21"])

# Calculating errors looping over members
