********************************************************************************
*                                                                              *
*     nuisancenucl.f                                                           *
*     This program computes shifts due to nuclear uncertainties                *
*     Input from ../../theory/validphys                                        *
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
      double precision thobsprot(0:nrepbase,nexp,mxset,mxpt)
      double precision mean_n(nexp,mxset,mxpt)

      character*20 nameexp(nexp), nameset(nexp,mxset)
      character*100 wrapfile(nexp,mxwrap), basefile
      character*100 infilewrap(nexp,mxwrap), infilebase
      character*100 outfile(nexp,mxset)
      character*20 cdum(mxdum), ccdum

*     Initialise nset
      nset(1)=2   !CHORUS
      nset(2)=2   !NUTEV
      nset(3)=1   !E605

*     Initialise ndat
      npt(1,1)=416
      npt(1,2)=416
      npt(2,1)=39
      npt(2,2)=37
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
     1           "../theory/validphys/", 
     1           trim(wrapfile(iexp,iwrap)),
     1           "/output/tables/experiment_result_table.csv"
            write(infilebase,101)
     1           "../theory/validphys/",trim(basefile),
     1           "/output/tables/experiment_result_table.csv"
         enddo
      enddo

*     Define output files
      do iexp=1, nexp
         do iset=1, nset(iexp)
            write(outfile(iexp,iset),102) "../res/shifts_new_",
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

*     Write results on file
      do iexp=1, nexp
         nn(iexp) = nrepwrap * nwrap(iexp)
         do iset=1, nset(iexp)
            open(unit=40, status="unknown", file=outfile(iexp,iset))
            do ipt=1, npt(iexp,iset)
               write(40,103) ipt,
     1              mean_n(iexp,iset,ipt) - thobsprot(0,iexp,iset,ipt)
            enddo
            close(40) 
         enddo
      enddo

 101  format(a,a,a)
 102  format(a,a,a,a)
 103  format(i5,f10.5)

      stop
      end
