import numpy as np
import re
import sys
import glob
import matplotlib.pyplot as plt
from matplotlib import rc
pdfstring=str(sys.argv[1])
pid = int(sys.argv[2])
q = float(sys.argv[3])
print("-------------")
print("PDF string: "+ pdfstring)
print("-------------")
# Need to remove decimal place for the Q appearing in filenames
qstring=str(q)
qstring=qstring.replace(".","p")
# Transforming between PID conventions
mypids=[21,1,-1,2,-2,3,-3]
epids=[0,1,-1,2,-2,3,3]
epid=epids[mypids.index(pid)]
dict={}
# a: Emanuele, b: Rosalyn
dict["xha"],dict["yha"],dict["yherra"]=np.loadtxt("../../../rosalyn/{0}/relunc_{1}.res".format(pdfstring,epid), usecols=(1,2,3),unpack=True)
dict["ymca"],dict["ymcerra"]=np.loadtxt("../../../rosalyn/{0}/relunc_{1}.res".format(pdfstring,epid), usecols=(4,5),unpack=True)
dict["ymc100a"],dict["ymc100erra"]=np.loadtxt("../../../rosalyn/{0}/relunc_{1}.res".format(pdfstring,epid), usecols=(6,7),unpack=True)
dict["ymc1000a"],dict["ymc1000erra"]=np.loadtxt("../../../rosalyn/{0}/relunc_{1}.res".format(pdfstring,epid), usecols=(8,9),unpack=True)
dict["ymc1000c25a"],dict["ymc1000c25erra"]=np.loadtxt("../../../rosalyn/{0}/relunc_{1}.res".format(pdfstring,epid), usecols=(10,11),unpack=True)

dict["xhb"],dict["yhb"],dict["yherrb"]=np.loadtxt("../res/{0}/data_{1}_{0}_q{2}.txt".format(pdfstring,pid,qstring), unpack=True)
dict["xmcb"],dict["ymcb"],dict["ymcerrb"]=np.loadtxt("../res/{0}_MC/data_{1}_{0}_MC_q{2}.txt".format(pdfstring,pid,qstring), unpack=True)
dict["xmc100b"],dict["ymc100b"],dict["ymc100errb"]=np.loadtxt("../res/{0}_MC_100/data_{1}_{0}_MC_100_q{2}.txt".format(pdfstring,pid,qstring), unpack=True)
dict["xmc1000b"],dict["ymc1000b"],dict["ymc1000errb"]=np.loadtxt("../res/{0}_MC_1000/data_{1}_{0}_MC_1000_q{2}.txt".format(pdfstring,pid,qstring), unpack=True)
dict["xmc1000c25b"],dict["ymc1000c25b"],dict["ymc1000c25errb"]=np.loadtxt("../res/{0}_MC_1000_compressed_25/data_{1}_{0}_MC_1000_compressed_25_q{2}.txt".format(pdfstring,pid,qstring), unpack=True)

for p in range(len(dict["xha"])):
    if dict["xha"][p]!=dict["xhb"][p]:
        print("x values not equal - aborting")
        sys.exit()
for setstring in ["h","mc","mc100","mc1000","mc1000c25"]:
    fig=plt.figure()
    ax = fig.add_subplot(111)
    ax.set_xscale('log')
    ax.plot(dict["x{0}b".format(setstring)][:-1],dict["y{0}a".format(setstring)][:-1]/dict["y{0}a".format(setstring)][:-1])
    ax.fill_between(dict["x{0}b".format(setstring)][:-1],dict["y{0}a".format(setstring)][:-1]/dict["y{0}a".format(setstring)][:-1]+np.absolute(dict["y{0}erra".format(setstring)][:-1])/dict["y{0}a".format(setstring)][:-1], dict["y{0}a".format(setstring)][:-1]/dict["y{0}a".format(setstring)][:-1]-np.absolute(dict["y{0}erra".format(setstring)][:-1])/dict["y{0}a".format(setstring)][:-1],alpha=0.5,label="E")
    ax2 = fig.add_subplot(111)
    ax2.set_xscale('log')
    ax2.plot(dict["x{0}b".format(setstring)][:-1],dict["y{0}b".format(setstring)][:-1]/dict["y{0}a".format(setstring)][:-1])
    ax.fill_between(dict["x{0}b".format(setstring)][:-1],dict["y{0}b".format(setstring)][:-1]/dict["y{0}a".format(setstring)][:-1]+np.absolute(dict["y{0}errb".format(setstring)][:-1])/dict["y{0}a".format(setstring)][:-1], dict["y{0}b".format(setstring)][:-1]/dict["y{0}a".format(setstring)][:-1]-np.absolute(dict["y{0}errb".format(setstring)][:-1])/dict["y{0}a".format(setstring)][:-1],alpha=0.5,label="R")
    plt.ylabel("PDF ratio to Emanuele")
    plt.xlim(1e-3,1)
    plt.legend()
    plt.title("{0}, setID:{3} PID={1}, Q={2} GeV".format(pdfstring,pid,q,setstring))
    plt.savefig('../plots/ercompare/er_{0}_{1}_{2}_{3}.png'.format(pdfstring,pid,q,setstring))
