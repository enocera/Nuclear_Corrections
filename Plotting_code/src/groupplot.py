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

#for index in range(len(x)):
#    print(str(x[index]) + "\t" + str(dict["r_1"][index]) + "\t" + str(dict["rerr_1"][index]) + "\n")

# Creating legend labels of shorter PDF names for plotting
for i in range(len(sys.argv[3:])):
    dict["pdflabel_{0}".format(i)] = dict["pdfset_{0}".format(i)].split("1")[0].split("_")[0]

dict["parton_1"] = "d"
dict["parton_-1"] = "d bar"
dict["parton_2"] = "u"
dict["parton_-2"] = "u bar"
dict["parton_3"] = "s"
dict["parton_-3"] = "s bar"
dict["parton_21"] = "g"

fig=plt.figure()
for i in range(len(sys.argv[3:])):
    dict["ax_{0}".format(i)] = fig.add_subplot(111)
    dict["ax_{0}".format(i)].set_xscale('log')
    dict["ax_{0}".format(i)].plot(x,dict["r_{0}".format(i)], label=dict["pdflabel_{0}".format(i)])
    dict["ax_{0}".format(i)].fill_between(x,dict["r_{0}".format(i)]+np.absolute(dict["rerr_{0}".format(i)]), dict["r_{0}".format(i)]-np.absolute(dict["rerr_{0}".format(i)]),alpha=0.5)
plt.legend()
#plt.title("".format(pid,q))
plt.xlabel("x")
plt.ylabel("x{0}(x)".format(dict["parton_{0}".format(pid)]))
if pid == 21:
    plt.ylim(0,20)
else:
    plt.ylim(0,1)
plt.xlim(1e-3,1)
plt.savefig('../plots/groupdata{0}{1}_q{2}'.format(pdfstring,pid,qstring))

