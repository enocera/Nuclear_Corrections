import numpy as np
import re
import sys
import glob
import matplotlib.pyplot as plt
from matplotlib import rc

# Reading in command line arguments
pid = int(sys.argv[1])
q = float(sys.argv[2])
pdfseta = str(sys.argv[3])
pdfsetb = str(sys.argv[4])
pdfsetc = str(sys.argv[5])
pdfsetd = str(sys.argv[6])
pdfsete = str(sys.argv[7])

# Need to remove decimal place for the Q appearing in filenames 
qstring=str(q)
qstring=qstring.replace(".","p")

# Getting data
x,ra,rerra=np.loadtxt(glob.glob('../res/{0}/data_{1}_{0}*q{2}.txt'.format(pdfseta,pid,qstring))[0], unpack=True)
x0,rb,rerrb=np.loadtxt(glob.glob('../res/{0}/data_{1}_{0}*q{2}.txt'.format(pdfsetb,pid,qstring))[0], unpack=True)
x00,rc,rerrc=np.loadtxt(glob.glob('../res/{0}/data_{1}_{0}*q{2}.txt'.format(pdfsetc,pid,qstring))[0], unpack=True)
x00,rd,rerrd=np.loadtxt(glob.glob('../res/{0}/data_{1}_{0}*q{2}.txt'.format(pdfsetd,pid,qstring))[0], unpack=True)
x000,re,rerre=np.loadtxt(glob.glob('../res/{0}/data_{1}_{0}*q{2}.txt'.format(pdfsete,pid,qstring))[0], unpack=True)

# Rescaling Hessian errors from 90% to 68% confidence levels
rerra=rerra/1.65

# Calculating percentage difference in errors
#pdiffb = 200*(rerrb-rerra)/(rerrb+rerra)
#pdiffc = 200*(rerrc-rerra)/(rerrc+rerra)
#pdiffd = 200*(rerrd-rerra)/(rerrd+rerra)
perrdiffb = (1-rerrb[:-1]/rerra[:-1])*100
perrdiffc = (1-rerrc[:-1]/rerra[:-1])*100
perrdiffd = (1-rerrd[:-1]/rerra[:-1])*100
perrdiffe = (1-rerre[:-1]/rerra[:-1])*100

# Calculating percentage difference
pdiffb = (1-rb[:-1]/ra[:-1])*100
pdiffc = (1-rc[:-1]/ra[:-1])*100
pdiffd = (1-rd[:-1]/ra[:-1])*100
pdiffe = (1-re[:-1]/ra[:-1])*100

# Plotting
fig=plt.figure()
ax = fig.add_subplot(111)
ax.set_xscale('log')
ax.plot(x[:-1],perrdiffb,label="{0}".format(pdfsetb))
ax1 = fig.add_subplot(111)
ax1.plot(x[:-1],perrdiffc,label="{0}".format(pdfsetc))
ax2 = fig.add_subplot(111)
ax2.plot(x[:-1],perrdiffd,label="{0}".format(pdfsetd))
ax3 = fig.add_subplot(111)
ax3.plot(x[:-1],perrdiffe,label="{0}".format(pdfsete))
plt.title("Error % difference to {0} for PID={1} and Q={2} GeV".format(pdfseta,pid,q))
plt.xlabel("x")
plt.ylabel("Error % difference")
plt.xlim(1e-3,1)
plt.legend()
plt.savefig('../plots/perrdiff_{0}_{1}_q{2}'.format(pdfseta,pid,qstring))

fig=plt.figure()
ax = fig.add_subplot(111)
ax.set_xscale('log')
ax.plot(x[:-1],pdiffb,label="{0}".format(pdfsetb))
ax1 = fig.add_subplot(111)
ax1.plot(x[:-1],pdiffc,label="{0}".format(pdfsetc))
ax2 = fig.add_subplot(111)
ax2.plot(x[:-1],pdiffd,label="{0}".format(pdfsetd))
ax3 = fig.add_subplot(111)
ax3.plot(x[:-1],pdiffe,label="{0}".format(pdfsete))
plt.title("% difference to {0} for PID={1} and Q={2} GeV".format(pdfseta,pid,q))
plt.xlabel("x")
plt.ylabel("% difference")
plt.xlim(1e-3,1)
plt.legend()
plt.savefig('../plots/pdiff_{0}_{1}_q{2}'.format(pdfseta,pid,qstring))
