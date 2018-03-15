********************************************************************************
*                                                                              *
*     program check.f                                                          *
*                                                                              *
********************************************************************************

      program check
      implicit none

      integer iwrap, nwrap
      parameter(nwrap=2)
      integer iexp, nexp
      parameter(nexp=2)
      integer iset, nset
      parameter(nset=2)
      integer irep, nrep(nwrap), repdum, mxrep
      parameter(mxrep=300)
      integer ipt, npt(nexp,nset), mxpt
      parameter(mxpt=1000)
      integer idum

      double precision x(mxpt,nexp,nset), Q2(mxpt,nexp,nset)
      double precision thobs(nwrap,mxrep,nexp,nset,mxpt)
      double precision mean_p(nexp,nset,mxpt)

      character*100 wrapfile(nwrap,nexp)
      character*100 infile(nwrap,nexp,nset), outfile(nexp,nset)
      character*20  nameexp(nexp)
      character*20  nameset(nexp,nset)
      character*20  obs(nexp,nset)

*     Define wrapfiles
      wrapfile(1,1)="nCTEQ15_208_82_MC"
      wrapfile(1,2)="nCTEQ15_56_26_MC"
      wrapfile(2,1)="NNPDF31_nlo_pch_as_0118"
      wrapfile(2,2)="NNPDF31_nlo_pch_as_0118"

*     Initialise number of replicas in each set
      nrep(1)=1
      nrep(2)=1

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
     1              trim(wrapfile(iwrap,iexp)), ".res"

            enddo
            
         enddo

      enddo

*     Define output files
      do iexp=1, nexp

         do iset=1, nset

            write(outfile(iexp,iset),102)
     1           "res/SP_",
     1           trim(nameexp(iexp)),
     1           trim(nameset(iexp,iset)), ".res"

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
     1                    Q2(ipt,iexp,iset),
     1                    thobs(iwrap,irep,iexp,iset,ipt)

                  enddo
                 
               enddo
               
               close(10)

            enddo

         enddo

      enddo

*     Compute mean value (free proton PDFs)
      do iexp=1, nexp

         do iset=1, nset

            do ipt=1, npt(iexp,iset)

               mean_p(iexp,iset,ipt) = 0d0

               do irep=1, nrep(2)    !!!!!!change here

                  mean_p(iexp,iset,ipt) 
     1                 = mean_p(iexp,iset,ipt) 
     1                 + thobs(2,irep,iexp,iset,ipt)/nrep(2)  !!!!!!change here

               enddo

            enddo

         enddo

      enddo

*     Write results on file
      do iexp=1, nexp

         do iset=1, nset

            open(unit=20, status="unknown", file=outfile(iexp,iset))

            do ipt=1, npt(iexp,iset)

               do iwrap=1, nwrap-1

                  do irep=1, nrep(iwrap)

                     if(mean_p(iexp,iset,ipt).ne.0)then
                        write(20,103) ipt, 
     1                       x(ipt,iexp,iset), 
     1                       Q2(ipt,iexp,iset),
     1                       thobs(iwrap,irep,iexp,iset,ipt)/
     1                       mean_p(iexp,iset,ipt)
                     endif

                  enddo

               enddo

            enddo

            close(20)
            
         enddo

      enddo

 101  format(a,a,a,a,a,a)
 102  format(a,a,a,a)
 103  format(i4,4(f12.5))

      stop
      end
