********************************************************************************
*                                                                              *
*     program check_covariance                                                 *
*                                                                              *
********************************************************************************

      program checkcovariance
      implicit none

      integer iexp, nexp
      parameter(nexp=3)
      integer iset, nset(nexp), mxset
      parameter(mxset=2)
      integer i, idat, ndat(nexp,mxset), ndattot(nexp)
      integer mxentries
      parameter(mxentries=5000)
      integer idum
      integer nrepwrap
      parameter(nrepwrap=300)
      integer in, nn(nexp), nnmax
      parameter(nnmax=900)
      integer nwrap(nexp), mxwrap
      parameter(mxwrap=3)
      integer enum

      double precision cov_exp(nexp,mxentries,mxentries)
      double precision cov_tot_unc(nexp,mxentries,mxentries)
      double precision cov_tot_cor(nexp,mxentries,mxentries)    
      double precision cov_nuc_unc(nexp,mxentries,mxentries)
      double precision cov_nuc_cor(nexp,mxentries,mxentries)
      double precision np(nexp,mxset,mxentries,nnmax)
      double precision npexp(nexp,mxentries,nnmax)
      double precision eps
      parameter(eps=1d-10)
      
      character*20 nameexp(nexp), nameset(nexp,mxset)
      character*100 infile_NN(nexp,mxset)
      character*100 infile_CM_exp(nexp)
      character*100 infile_CM_tot_unc(nexp)
      character*100 infile_CM_tot_cor(nexp)
      character*30 cdum(mxentries), ccdum

*     Initialise number of sets
      nset(1)=2  !CHORUS
      nset(2)=2  !NUTEV
      nset(3)=1  !E605

*     Initialise number of datapoints
      ndat(1,1)=607
      ndat(1,2)=607
      ndat(2,1)=45
      ndat(2,2)=45
      ndat(3,1)=119

      do iexp=1, nexp
         ndattot(iexp)=0d0
         do iset=1, nset(iexp)
            ndattot(iexp) = ndattot(iexp) + ndat(iexp,iset)
         enddo
      enddo

*     Initialise experiments
      nameexp(1)="CHORUS"
      nameexp(2)="NTV"
      nameexp(3)="DYE605"

*     Initialise sets
      nameset(1,1)="NU"
      nameset(1,2)="NB"
      nameset(2,1)="NUDMN"
      nameset(2,2)="NBDMN"
      nameset(3,1)=""

*     Initialise nwrap
      nwrap(1)=3
      nwrap(2)=3
      nwrap(3)=2

*     Define infiles (nuisance parameters)
      do iexp=1, nexp
         
         do iset=1, nset(iexp)
            
            write(infile_NN(iexp,iset),102) "../res/NN_new_",
     1           trim(nameexp(iexp)),
     1           trim(nameset(iexp,iset)), ".res"
            
         enddo

      enddo

*     Define infiles (covariance matrices)
      do iexp=1, nexp
         
         write(infile_CM_exp(iexp),102) "../validphys/",
     1        trim(nameexp(iexp)), "/baseline/output/tables/",
     1        "experiments_covmat.csv"

         write(infile_CM_tot_unc(iexp),102) "../validphys/",
     1        trim(nameexp(iexp)), "/uncorr/output/tables/",
     1        "experiments_covmat.csv"

         write(infile_CM_tot_cor(iexp),102) "../validphys/",
     1        trim(nameexp(iexp)), "/corr/output/tables/",
     1        "experiments_covmat.csv"

      enddo

*     Read results from file (nuisance parameters)
      do iexp=1, nexp

         nn(iexp) = nrepwrap * nwrap(iexp)

         do iset=1, nset(iexp)

            open(unit=10, status="unknown", file=infile_NN(iexp,iset))
            
            do idat=1, ndat(iexp,iset)

               read(10,*) idum, (np(iexp,iset,idat,in), in=1, nn(iexp))

            enddo

            close(10)

         enddo

      enddo

*     Compute nuclear covariance matrix (uncorrelated)
      do iexp=1, nexp
         
         do idat=1, ndattot(iexp)

            do i=1, ndattot(iexp)

               cov_nuc_unc(iexp,idat,i) = 0d0

            enddo

         enddo
         
         enum=1

         do iset=1, nset(iexp)

            do idat=1, ndat(iexp,iset)
     
               do in=1, nn(iexp)
                  
                  npexp(iexp,enum,in)=np(iexp,iset,idat,in)

               enddo

               enum=enum+1

            enddo

         enddo
        
         do idat=1, ndattot(iexp)
            
            do in=1, nn(iexp)
               
               cov_nuc_unc(iexp,idat,idat) = cov_nuc_unc(iexp,idat,idat)
     1              + npexp(iexp,idat,in)**2d0
               
            enddo
            
         enddo
         
      enddo

