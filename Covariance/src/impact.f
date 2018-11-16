********************************************************************************
*                                                                              *
*     program impact                                                           *
*     This program computes the diagonal elements of the covariance            *
*     matrix and divide them by the central value of the experimental          *
*     measurement. This is done both for def1 and def2 (with shifts)           *
*                                                                              *
*     Input:                                                                   *
*     - covariance matrices in ../validphys/<name_exp>/corr(shift)/output      *
*     - data sets in ../../Data/commondata/<DATA_name>                         *
*                                                                              *
*     Output:                                                                  *
*     - ../res/def1.res                                                        *
*     - ../res/def2.res                                                        *
*                                                                              *
********************************************************************************

      program impact
      implicit none

      integer iexp, nexp
      parameter(nexp=3)
      integer iset, nset(nexp), mxset
      parameter(mxset=2)
      integer idef, ndef
      parameter(ndef=2)
      integer idum
      integer idat, jdat, ndat(nexp,mxset), mxdat
      parameter(mxdat=1000)

      double precision exp_cv(ndef,nexp,mxset,mxdat)
      double precision cov_tot(ndef,nexp,mxset,mxdat,mxdat)
      double precision cov_exp(nexp,mxset,mxdat,mxdat)
      double precision ddum

      character*100 infiledat(nexp,mxset,ndef)
      character*100 infilecov(nexp,ndef), infilecov_exp(nexp)
      character*100 outfile(nexp,mxset,ndef)
      character*10 cdum

*     Define number of sets in each experiment
      nset(1) = 2
      nset(2) = 2
      nset(3) = 1

*     Define input files with experimental data
      infiledat(1,1,1) = "../../Data/commondata/DATA_CHORUSNU.dat"
      infiledat(1,2,1) = "../../Data/commondata/DATA_CHORUSNB.dat"
      infiledat(2,1,1) = "../../Data/commondata/DATA_NTVNUDMN.dat"
      infiledat(2,2,1) = "../../Data/commondata/DATA_NTVNBDMN.dat"
      infiledat(3,1,1) = "../../Data/commondata/DATA_DYE605.dat"

      infiledat(1,1,2) = "../../Data/commondata/"//
     1     "DATA_CHORUSNUnuclshift.dat"
      infiledat(1,2,2) = "../../Data/commondata/"//
     1     "DATA_CHORUSNBnuclshift.dat"
      infiledat(2,1,2) = "../../Data/commondata/"//
     1     "DATA_NTVNUDMNnuclshift.dat"
      infiledat(2,2,2) = "../../Data/commondata/"//
     1     "DATA_NTVNBDMNnuclshift.dat"
      infiledat(3,1,2) = "../../Data/commondata/"//
     1     "DATA_DYE605nuclshift.dat"

*     Define input files with covariance matrices
      infilecov(1,1) = "../validphys/CHORUS/corr/output/tables/"//
     1     "experiments_covmat.csv"
      infilecov(2,1) = "../validphys/NTV/corr/output/tables/"//
     1     "experiments_covmat.csv"
      infilecov(3,1) = "../validphys/DYE605/corr/output/tables/"//
     1     "experiments_covmat.csv"
      infilecov(1,2) = "../validphys/CHORUS/corrshift/output/tables/"//
     1     "experiments_covmat.csv"
      infilecov(2,2) = "../validphys/NTV/corrshift/output/tables/"//
     1     "experiments_covmat.csv"
      infilecov(3,2) = "../validphys/DYE605/corrshift/output/tables/"//
     1     "experiments_covmat.csv"

      infilecov_exp(1) = "../validphys/CHORUS/baseline/output/tables/"//
     1     "experiments_covmat.csv"
      infilecov_exp(2) = "../validphys/NTV/baseline/output/tables/"//
     1     "experiments_covmat.csv"
      infilecov_exp(3) = "../validphys/DYE605/baseline/output/tables/"//
     1     "experiments_covmat.csv"

