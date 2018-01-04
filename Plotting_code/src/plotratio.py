
import numpy as np
import re
import glob
import sys
import matplotlib.pyplot as plt
from matplotlib import rc

pdfseta = str(sys.argv[1])
pdfsetb = str(sys.argv[2])
pid = int(sys.argv[3])
q = float(sys.argv[4])

# Need to remove decimal place for the Q appearing in filenames 
qstring=str(q)
qstring=qstring.replace(".","p")

numbers = re.compile(r'(\d+)')
def numericalSort(value):
    parts = numbers.split(value)
    parts[1::2] = map(int, parts[1::2])
    return parts

# Getting data
x,fa,ferra=np.loadtxt('../res/{0}/data_{1}_{0}_q{2}.txt'.format(pdfseta,pid,qstring), unpack=True)
x0,fb,ferrb=np.loadtxt('../res/{0}/data_{1}_{0}_q{2}.txt'.format(pdfsetb,pid,qstring), unpack=True)

# Calculating ratio, taking off last entry as it is 0 so undefined ratio
r=fa[:-1]/fb[:-1]

# Calculating ratio errors
rerr=r*np.sqrt((ferra[:-1]/fa[:-1])**2 + (ferrb[:-1]/fb[:-1])**2)

# Saving data 
with open('../res/{0}/ratio_{1}_{0}_{2}_q{3}.txt'.format(pdfseta,pid,pdfsetb,qstring), 'w') as output:
    for index in range(len(x[:-1])):
        output.write(str(x[index]) + "\t" + str(r[index]) + "\t" + str(rerr.T[index]) + "\n")

# Plotting
fig=plt.figure()
ax = fig.add_subplot(111)
ax.set_xscale('log')
ax.plot(x[:-1],r)
ax.fill_between(x[:-1],r+np.absolute(rerr.T), r-np.absolute(rerr.T),alpha=0.5,facecolor="turquoise")
plt.title("Ratio of {0} to {1} for PID={2} and Q={3} GeV".format(pdfseta,pdfsetb,pid,q))
plt.xlabel("x")
plt.ylabel("R")
plt.ylim(0,1.8)
plt.xlim(1e-3,1)
plt.savefig('../plots/ratio_{0}_{1}_{2}_q{3}'.format(pdfseta,pdfsetb,pid,qstring))

