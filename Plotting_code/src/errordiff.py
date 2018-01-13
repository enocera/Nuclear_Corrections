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

# Need to remove decimal place for the Q appearing in filenames 
qstring=str(q)
qstring=qstring.replace(".","p")
# Getting data
x,ra,rerra=np.loadtxt(glob.glob('../res/{0}/ratio_{1}_{0}*q{2}.txt'.format(pdfseta,pid,qstring))[0], unpack=True)
x0,rb,rerrb=np.loadtxt(glob.glob('../res/{0}/ratio_{1}_{0}*q{2}.txt'.format(pdfsetb,pid,qstring))[0], unpack=True)
x00,rc,rerrc=np.loadtxt(glob.glob('../res/{0}/ratio_{1}_{0}*q{2}.txt'.format(pdfsetc,pid,qstring))[0], unpack=True)
x00,rd,rerrd=np.loadtxt(glob.glob('../res/{0}/ratio_{1}_{0}*q{2}.txt'.format(pdfsetd,pid,qstring))[0], unpack=True)

# Calculating percentage difference in errors
#pdiffb = 200*(rerrb-rerra)/(rerrb+rerra)
#pdiffc = 200*(rerrc-rerra)/(rerrc+rerra)
#pdiffd = 200*(rerrd-rerra)/(rerrd+rerra)
pdiffb = (1-rerrb/rerra)*100
pdiffc = (1-rerrc/rerra)*100
pdiffd = (1-rerrd/rerra)*100
# Plotting
fig=plt.figure()
ax = fig.add_subplot(111)
ax.set_xscale('log')
ax.plot(x,pdiffb,label="{0}".format(pdfsetb))
ax1 = fig.add_subplot(111)
ax1.plot(x,pdiffc,label="{0}".format(pdfsetc))
ax2 = fig.add_subplot(111)
ax2.plot(x,pdiffd,label="{0}".format(pdfsetd))
plt.title("Ratio percentage difference to {0} for PID={1} and Q={2} GeV".format(pdfseta,pid,q))
plt.xlabel("x")
plt.ylabel("Percentage difference")
plt.xlim(1e-3,1)
plt.legend()
plt.savefig('../plots/pdiff_{0}_{1}_q{2}'.format(pdfseta,pid,qstring))
