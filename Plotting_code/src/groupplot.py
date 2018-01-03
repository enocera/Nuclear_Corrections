import numpy as np
import re
import sys
import glob
import matplotlib.pyplot as plt
from matplotlib import rc

# Create dictionary for dynamic variable assignment
dict = {}

# Reading in command line arguments
pid = int(sys.argv[1])
q = float(sys.argv[2])

print(sys.argv[3:])
print(range(len(sys.argv[3:])))

print("--------------------------------" + "\n")
print("The PDF sets being plotted are:" + "\n")
print("--------------------------------" + "\n")
for i in range(len(sys.argv[3:])):
    print("pdfset_{0} = ".format(i))
    dict["pdfset_{0}".format(i)]=str(sys.argv[i+3])
    print(str(sys.argv[i+3]) + "\n")

# Need to remove decimal place for the Q appearing in filenames 
qstring=str(q)
qstring=qstring.replace(".","p")

# Getting data
print("----------------------" + "\n")
print("Loading data" + "\n")
print("----------------------" + "\n")
for i in range(len(sys.argv[3:])):
    print("pdfset_{0}".format(i))
    filenames = glob.glob('../res/{0}/ratio_{1}_{0}*q{2}.txt'.format(dict["pdfset_{0}".format(i)],pid,qstring))
    print("Files to be plotted:")
    print(filenames)
    if len(filenames)>1:
        print("Ambiguity in loading data")
        sys.exit()
    else: 
        x,dict["r_{0}".format(i)],dict["rerr_{0}".format(i)]=np.loadtxt(filenames[0], unpack=True)
        print("Data loaded")

#for index in range(len(x)):
#    print(str(x[index]) + "\t" + str(dict["r_1"][index]) + "\t" + str(dict["rerr_1"][index]) + "\n")

# Plotting
fig=plt.figure()
for i in range(len(sys.argv[3:])):
    dict["ax_{0}".format(i)] = fig.add_subplot(111)
    dict["ax_{0}".format(i)].set_xscale('log')
    dict["ax_{0}".format(i)].plot(x,dict["r_{0}".format(i)], label=dict["pdfset_{0}".format(i)])
    dict["ax_{0}".format(i)].fill_between(x,dict["r_{0}".format(i)]+np.absolute(dict["rerr_{0}".format(i)]), dict["r_{0}".format(i)]-np.absolute(dict["rerr_{0}".format(i)]),alpha=0.5)
plt.legend()
plt.title("Ratios for PID={0} and Q={1} GeV".format(pid,q))
plt.xlabel("x")
plt.ylabel("R")
plt.ylim(0,1.8)
plt.xlim(1e-3,1)
plt.savefig('../plots/groupratio_{0}_q{1}'.format(pid,qstring))

