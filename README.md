# Nuclear_Corrections

This project is about the inclusion of nuclear corrections for fixed-target
experiments into a typical NNPDF fit.

## Table of contents
- Papers

  contains selected papers useful for this project
- LHAPDF_Production

  contains the code to generate appropriate LHAPDF grids for the DSSZ and EPPS 
  nuclear PDF sets
- MonteCarlo

  contains the code and the runcard to generate the Monte Carlo sets for each
  Hessian set of nuclear PDFs
- nPDFsets

  contains the nuclear PDF sets produced by the bits of code in 
  LHAPDF_Production and MonteCarlo
- Observables

  contains the validphys folder to generate predictions - the NUCLEAR branch
  of the NNPDF code must be installed
- Covariance

  contains the code to generate the additional nuisance parameters associated 
  to the nuclear corrections
- Plotting_code

  contains the code that generates plots for the paper
- Strangeness_fraction

  contains the code to compute the ratios Rs and Ks 

## Workflow

- Generate the appropriate Hessian grids for the nuclear PDF sets not available
  in the proper LHAPDF format by running the code in LHAPDF_Production.

- Generate the appropriate Monte Carlo sets for the nuclear PDF sets in the 
  LHAPDF format by running the code in MonteCarlo

- For convenience, the nuclear PDF sets generated above are stored in nPDFsets.
  Please consider to skip the two first steps in this list and just copy these 
  LHAPDF grids into your local LHAPDF intallation path.

- Compute the observables for the nuclear experiments by running the code in 
  Observables/validphys/<nPDFset> for each <nPDFset>. A complete installation
  of nnpdf and validphys is required.

- Compute the nuisance parameters associated to the extra nuclear uncertainties
  and/or the shifts by running nuisance_new and Nuisancenucl_new in 
  Covariance/src. 

- The output of the previous point is implemented in the NUCLEAR branch of 
  buildmaster and in the NUCLEAR branch of nnpdf.

- Compute (and check) the nuclear covariance matrix (uncorrelated and 
  correlated) by running check_covariance in Covariance/src.

- Postprocess the results by running the code in Plotting_code.
