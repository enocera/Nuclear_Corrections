********************************************************************************
*                                                                              *
*     nuisancenucl.f                                                           *
*     This program computes the nuisance values due to nuclear uncertainties   *
*     and the corresponding shifts to be applied to the data                   *
*     Input from ../../Observables/validphys                                   *
*     Output to ../res/NNnucl_new_[nameexp][nameset].res                       *
*               ../res/shifts_new_[nameexp][nameset].res                       *
*                                                                              *
********************************************************************************

      program nuisancenucl
      implicit none

      integer iexp, nexp
      parameter(nexp=3)
      integer iset, nset(nexp), mxset
      parameter(mxset=2)
      integer iwrap, nwrap(nexp), mxwrap
      parameter(mxwrap=3)
      integer irep, nrepwrap, nrepbase
      parameter(nrepwrap=300,nrepbase=100)
      integer idum, mxdum
      parameter(mxdum=500)
      integer ipt, npt(nexp,mxset), mxpt
      parameter(mxpt=1000)
      integer in, nn(nexp), nnmax
      parameter(nnmax=900)

      double precision ddum
      double precision thexp(mxwrap,nexp,mxset,mxpt)
      double precision thobsnucl(mxwrap,nrepwrap+1,nexp,mxset,mxpt)
      double precision thobsprot(nrepbase+1,nexp,mxset,mxpt)
      double precision mean_p(nexp,mxset,mxpt)
      double precision mean_n(nexp,mxset,mxpt)
      double precision np(nexp,mxset,mxpt,nnmax)

      character*20 nameexp(nexp), nameset(nexp,mxset)
      character*100 wrapfile(nexp,mxwrap), basefile
      character*100 infilewrap(nexp,mxwrap), infilebase
      character*100 outfile1(nexp,mxset)
      character*100 outfile2(nexp,mxset)
      character*100 outfile3(nexp,mxset)
      character*20 cdum(mxdum), ccdum

*     Initialise nset
      nset(1)=2   !CHORUS
      nset(2)=2   !NUTEV
      nset(3)=1   !E605

*     Initialise ndat
      npt(1,1)=607
      npt(1,2)=607
      npt(2,1)=45
      npt(2,2)=45
      npt(3,1)=119

*     Initialise nwrap
      nwrap(1)=3
      nwrap(2)=3
      nwrap(3)=2

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

*     Initialise wrapfiles
      wrapfile(1,1)="EPPS16nlo_CT14nlo_Pb208_MC"
      wrapfile(1,2)="nCTEQ15_208_82_MC"
      wrapfile(1,3)="DSSZ_NLO_Pb208_MC"
      wrapfile(2,1)="EPPS16nlo_CT14nlo_Fe56_MC"
      wrapfile(2,2)="nCTEQ15_56_26_MC"
      wrapfile(2,3)="DSSZ_NLO_Fe56_MC"
      wrapfile(3,1)="EPPS16nlo_CT14nlo_Cu64_MC"
      wrapfile(3,2)="nCTEQ15_64_32_MC"
      basefile="NNPDF31_nlo_pch_as_0118"

*     Define input files
      do iexp=1, nexp

         do iwrap=1, nwrap(iexp)

            write(infilewrap(iexp,iwrap),101)
     1           "../../Observables/validphys/", 
     1           trim(wrapfile(iexp,iwrap)),
     1           "/output/tables/experiment_result_table.csv"
            write(infilebase,101)
     1           "../../Observables/validphys/",trim(basefile),
     1           "/output/tables/experiment_result_table.csv"

         enddo

      enddo

*     Define output files
      do iexp=1, nexp

         do iset=1, nset(iexp)

            write(outfile1(iexp,iset),102) "../res/NNnucl_new_",
     1           trim(nameexp(iexp)),
     1           trim(nameset(iexp,iset)), ".res"

            write(outfile2(iexp,iset),102) "../res/shifts_new_",
     1           trim(nameexp(iexp)),
     1           trim(nameset(iexp,iset)), ".res"

            write(outfile3(iexp,iset),102) "../res/shifts_ratios_",
     1           trim(nameexp(iexp)),
     1           trim(nameset(iexp,iset)), ".res"

         enddo

      enddo

