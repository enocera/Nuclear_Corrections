import numpy as np
import re
import sys
import glob
import matplotlib.pyplot as plt
from matplotlib import rc
pdfroot=str(sys.argv[1])

x1,y1,y1err=np.loadtxt("/scratch/s1303034/rosalyn/DSSZ_NLO_Fe56/relunc_0.res", usecols=(1,2,3),unpack=True)
x2,y2,y2err=np.loadtxt("../res/DSSZ_NLO_Fe56/data_21_DSSZ_NLO_Fe56_q3p16227766017.txt", unpack=True)

for p in range(len(x1)):
    if x1[p]!=x2[p]:
        print("x values not equal - aborting")
        sys.exit()

fig=plt.figure()
ax = fig.add_subplot(111)
ax.set_xscale('log')
ax.plot(x1,y1/y1)
ax.fill_between(x1,y1/y1+np.absolute(y1err)/y1, y1/y1-np.absolute(y1err)/y1,alpha=0.5,label="E")
ax2 = fig.add_subplot(111)
ax2.set_xscale('log')
ax2.plot(x2,y2/y1)
ax.fill_between(x2,y2/y1+np.absolute(y2err)/y1, y2/y1-np.absolute(y2err)/y1,alpha=0.5,label="R")
plt.xlabel("x")
plt.ylabel("xf")
#plt.ylim(-2,10)
plt.xlim(1e-3,1)
plt.legend()
plt.title("DSSZ_NLO_Fe56 Gluon")
plt.savefig('../plots/datacompare.png')
