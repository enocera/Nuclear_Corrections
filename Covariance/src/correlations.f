********************************************************************************
*                                                                              *
*     correlations.f                                                           *
*     This program computes the correlation coefficient between the            *
*     observables and the PDfs for CHORUS, NUTEV and DYE605.                   *
*     Input from ../../Observables/validphys                                   *
*                ../../data/commondata                                         *
*     Output to ../res/correlations_[nameexp][nameset].res                     *
*                                                                              *
********************************************************************************

      program correlations
      implicit none

      integer iexp, nexp
      parameter(nexp=3)
      integer iset, nset(nexp), mxset
      parameter(mxset=2)
      integer iwrap, nwrap(nexp), mxwrap
      parameter(mxwrap=3)
      integer irep, nrepwrap
      parameter(nrepwrap=300)
      integer idum, mxdum
      parameter(mxdum=500)
      integer ipt, npt(nexp,mxset), mxpt
      parameter(mxpt=700)
      integer nnmax
      parameter(nnmax=900)

      integer ifl
      integer iirep, nnrep(nexp,mxset)
      
      double precision thexp(mxwrap,nexp,mxset,mxpt)
      double precision thobsnucl(mxwrap,nrepwrap+1,nexp,mxset,mxpt)
      double precision Q2, Q(nexp,mxset,mxpt), x(nexp,mxset,mxpt)
      double precision x1(nexp,mxset,mxpt), x2(nexp,mxset,mxpt)
      double precision xpdflh(-6:6)
      double precision xPDF(nexp,mxset,mxwrap,mxpt,nrepwrap)
      double precision xPDF1(nexp,mxset,mxwrap,mxpt,nrepwrap)
      double precision xPDF2(nexp,mxset,mxwrap,mxpt,nrepwrap)
      double precision A(nexp,mxset,mxpt,nnmax) 
      double precision B(nexp,mxset,mxpt,nnmax)
      double precision B1(nexp,mxset,mxpt,nnmax)
      double precision B2(nexp,mxset,mxpt,nnmax)
      double precision cme
      parameter(cme=38.8) !GeV
      double precision W2min, Wmin, W
      double precision Q2min, Qmin
      parameter(W2min=12.5d0,Q2min=3.49) !GeV2

      double precision meanA, meanB, erroa, erroB, meanAB
      double precision meanB1, meanB2, erroB1, erroB2, meanAB1, meanAB2
      double precision rho(nexp,mxset,mxpt)
      double precision rho1(nexp,mxset,mxpt)
      double precision rho2(nexp,mxset,mxpt)

      character*20  nameexp(nexp), nameset(nexp,mxset)
      character*100 wrapfile(nexp,mxwrap), infilewrap(nexp,mxwrap)
      character*100 infiledat(nexp,mxset)
      character*100 outfile(nexp,mxset)
      character*20  cdum(mxdum), ccdum

*     Initialise kinematic cuts
      Wmin=dsqrt(W2min)
      Qmin=dsqrt(Q2min)

*     Initialise flavour
      write(*,*) "Enter flavour ID"
      read(5,*) ifl

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

*     Define input files
      do iexp=1, nexp

         do iwrap=1, nwrap(iexp)

            write(infilewrap(iexp,iwrap),101)
     1           "../../Observables/validphys/", 
     1           trim(wrapfile(iexp,iwrap)),
     1           "/output/tables/experiment_result_table.csv"

         enddo
         
         do iset=1, nset(iexp)

            write(infiledat(iexp,iset),102)
     1           "../../Data/commondata/DATA_",
     1           trim(nameexp(iexp)), trim(nameset(iexp,iset)), ".dat"

         enddo

      enddo

*     Define output files
      do iexp=1, nexp

         do iset=1, nset(iexp)

            if(ifl.lt.0)then
               write(outfile(iexp,iset),103) "../res/corrs_",
     1              trim(nameexp(iexp)),
     1              trim(nameset(iexp,iset)), "_", ifl, ".res"
            else
               write(outfile(iexp,iset),104) "../res/corrs_",
     1              trim(nameexp(iexp)),
     1              trim(nameset(iexp,iset)), "_", ifl, ".res"
            endif
            
         enddo
         
      enddo
      
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

