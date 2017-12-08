#! /usr/bin/env python
 
import lhapdf
import numpy as np
import sys
import matplotlib.pyplot as plt

# Reading in command line arguments of PDF set, PID and Q (GeV). 
# E.g. write "genpdf.py CT14nlo 21 10" to run 

pdfset = str(sys.argv[1]) 
pid= int(sys.argv[2])
q = float(sys.argv[3]) 

# Reading in PDF sets
p = lhapdf.mkPDF(pdfset, 0)
pset = lhapdf.getPDFSet(pdfset)
pdfs2 = lhapdf.mkPDFs(pdfset)

# Generating PDFs member by member and writing them to an array 
N=len(pdfs2)
xs = [x for x in np.logspace(-4, 0, 100)]
f = np.empty([N,len(xs)])

for k in range(N):
    for ix, x in enumerate(xs):
        f[k,ix] = pdfs2[k].xfxQ(pid, x, q)

# Calculating Hessian errors 
npair = int((N-1)/2)
fdiff=np.zeros([npair,len(xs)])

for i in range(0,npair):
    fdiff[i]=f[i+1]-f[i+npair+1]
fdiff_sq=np.square(fdiff)
fdiff_sq_sum=np.zeros([len(xs)])
for i in range(len(xs)):
    fdiff_sq_sum[i]=np.sum(fdiff_sq[:,i])
errors=0.5*np.sqrt(fdiff_sq_sum)

with open('../res/{0}/data_{1}_{0}.txt'.format(pdfset,pid), 'w') as output:
    for index in range(len(xs)):
         	output.write(str(xs[index]) + "\t" + str(f[0,index]) + "\t" + str(errors[index]) + "\n")


# Now to plot central pdf with errors
fig=plt.figure()
ax = fig.add_subplot(111)
ax.set_xscale('log')
ax.plot(xs,f[0],errors)
ax.fill_between(xs, f[0]+np.absolute(errors), f[0]-np.absolute(errors),alpha=0.5,facecolor="turquoise")
plt.title("{0} PID = {1} Q = {2} GeV".format(pdfset, pid, q))
plt.xlabel("x")
plt.ylabel("xf")
#plt.ylim(-2,10)
plt.xlim(1e-3,1)
plt.savefig('../plots/{0}/{0}_{1}_plot'.format(pdfset,pid))

