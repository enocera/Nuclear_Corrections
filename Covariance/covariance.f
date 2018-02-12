********************************************************************************
*                                                                              *
*     covariance.f                                                             *
*                                                                              *
********************************************************************************

      program covariance
      implicit none


      integer iwrap, nwrap
      parameter(nwrap=7)
      integer iexp, nexp
      parameter(nexp=2)
      integer iset, nset
      parameter(nset=2)
      integer irep, nrep(nwrap), repdum, mxrep
      parameter(mxrep=250)
      integer ipt, npt(nexp,nset), mxpt
      parameter(mxpt=1000)
      integer idum

      double precision x(mxpt,nexp,nset)
      double precision thobs(nwrap,mxrep,nexp,nset,mxpt)
      double precision mean_p(nexp,nset,mxpt)

      character*100 wrapfile(nwrap), infile(nwrap,nexp,nset)
      character*20  nameexp(nexp)
      character*20  nameset(nexp,nset)
      character*20  obs(nexp,nset)

*     Define wrapfiles
      wrapfile(1)="DSSZ_NLO_Fe56_MC_1000_compressed_250"
      wrapfile(2)="DSSZ_NLO_Pb208_MC_1000_compressed_250"
      wrapfile(3)="EPPS16nlo_CT14nlo_Fe56_MC_1000_compressed_250"
      wrapfile(4)="EPPS16nlo_CT14nlo_Pb208_MC_1000_compressed_250"
      wrapfile(5)="nCTEQ15FullNuc_208_82_MC_1000_compressed_250"
      wrapfile(6)="nCTEQ15FullNuc_56_26_MC_1000_compressed_250"
      wrapfile(7)="NNPDF31_nlo_pch_as_0118"

*     Initialise number of replicas in each set
      nrep(1)=250
      nrep(2)=250
      nrep(3)=250
      nrep(4)=250
      nrep(5)=250
      nrep(6)=250
      nrep(7)=100

*     Initialise experiments
      nameexp(1)="CHORUS"
      nameexp(2)="NTV"

*     Initialise sets
      nameset(1,1)="NU"
      nameset(1,2)="NB"
      nameset(2,1)="NUDMN"
      nameset(2,2)="NBDMN"

*     Define input files
      do iwrap=1, nwrap

         do iexp=1, nexp
            
            do iset=1, nset
               
               write(infile(iwrap,iexp,iset),101) 
     1              "../Observables/res/OBS_",
     1              trim(nameexp(iexp)),
     1              trim(nameset(iexp,iset)), "_",
     1              trim(wrapfile(iwrap)), ".res"
               
            enddo
            
         enddo

      enddo

*     Read data from files
      do iwrap=1, nwrap

         do iexp=1, nexp

            do iset=1, nset

               open(unit=10, status="old", file=infile(iwrap,iexp,iset))

               read(10,*) obs(iexp,iset),  npt(iexp,iset)
               
               do irep=1, nrep(iwrap)

                  read(10,*) repdum

                  do ipt=1, npt(iexp,iset)

                     read(10,*) idum, x(ipt,iexp,iset),
     1                    thobs(iwrap,irep,iexp,iset,ipt)

                  enddo
                 
               enddo
               
               close(10)

            enddo

         enddo

      enddo

*     Compute mean value
      do iexp=1, nexp

         do iset=1, nset

            do ipt=1, npt(iexp,iset)

               mean_p(iexp,iset,ipt) = 0d0

               do irep=1, nrep(7)

                  mean_p(iexp,iset,ipt) 
     1                 = mean_p(iexp,iset,ipt) 
     1                 + thobs(7,irep,iexp,iset,ipt)/nrep(7)

               enddo

            enddo

         enddo

      enddo

*     Compute covariance matrix
      



 101  format(a,a,a,a,a,a)

      stop
      end