*     Read data from files (free proton)
      open(unit=20, status="old", file=infilebase)

      read(20,*) (cdum(idum), idum=1,5+nrepbase)

      do iexp=1, nexp

         do iset=1, nset(iexp)

            do ipt=1, npt(iexp,iset)

               read(20,*) ccdum, ccdum, idum, ddum,
     1              (thobsprot(irep,iexp,iset,ipt), irep=0, nrepbase)

            enddo
            
         enddo

      enddo

      close(20)

*     Read data from files (nuclear)
      do iexp=1, nexp

         do iwrap=1, nwrap(iexp)

            open(unit=10, status="old", file=infilewrap(iexp,iwrap))

            read(10,*) (cdum(idum), idum=1,5+nrepwrap)

            do iset=1, nset(iexp)

               do ipt=1, npt(iexp,iset)
                  
                  read(10,*) ccdum, ccdum, idum, 
     1                 thexp(iwrap,iexp,iset,ipt),
     1                 (thobsnucl(iwrap,irep,iexp,iset,ipt), 
     1                 irep=0, nrepwrap)

               enddo

            enddo

            close(10)

         enddo

      enddo

*     Compute mean value (free proton PDFs)
      do iexp=1, nexp

         do iset=1, nset(iexp)

            do ipt=1, npt(iexp,iset)

               mean_p(iexp,iset,ipt) = 0d0

               do irep=1, nrepbase

                  mean_p(iexp,iset,ipt) 
     1                 = mean_p(iexp,iset,ipt) 
     1                 + thobsprot(irep,iexp,iset,ipt)/nrepbase

               enddo 

            enddo

         enddo

      enddo

*     Compute mean value (nuclear PDFs)
      do iexp=1, nexp

         do iset=1, nset(iexp)

            do ipt=1, npt(iexp,iset)

               mean_n(iexp,iset,ipt) = 0d0   

               do iwrap=1, nwrap(iexp)

                  do irep=1, nrepwrap
                     
                     in = irep + nrepwrap*(iwrap-1)

                     mean_n(iexp,iset,ipt) 
     1                    = mean_n(iexp,iset,ipt)
     1                    + thobsnucl(iwrap,irep,iexp,iset,ipt) 
     1                    / dble( nwrap(iexp) * nrepwrap )
                                     
                  enddo

               enddo
               
            enddo
            
         enddo

      enddo

*     Compute nuisance parameters
      do iexp=1, nexp

         do iset=1, nset(iexp)

            do ipt=1, npt(iexp,iset)
               
               do iwrap=1, nwrap(iexp)
                  
                  do irep=1, nrepwrap
                     
                     in = irep + nrepwrap*(iwrap-1)

                     np(iexp,iset,ipt,in) 
     1                    = ( thobsnucl(iwrap,irep,iexp,iset,ipt) 
     1                    - mean_n(iexp,iset,ipt) )
     1                    / dsqrt(dble( nwrap(iexp) * nrepwrap ))
                     
                  enddo
                  
               enddo
               
            enddo
            
         enddo
         
      enddo

*     Write results on file
      do iexp=1, nexp

         nn(iexp) = nrepwrap * nwrap(iexp)

         do iset=1, nset(iexp)

            open(unit=30, status="unknown", file=outfile1(iexp,iset))
            open(unit=40, status="unknown", file=outfile2(iexp,iset))
            open(unit=50, status="unknown", file=outfile3(iexp,iset))

            do ipt=1, npt(iexp,iset)

               write(30,103) ipt, (np(iexp,iset,ipt,in), in=1, nn(iexp))
               write(40,103) ipt,
     1              mean_n(iexp,iset,ipt) - mean_p(iexp,iset,ipt)

               write(50,103) ipt,
     1             mean_p(iexp,iset,ipt) / mean_n(iexp,iset,ipt) 
               
            enddo

            write(50,103) npt(iexp,iset)+1,
     1             mean_p(iexp,iset,npt(iexp,iset)) 
     1           / mean_n(iexp,iset,npt(iexp,iset)) 

            close(30)
            close(40)
            close(50)
            
         enddo

      enddo

 101  format(a,a,a)
 102  format(a,a,a,a)
 103  format(i4,900(f10.5))

      stop
      end