*     Compute nuclear covariance matrix (correlated)
      do iexp=1, nexp
         
         do idat=1, ndattot(iexp)
            
            do i=1, ndattot(iexp)
               
               cov_nuc_cor(iexp,idat,i) = 0d0
               
            enddo
            
         enddo
         
         enum=1
         
         do iset=1, nset(iexp)
            
            do idat=1, ndat(iexp,iset)
               
               do in=1, nn(iexp)
                  
                  npexp(iexp,enum,in)=np(iexp,iset,idat,in)
                  
               enddo
               
               enum=enum+1
               
            enddo
            
         enddo
   
         do idat=1, ndattot(iexp)

            do i=1, ndattot(iexp)
               
               do in=1, nn(iexp)
                  
                  cov_nuc_cor(iexp,idat,i) = cov_nuc_cor(iexp,idat,i)
     1                 + npexp(iexp,idat,in)*npexp(iexp,i,in)
                  
               enddo
               
            enddo
            
         enddo
         
      enddo
      
*     Read results from file (covariance matrix)
      do iexp=1, nexp
         
         open(unit=10, status="old", file=trim(infile_CM_exp(iexp)))
         open(unit=20, status="old", file=trim(infile_CM_tot_unc(iexp)))
         open(unit=30, status="old", file=trim(infile_CM_tot_cor(iexp)))

         read(10,*) (cdum(i), i=1,1+ndattot(iexp))
         read(10,*) (cdum(i), i=1,1+ndattot(iexp))
         read(10,*) (cdum(i), i=1,1+ndattot(iexp))
         read(10,*) (cdum(i), i=1,3)

         read(20,*) (cdum(i), i=1,1+ndattot(iexp))
         read(20,*) (cdum(i), i=1,1+ndattot(iexp))
         read(20,*) (cdum(i), i=1,1+ndattot(iexp))
         read(20,*) (cdum(i), i=1,3)

         read(30,*) (cdum(i), i=1,1+ndattot(iexp))
         read(30,*) (cdum(i), i=1,1+ndattot(iexp))
         read(30,*) (cdum(i), i=1,1+ndattot(iexp))
         read(30,*) (cdum(i), i=1,3)
         
         do idat=1, ndattot(iexp)

            read(10,*) ccdum, ccdum, idum,
     1           (cov_exp(iexp,idat,i), i=1, ndattot(iexp))

            read(20,*) ccdum, ccdum, idum,
     1           (cov_tot_unc(iexp,idat,i), i=1, ndattot(iexp))

            read(30,*) ccdum, ccdum, idum,
     1           (cov_tot_cor(iexp,idat,i), i=1, ndattot(iexp))
            
         enddo

         close(10)
         close(20)
         close(30)

      enddo

*     Check zeroes (uncorrelated)
      do iexp=1, nexp
         
         write(*,103) "Checking experiment, uncorrelated: ", iexp

         do idat=1, ndattot(iexp)

            do i=1, ndattot(iexp)
               
               if(cov_tot_unc(iexp,idat,i) 
     1              - cov_exp(iexp,idat,i)
     1              - cov_nuc_unc(iexp,idat,i).ge.eps)then
                  write(*,*) "Non zero value found", 
     1                 " exp ", iexp,
     1                 " i "  , idat,
     1                 " i "  , i
                  write(*,104) "failed"
                  !call exit(-10)
               endif
               
            enddo 

         enddo

         write(*,104) "passed"

      enddo

*     Check zeroes (correlated)
      do iexp=1, nexp
         
         write(*,103) "Checking experiment, correlated: ", iexp

         do idat=1, ndattot(iexp)

            do i=1, ndattot(iexp)
               
               if(cov_tot_cor(iexp,idat,i) 
     1              - cov_exp(iexp,idat,i)
     1              - cov_nuc_cor(iexp,idat,i).ge.eps)then
                  write(*,*) "Non zero value found", 
     1                 " exp ", iexp,
     1                 " i "  , idat,
     1                 " i "  , i
                  write(*,104) "failed"
                  !call exit(-10)
               endif
               
            enddo 

         enddo

         write(*,104) "passed"

      enddo
      
 102  format(a,a,a,a)
 103  format(a,i2)
 104  format(a)

      stop
      end