*     Define output files
      outfile(1,1,1)="../res/covplot_CHORUSNUnucl.res"
      outfile(1,2,1)="../res/covplot_CHORUSNBnucl.res"
      outfile(2,1,1)="../res/covplot_NTVNUDMNnucl.res"
      outfile(2,2,1)="../res/covplot_NTVNBDMNnucl.res"
      outfile(3,1,1)="../res/covplot_DYE605nucl.res"
      outfile(1,1,2)="../res/covplot_CHORUSNUnuclshift.res"
      outfile(1,2,2)="../res/covplot_CHORUSNBnuclshift.res"
      outfile(2,1,2)="../res/covplot_NTVNUDMNnuclshift.res"
      outfile(2,2,2)="../res/covplot_NTVNBDMNnuclshift.res"
      outfile(3,1,2)="../res/covplot_DYE605nuclshift.res"

*     Read experimental data from commondata files
      do idef=1, ndef
         do iexp=1, nexp        
            do iset=1, nset(iexp)
               open(unit=10, status="old", 
     1              file=trim(infiledat(iexp,iset,idef)))
               read(10,*) cdum, idum, ndat(iexp,iset)
               do idat=1, ndat(iexp,iset)
                  read(10,*) idum, cdum, ddum, ddum, ddum, 
     1                 exp_cv(idef,iexp,iset,idat)
               enddo
               close(10)
            enddo
          enddo
      enddo

*     Read total covariance matrix
      do idef=1, ndef
         do iexp=1, nexp
            open(unit=20, status="old", file=trim(infilecov(iexp,idef)))
            read(20,*) cdum
            read(20,*) cdum
            read(20,*) cdum
            read(20,*) cdum         
            do iset=1, nset(iexp)
               do idat=1,ndat(iexp,iset)
                  if(iset.eq.1)then
                     read(20,*) cdum, cdum, idum, 
     1                    (cov_tot(idef,iexp,iset,idat,jdat), 
     1                    jdat=1,ndat(iexp,iset))
                     elseif(iset.eq.2)then
                        read(20,*) cdum, cdum, idum,
     1                       (ddum, jdat=1,ndat(iexp,iset)),
     1                       (cov_tot(idef,iexp,iset,idat,jdat), 
     1                       jdat=1,ndat(iexp,iset))
                     endif

               enddo
            enddo
            close(20)
         enddo
      enddo

*     Read experimental covariance matrix
      do iexp=1, nexp
         open(unit=20, status="old", file=trim(infilecov_exp(iexp)))
         read(20,*) cdum
         read(20,*) cdum
         read(20,*) cdum
         read(20,*) cdum         
         do iset=1, nset(iexp)
            do idat=1,ndat(iexp,iset)
               if(iset.eq.1)then
                  read(20,*) cdum, cdum, idum, 
     1                 (cov_exp(iexp,iset,idat,jdat), 
     1                 jdat=1,ndat(iexp,iset))
               elseif(iset.eq.2)then
                  read(20,*) cdum, cdum, idum,
     1                 (ddum, jdat=1,ndat(iexp,iset)),
     1                 (cov_exp(iexp,iset,idat,jdat), 
     1                 jdat=1,ndat(iexp,iset))
               endif
            enddo
         enddo
         close(20)
      enddo
 
*     Compute relevant output information
      do idef=1, ndef
         do iexp=1, nexp
            do iset=1, nset(iexp)
               open(unit=30, status="unknown", 
     1              file=trim(outfile(iexp,iset,idef)))
               do idat=1, ndat(iexp,iset)
                  write(30,101) idat, 
     1                 dsqrt(cov_exp(iexp,iset,idat,idat))/
     1                 exp_cv(idef,iexp,iset,idat),   
     1                 dsqrt(dabs(cov_tot(idef,iexp,iset,idat,idat)-
     1                 cov_exp(iexp,iset,idat,idat)))/
     1                 exp_cv(idef,iexp,iset,idat), 
     1                 dsqrt(cov_exp(iexp,iset,idat,idat)
     1                 + dabs(cov_tot(idef,iexp,iset,idat,idat)-
     1                 cov_exp(iexp,iset,idat,idat)))/
     1                 exp_cv(idef,iexp,iset,idat)
               enddo
               close(30)
            enddo
         enddo
      enddo

 101  format(i4,3(f12.7))

      stop
      end

********************************************************************************
