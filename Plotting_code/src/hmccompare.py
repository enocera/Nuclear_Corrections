import numpy as np
import re
import sys
import glob
import matplotlib.pyplot as plt
from matplotlib import rc
# The Hessian set must always be the first set inputted in the command line
# Create dictionary for dynamic variable assignment
dict = {}

# Reading in command line arguments
pid = int(sys.argv[1])
q = float(sys.argv[2])

# Creating a string of all the PDF sets for inclusion in filename
pdfstring = "_"

print("--------------------------------")
print("The PDF sets being plotted are:")
print("--------------------------------")
for i in range(len(sys.argv[3:])):
    print("pdfset_{0} = ".format(i))
    dict["pdfset_{0}".format(i)]=str(sys.argv[i+3])
    pdfstring = pdfstring + dict["pdfset_{0}".format(i)] + "_"
    print(str(sys.argv[i+3]) + "\n")
print("pdfstring=" + pdfstring)
# Need to remove decimal place for the Q appearing in filenames
qstring=str(q)
qstring=qstring.replace(".","p")

# Getting data
print("----------------------")
print("Loading data")
print("----------------------")
for i in range(len(sys.argv[3:])):
    print("pdfset_{0}".format(i))
    filenames = glob.glob('../res/{0}/data_{1}_{0}*q{2}.txt'.format(dict["pdfset_{0}".format(i)],pid,qstring))
    print("Files to be plotted:")
    print(filenames)
    if len(filenames)>1:
        print("Ambiguity in loading data")
        sys.exit()
    else:
        x,dict["r_{0}".format(i)],dict["rerr_{0}".format(i)]=np.loadtxt(filenames[0], unpack=True)
        print("Data loaded")
# Scaling down the Hessian errors from 90% to 68% confidence.
#The Hessian set must always be the first set inputted.
# Only EPPS and nCTEQ need rescaling (REMEMBER TO CHECK ABOUT HKN LATER)
if "EPPS" in pdfstring:
    dict["rerr_0"]=dict["rerr_0"]/1.65
    print("--------------------------" + "\n" + "Rescaled Hessian errors from 90% to 68% confidence" +"\n" +"--------------------------")
elif "nCTEQ" in pdfstring:
    dict["rerr_0"]=dict["rerr_0"]/1.65
    print("--------------------------" + "\n" + "Rescaled Hessian errors from 90% to 68% confidence" +"\n" +"--------------------------")
else:
    print("--------------------------" + "\n""Hessian errors already at 68% confidence" +"\n" +"--------------------------")

#for index in range(len(x)):
#    print(str(x[index]) + "\t" + str(dict["r_1"][index]) + "\t" + str(dict["rerr_1"][index]) + "\n")
#print("r_0=" + str(dict["r_0"]))
# Plotting
fig=plt.figure()
for i in range(len(sys.argv[3:])):
    dict["ax_{0}".format(i)] = fig.add_subplot(111)
    dict["ax_{0}".format(i)].set_xscale('log')
    dict["ax_{0}".format(i)].plot(x[:-1],dict["r_{0}".format(i)][:-1]/dict["r_0"][:-1], label=dict["pdfset_{0}".format(i)])
    dict["ax_{0}".format(i)].fill_between(x[:-1],(dict["r_{0}".format(i)][:-1]+np.absolute(dict["rerr_{0}".format(i)][:-1]))/dict["r_0"][:-1], (dict["r_{0}".format(i)][:-1]-np.absolute(dict["rerr_{0}".format(i)][:-1]))/dict["r_0"][:-1],alpha=0.5)
plt.legend()
plt.title("PID={0} and Q={1} GeV".format(pid,q))
plt.xlabel("x")
plt.ylabel("xf normalised to Hessian")
#plt.ylim(0,1.8)
plt.xlim(1e-3,1)
plt.savefig('../plots/hmc/hmc{0}{1}_q{2}'.format(pdfstring,pid,qstring))
