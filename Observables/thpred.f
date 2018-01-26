********************************************************************************
*                                                                              *
*     program thpred                                                           *
*                                                                              *
********************************************************************************

      program thpred
      implicit none

      integer iexp, nexp
      parameter(nexp=2)
      integer iset, nset
      parameter(nset=2)
      integer ipt, npt(nexp,nset), mxpt
      parameter(mxpt=1000)
      integer irep, nrep, mxrep
      parameter(mxrep=1000)
      integer idum
      integer ptord, nflmax
      integer nsys

      double precision x(mxpt,nexp,nset), y(mxpt,nexp,nset)
      double precision Q2(mxpt,nexp,nset), Q(mxpt,nexp,nset), Q0
      double precision alphaQCDref, QalphaQCDref
      double precision alphaQEDref, QalphaQEDref
      double precision mcpole, mbpole, mtpole   
      double precision thobs(mxrep,nexp,nset,mxpt)
      double precision exobs(mxpt,nexp,nset)
      double precision FKObservables
      
      character*100 pdffile
      character*20  nameexp(nexp)
      character*20  nameset(nexp,nset)
      character*100 infile, outfile
      character*20  cdum
      character*10  HQms
      character*20  obs(nexp,nset)

*     Read PDF file
      write(*,*) "Insert the PDF set name and press enter"
      read(5,*) pdffile

*     Initialise experiments
      nameexp(1)="CHORUS"
      nameexp(2)="NTV"

*     Initialise sets
      nameset(1,1)="NU"
      nameset(1,2)="NB"
      nameset(2,1)="NUDMN"
      nameset(2,2)="NBDMN"

*     Initialise PDF file
      call initpdfsetbyname(pdffile)
      call numberPDF(nrep)

*     Initialise kinematic details and observables
      do iexp=1, nexp

         do iset=1, nset

            write(infile,101) "commondata/DATA_", trim(nameexp(iexp)),
     1           trim(nameset(iexp,iset)), ".dat"

            open(unit=10, file=infile, status="old")


            read(10,*) cdum, nsys, npt(iexp,iset)

            do ipt=1, npt(iexp,iset)

               read(10,*) idum, obs(iexp,iset),  
     1              x(ipt,iexp,iset), 
     1              Q2(ipt,iexp,iset), 
     1              y(ipt,iexp,iset),
     1              exobs(ipt,iexp,iset)

               Q(ipt,iexp,iset) = dsqrt(Q2(ipt,iexp,iset))

            enddo

            close(10)

         enddo

      enddo

*     Initialise the details of the theory
      ptord        = 1
      HQms         = "FONLL-B"
      alphaQCDref  = 0.118d0
      QalphaQCDref = 91.2
      alphaQEDref  = 0.007496252d0
      QalphaQEDref = 1.777d0
      mcpole       = 1.51d0
      mbpole       = 4.92d0
      mtpole       = 172.5d0
      nflmax       = 5
      Q0           = 1.65d0

*     Initialise APFEL
      call SetPDFset(pdffile)
      call SetPerturbativeOrder(ptord) 
      call SetMassScheme(trim(HQms))
      call SetAlphaQCDRef(alphaQCDref,QalphaQCDref)
      call SetAlphaQEDRef(alphaQEDref,QalphaQEDref)
      call SetPoleMasses(mcpole,mbpole,mtpole)
      call EnableIntrinsicCharm(.true.)
      call EnableDampingFONLL(.false.)
      call EnableTargetMassCorrections(.true.)
      call SetPDFEvolution("truncated")
      call SetMaxFlavourAlpha(nflmax)
      call SetMaxFlavourPDFs(nflmax)

      call initializeAPFEL()
      call InitializeAPFEL_DIS()

*     Compute predictions
      do irep=1, nrep 

         call SetReplica(irep)
         
         do iexp=1, nexp

            do iset=1, nset
               
               do ipt=1, npt(iexp,iset)

                  if(Q(ipt,iexp,iset).gt.1d0)then
                     
                     call ComputeStructureFunctionsAPFEL
     1                    (Q0,Q(ipt,iexp,iset))
                     call SetFKObservable(trim(obs(iexp,iset)))
                   
                     thobs(irep,iexp,iset,ipt) = 
     1                    FKObservables
     1                    (x(ipt,iexp,iset),
     1                    Q(ipt,iexp,iset),
     1                    y(ipt,iexp,iset))
                     
                  else
                     
                     thobs(irep,iexp,iset,ipt)=0d0
                     
                  endif
                     
               enddo
         
            enddo

         enddo
         
      enddo
      
*     Write results on file
      do iexp=1, nexp
         
         do iset=1, nset

            write(outfile,101) "res/OBS_", trim(nameexp(iexp)),
     1           trim(nameset(iexp,iset)), ".res"

            open(unit=20, file=outfile, status="unknown")

            write(20,102) obs(iexp, iset), npt(iexp,iset)
            
            do irep=1, nrep

               write(20,103) irep

               do ipt=1, npt(iexp,iset)

                  write(20,104) ipt, 
     1                 x(ipt,iexp,iset),
     1                 thobs(irep,iexp,iset,ipt),
     1                 exobs(ipt,iexp,iset)

               enddo

            enddo

            close(20)

         enddo

      enddo

 101  format(a,a,a,a)
 102  format(a,i4)
 103  format(i4)
 104  format(i4,3(f12.7))

      stop
      end

********************************************************************************
