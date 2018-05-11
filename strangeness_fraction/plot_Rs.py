#! /usr/bin/env python

import matplotlib.pyplot as plt

# Data for plotting
labels         = ["NNPDF3.0",
                  "NNPDF3.1",
                  "NNPDF3.1 calculated by me",
                  "NNPDF3.1 collider-only",
                  "NNPDF3.1 HERA + ATLAS W,Z",
                  "xFitter HERA + ATLAS W,Z",
                  "NNPDF3.1 debugged NUTEV",
                  "NNPDF3.1 debugged NUTEV + nuclear corr"]

Rs              = [0.45, 0.59, 0.60, 0.82, 1.03, 1.13, 0.68, 0.70]
Rserror         = [0.09, 0.12, 0.14,  0.18, 0.38, 0.11, 0.14, 0.15]
x               = [8, 7, 6, 5, 4, 3, 2, 1]

plt.errorbar(Rs,x, xerr=Rserror, fmt="ro")

plt.yticks(x, labels)
plt.margins(0.2)
plt.subplots_adjust(left=0.5)
plt.show()
