# Nuclear_Corrections

This project is about the inclusion of nuclear corrections for fixed-target
experiments into a typical NNPDF fit.

Table of contents:
- Papers\\
  contains selected papers useful for this project
- LHAPDF_Production
  contains the code to generate appropriate LHAPDF grids fro the DSSZ and EPPS 
  nucler PDF sets
- MonteCarlo
  contains the code and the runcard to generate the Monte Carlo sets for each
  Hessian set of nuclear PDFs
- nPDFsets
  contains the nuclear PDF sets produced by the bits of code in 
  LHAPDF_PRoduction and MonteCarlo
- Observables
  contains the validphys folder to generate predictions - the NUCLEAR branch
  of the NNPDF code must be installed
- Covariance
  contains the code to generate the additional nuisance parameters associated 
  to the nuclear corrections
- Plotting_code
  contains the code that generates plots for the paper
- Strangeness_fraction
  contains th ecode to compute the ratios Rs and Ks 