*     Read data from files (kinematics)
      do iexp=1, nexp

         do iset=1, nset(iexp)

            open(unit=20, status="old", file=infiledat(iexp,iset))
            
            read(20,*) ccdum, idum, idum

            do ipt=1, npt(iexp,iset)
               read(20,*) idum, ccdum, x(iexp,iset,ipt), Q2
               Q(iexp,iset,ipt)=dsqrt(Q2)
               if(iexp.eq.3)then
                  x1(iexp,iset,ipt) 
     1                 = Q(iexp,iset,ipt) / cme
     1                 * dexp(1d0*x(iexp,iset,ipt))
                  x2(iexp,iset,ipt) 
     1                 = Q(iexp,iset,ipt) / cme
     1                 * dexp(-1d0*x(iexp,iset,ipt))
               endif
            enddo

            close(20)

         enddo

      enddo

*     Compute PDFs
      do iexp=1, nexp
         
         do iset=1, nset(iexp)
            
            do iwrap=1, nwrap(iexp)
               
               call initpdfsetbyname(wrapfile(iexp,iwrap))
               
               do irep=1, nrepwrap
                  
                  call initPDF(irep)
                  
                  do ipt=1, npt(iexp,iset)
                     
                     if(iexp.eq.3)then
                        call evolvePDF(x1(iexp,iset,ipt),
     1                       Q(iexp,iset,ipt),xpdflh)
                        xPDF1(iexp,iset,iwrap,ipt,irep)
     1                       = xpdflh(ifl) 
                        call evolvePDF(x2(iexp,iset,ipt),
     1                       Q(iexp,iset,ipt),xpdflh)
                        xPDF2(iexp,iset,iwrap,ipt,irep)
     1                       = xpdflh(ifl) 
                     else
                        call evolvePDF(x(iexp,iset,ipt),
     1                       Q(iexp,iset,ipt),xpdflh)
                        xPDF(iexp,iset,iwrap,ipt,irep)
     1                       = xpdflh(ifl)  
                     endif

                  enddo
                  
               enddo
               
            enddo
            
         enddo
         
      enddo
      
*     Recast variables
      do iexp=1, nexp

         do iset=1, nset(iexp)

            do ipt=1, npt(iexp,iset)
               
               do iwrap=1, nwrap(iexp)
                  
                  do irep=1, nrepwrap
                     
                     iirep = irep + (iwrap-1)*nrepwrap
                     
                     A(iexp,iset,ipt,iirep) 
     1                    = thobsnucl(iwrap,irep,iexp,iset,ipt)

                  enddo

               enddo

            enddo

         enddo

      enddo

      do iexp=1, nexp

         do iset=1, nset(iexp)

            do ipt=1, npt(iexp,iset)
               
               do iwrap=1, nwrap(iexp)
                  
                  do irep=1, nrepwrap
                     
                     iirep = irep + (iwrap-1)*nrepwrap
                     
                     if(iexp.eq.3)then
                        B1(iexp,iset,ipt,iirep)
     1                       = xPDF1(iexp,iset,iwrap,ipt,irep)
                        B2(iexp,iset,ipt,iirep)
     1                       = xPDF2(iexp,iset,iwrap,ipt,irep)
                     else
                        B(iexp,iset,ipt,iirep)
     1                       = xPDF(iexp,iset,iwrap,ipt,irep)
                     endif
                        
                  enddo
                  
               enddo
               
            enddo
            
         enddo
         
      enddo
      
*     Determine number of replicas in the combined sets
      do iexp=1, nexp
         
         do iset=1, nset(iexp)
            
            nnrep(iexp,iset) = nrepwrap*nwrap(iexp)
            
         enddo
         
      enddo
      
