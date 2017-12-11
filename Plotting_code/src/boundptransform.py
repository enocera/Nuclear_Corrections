# Transforms between the up and down quark full nuclear pdfs to bound proton pdfs 

import numpy as np
import re
import glob
import sys
import matplotlib.pyplot as plt
from matplotlib import rc

# Reading in information from the command line
fullnucpdf = str(sys.argv[1])
boundppdf = str(sys.argv[2])
A = int(sys.argv[3])
Z = int(sys.argv[4])


numbers = re.compile(r'(\d+)')
def numericalSort(value):
    parts = numbers.split(value)
    parts[1::2] = map(int, parts[1::2])
    return parts

# Getting data
x,fu,fuerr=np.loadtxt('/home/rosalyn/nuclear/PDFplots/{0}/data_2_{0}.txt'.format(fullnucpdf), unpack=True)
x0,fd,fderr=np.loadtxt('/home/rosalyn/nuclear/PDFplots/{0}/data_1_{0}.txt'.format(fullnucpdf), unpack=True)

# Transforming from full nuclear to bound proton
fubp = ((A-Z)*fd-Z*fu)/(A-2*Z)
fdbp = ((A-Z)*fu-Z*fd)/(A-2*Z)

# Calculating errors
fubperr = np.sqrt((((A-Z)/(A-2*Z))*(fderr))**2 + ((Z/(A-2*Z))*(fuerr))**2)
fdbperr = np.sqrt((((A-Z)/(A-2*Z))*(fuerr))**2 + ((Z/(A-2*Z))*(fderr))**2)

# Printing data to files
with open('/home/rosalyn/nuclear/PDFplots/{0}/data_2_{0}.txt'.format(boundppdf), 'w') as output:
    for index in range(len(x)):
         	output.write(str(x[index]) + "\t" + str(fubp[index]) + "\t" + str(fubperr[index]) + "\n")
with open('/home/rosalyn/nuclear/PDFplots/{0}/data_1_{0}.txt'.format(boundppdf), 'w') as output:
    for index in range(len(x)):
         	output.write(str(x[index]) + "\t" + str(fdbp[index]) + "\t" + str(fdbperr[index]) + "\n")

# Now to plot pdfs with errors
fig=plt.figure()
ax = fig.add_subplot(111)
ax.set_xscale('log')
ax.plot(x,fubp,color="r")
ax.fill_between(x, fubp+np.absolute(fubperr), fubp-np.absolute(fubperr),alpha=0.5,facecolor="r")
plt.title("{0} bound proton PDF, PID = 2".format(boundppdf))
plt.xlabel("x")
plt.ylabel("xf")
#plt.ylim(-2,10)
plt.xlim(1e-3,1)
plt.savefig('/home/rosalyn/nuclear/PDFplots/{0}/{0}_u_plot'.format(boundppdf))

fig=plt.figure()
ax = fig.add_subplot(111)
ax.set_xscale('log')
ax.plot(x,fdbp,color="r")
ax.fill_between(x, fdbp+np.absolute(fdbperr), fdbp-np.absolute(fdbperr),alpha=0.5,facecolor="r")
plt.title("{0} bound proton PDF, PID = 1".format(boundppdf))
plt.xlabel("x")
plt.ylabel("xf")
#plt.ylim(-2,10)
plt.xlim(1e-3,1)
plt.savefig('/home/rosalyn/nuclear/PDFplots/{0}/{0}_d_plot'.format(boundppdf))
