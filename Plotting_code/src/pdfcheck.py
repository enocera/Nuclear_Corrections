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

# Reading in PDF sets
p = lhapdf.mkPDF(pdfset, 0)
#pset = lhapdf.getPDFSet(pdfset)
pdfs2 = lhapdf.mkPDFs(pdfset)
print("loaded pdfs2")
# Generating PDFs member by member and writing them to an array
N=len(pdfs2)
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

xs = [x for x in np.logspace(-4, 0, 100)]
# Creating  dictionaries for dynamic variable assignment
#dict = {"f_1":np.zeros([N,len(xs)]), "f_2":np.zeros([N,len(xs)]), "f_3":np.zeros([N,len(xs)]),"f_-1":np.zeros([N,len(xs)]), "f_-2":np.zeros([N,len(xs)]), "f_-3":np.zeros([N,len(xs)]), "f_21":np.zeros([N,len(xs)]),"f_11":np.zeros([N,len(xs)]), "f_22":np.zeros([N,len(xs)]),"f_-11":np.zeros([N,len(xs)]), "f_-22":np.zeros([N,len(xs)])}
dict = {"f_21":np.zeros([N,len(xs)]),"g_21_0":np.zeros([len(xs)]),"g_21_2":np.zeros([len(xs)]), "g_21_1000":np.zeros([len(xs)]),"g_21_999":np.zeros([len(xs)])}
errordict = {"f_1":np.zeros([len(xs)]), "f_2":np.zeros([len(xs)]), "f_3":np.zeros([len(xs)]),"f_-1":np.zeros([len(xs)]), "f_-2":np.zeros([len(xs)]), "f_-3":np.zeros([len(xs)]), "f_21":np.zeros([len(xs)]),"f_11":np.zeros([len(xs)]), "f_22":np.zeros([len(xs)]),"f_-11":np.zeros([len(xs)]), "f_-22":np.zeros([len(xs)]),"g_21_0":np.zeros([len(xs)]),"g_21_2":np.zeros([len(xs)]), "g_21_1000":np.zeros([len(xs)]),"g_21_999":np.zeros([len(xs)])}
dictmember = {}
print("initialised dictionaries")
print("range(N)=" + str(range(N)))
for k in range(N):
    new_key = str("g_21_{0}".format(k))
    dictmember[new_key] = np.zeros([len(xs)])
print("filled dictionaries")
# Loop over PIDs to fill these matrices
q=3.1622

for pid in [21]:
    for k in range(N):
        for ix, x in enumerate(xs):
            dict["f_{0}".format(pid)][k,ix] = pdfs2[k].xfxQ(pid, x, q)
            dictmember["g_21_{0}".format(k)][ix] = pdfs2[k].xfxQ(pid, x, q)
            dictmember["g_21_{0}".format(k)][ix] = pdfs2[k].xfxQ(pid, x, q)
            dictmember["g_21_{0}".format(k)][ix] = pdfs2[k].xfxQ(pid, x, q)
            dictmember["g_21_{0}".format(k)][ix] = pdfs2[k].xfxQ(pid, x, q)
print("looped over pdfs")

#print("f for gluon=")
#print(dict["f_21"])
#print("g for gluon member 0=")
#print(dictmember["g_21_0"])
#print("g for gluon member 2=")
#print(dictmember["g_21_2"])

# Calculating errors by matrix manipulation
for pid in [21]:
    errordict["f_{0}".format(pid)] = np.sqrt(np.mean(np.square(dict["f_{0}".format(pid)]),axis=0)-np.square(np.mean(dict["f_{0}".format(pid)],axis=0)))
#     with open('../res/{0}/data_{1}_{0}_q{2}.txt'.format(pdfset,pid,qstring), 'w') as output:
#         for index in range(len(xs)):
#             output.write(str(xs[index]) + "\t" + str(dict["f_{0}".format(pid)][0,index]) + "\t" + str(errordict["f_{0}".format(pid)][index]) + "\n")
print("matrix errors=")
print(errordict["f_21"])

# Calculating errors looping over members