*     Compute correlation coefficients
      do iexp=1, nexp
         
         do iset=1, nset(iexp)
            
            do ipt=1,  npt(iexp,iset)
               
               meanA  = 0d0
               meanB  = 0d0
               meanB1 = 0d0
               meanB2 = 0d0
               meanAB = 0d0
               meanAB1= 0d0
               meanAB2= 0d0
               erroA  = 0d0
               erroB  = 0d0
               erroB1 = 0d0
               erroB2 = 0d0
               
               do iirep=1, nnrep(iexp,iset)
                  

                  meanA = meanA 
     1                 + A(iexp,iset,ipt,iirep)
     1                 /nnrep(iexp,iset)
                  erroA = erroA
     1                 + A(iexp,iset,ipt,iirep)**2d0
     1                 /nnrep(iexp,iset)

                  if(iexp.eq.3)then
                     meanB1 = meanB1
     1                    + B1(iexp,iset,ipt,iirep)
     1                    /nnrep(iexp,iset)
                     erroB1 = erroB1
     1                    + B1(iexp,iset,ipt,iirep)**2d0
     1                    /nnrep(iexp,iset)   
                     meanAB1 = meanAB1 
     1                    + A(iexp,iset,ipt,iirep)
     1                    * B1(iexp,iset,ipt,iirep)
     1                    /nnrep(iexp,iset)

                     meanB2 = meanB2
     1                    + B2(iexp,iset,ipt,iirep)
     1                    /nnrep(iexp,iset)
                     erroB2 = erroB2
     1                    + B2(iexp,iset,ipt,iirep)**2d0
     1                    /nnrep(iexp,iset)   
                     meanAB2 = meanAB2 
     1                    + A(iexp,iset,ipt,iirep)
     1                    * B2(iexp,iset,ipt,iirep)
     1                    /nnrep(iexp,iset)
                  else
                     meanB = meanB
     1                    + B(iexp,iset,ipt,iirep)
     1                    /nnrep(iexp,iset)
                     erroB = erroB
     1                    + B(iexp,iset,ipt,iirep)**2d0
     1                    /nnrep(iexp,iset)   
                     meanAB = meanAB 
     1                    + A(iexp,iset,ipt,iirep)
     1                    * B(iexp,iset,ipt,iirep)
     1                    /nnrep(iexp,iset)
                  endif
                     
               enddo
               
               erroA = dsqrt(erroA - meanA**2d0)

               if(iexp.eq.3)then
                  erroB1= dsqrt(erroB1 - meanB1**2d0)
                  erroB2= dsqrt(erroB2 - meanB2**2d0)
                  rho1(iexp,iset,ipt)
     1                 = ( meanAB1 - meanA * meanB1 ) / (erroA * erroB1)
                  rho2(iexp,iset,ipt)
     1                 = ( meanAB2 - meanA * meanB2 ) / (erroA * erroB2)

               else
                  erroB = dsqrt(erroB - meanB**2d0)
                  rho(iexp,iset,ipt)
     1                 = ( meanAB - meanA * meanB ) / (erroA * erroB )
               endif 
                                         
            enddo
            
         enddo
         
      enddo
      
*     Write results on file
      do iexp=1, nexp
         
         do iset=1, nset(iexp)
            
            open(unit=40, status="unknown", 
     1           file=outfile(iexp,iset))
            
            if(iexp.eq.3)then
               do ipt=1, npt(iexp,iset)
                  W = Q(iexp,iset,ipt) 
     1                 *dsqrt(1d0/x(iexp,iset,ipt) - 1d0)
                  if(Q(iexp,iset,ipt).ge.Qmin.and.W.gt.Wmin)then
                     write(40,105) ipt, x1(iexp,iset,ipt),
     1                    Q(iexp,iset,ipt), rho1(iexp,iset,ipt)
                  endif
               enddo
               do ipt=1, npt(iexp,iset)
                  W = Q(iexp,iset,ipt) 
     1                 *dsqrt(1d0/x(iexp,iset,ipt) - 1d0)
                  if(Q(iexp,iset,ipt).ge.Qmin.and.W.gt.Wmin)then
                     write(40,105) ipt, x2(iexp,iset,ipt),
     1                    Q(iexp,iset,ipt), rho2(iexp,iset,ipt)
                  endif
               enddo
            else
               do ipt=1, npt(iexp,iset)
                  W = Q(iexp,iset,ipt) 
     1                 *dsqrt(1d0/x(iexp,iset,ipt) - 1d0)
                  if(Q(iexp,iset,ipt).ge.Qmin.and.W.gt.Wmin)then
                     write(40,105) ipt, x(iexp,iset,ipt),
     1                    Q(iexp,iset,ipt), rho(iexp,iset,ipt)
                  endif
               enddo
            endif

            close(40)
            
         enddo
         
      enddo
      
 101  format(a,a,a)
 102  format(a,a,a,a)
 103  format(a,a,a,a,i2,a)
 104  format(a,a,a,a,i1,a)
 105  format(i4,f12.7,5000(f12.7))

      stop
      end
      



