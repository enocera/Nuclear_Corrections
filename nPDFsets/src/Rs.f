********************************************************************************
*                                                                              *
*     program Rs                                                               *
*     This program computes the ratio between the bound proton PDF and the     *
*     free proton PDF (corresponding to the same set) for each flavour i.      *
*     Input: from screen, the Monte Carlo nPDF set of the ratio R              *
*            energy scale Q2 (in GeV)                                          *
*     Output: ../res/<setname>_MC                                              *
*                                                                              *
********************************************************************************

      program Rs
      implicit none

      integer ipt, npt
      parameter(npt=30)
      integer iwrap, nwrap
      parameter(nwrap=1)
      integer irep, nrep
      integer ifl

      double precision x(npt), Q, Q2
      double precision xmin, xmax, xch
      parameter(xmin=1d-4,xmax=1d0,xch=1d-1)
      double precision xpdflh(-6:6)
      double precision pdf_cv(-3:3,npt,nwrap), pdf_er(-3:3,npt,nwrap)
      double precision norm(-3:3,npt)
      double precision freePDF, nuclPDF

      character*100 wrapfile(nwrap), NNwrapfile
      character*100 outfile

*     Initialise x space
      do ipt=1, npt
         
         if(ipt.le.npt/2)then
            x(ipt)=xmin*(xch/xmin)**(2d0*dfloat(ipt-1)/dfloat(npt-1))
         else
            x(ipt)=xch+(xmax-xch)*(dble(ipt-npt/2-1)
     1              /dble(npt-npt/2-1))
         endif
         
      enddo

*     Read wrapfile and Q2
      read(5,*) wrapfile(1)
      read(5,*) Q2 !GeV
      Q  = dsqrt(Q2)

*     Define NNPDF reference
      NNwrapfile="NNPDF31_nnlo_nuclear_CORR_new"

*     Initialise arrays
      do iwrap=1, nwrap

         do ipt=1, npt

            do ifl=-3, 3, 1

                pdf_cv(ifl,ipt,iwrap)=0d0
                pdf_er(ifl,ipt,iwrap)=0d0

            enddo

         enddo
        
      enddo

*     Normalising factor
      call initpdfsetbyname(NNwrapfile)
      call initPDF(0)

      do ipt=1, npt
         
         call evolvepdf(x(ipt),Q,xpdflh)
               
         do ifl=-3, 3, 1

            freePDF = xpdflh(ifl)
            norm(ifl,ipt) = freePDF
            
         enddo
         
      enddo

*     Compute central values and uncertainties
      do iwrap=1, nwrap
         
         call initpdfsetbyname(wrapfile(iwrap))
         call numberpdf(nrep)
         
         do irep=1, nrep
            
            call initpdf(irep)
            
            do ipt=1, npt
               
               call evolvepdf(x(ipt),Q,xpdflh)
               
               do ifl=-3, 3, 1  
                  
                  if(ifl.eq.-3.or.ifl.eq.-2
     1                 .or.ifl.eq.-1.or.ifl.eq.3)then
                     nuclPDF = xpdflh(ifl)/norm(ifl,ipt)
                  elseif(ifl.eq.2)then
                     nuclPDF = ( xpdflh(2) -xpdflh(-2) )
     1                    / ( norm(2,ipt) - norm(-2,ipt) )
                  elseif(ifl.eq.1)then
                     nuclPDF = ( xpdflh(1) -xpdflh(-1) )
     1                    / ( norm(1,ipt) - norm(-1,ipt) )
                  endif
                  
                  pdf_cv(ifl,ipt,iwrap) = pdf_cv(ifl,ipt,iwrap) 
     1                 + nuclPDF/nrep
                  pdf_er(ifl,ipt,iwrap) = pdf_er(ifl,ipt,iwrap)
     1                 + nuclPDF**2d0/nrep
                  
               enddo
               
            enddo
            
         enddo
         
         do ipt=1, npt
            
            do ifl=-3, 3, 1
               
               pdf_er(ifl,ipt,iwrap) 
     1              = dsqrt(pdf_er(ifl,ipt,iwrap)
     1              - pdf_cv(ifl,ipt,iwrap)**2d0)
               
            enddo
            
         enddo
         
      enddo
      
*     Write results on file
      do ifl=-3,3,1
         
         if(ifl.lt.0)then
            write(outfile,102) "../res/", trim(wrapfile(1)),
     1           "/xPDFs_", ifl, ".res"
            
         else
            write(outfile,103) "../res/", trim(wrapfile(1)),
     1           "/xPDFs_", ifl, ".res"
            
         endif
         
         open(unit=10, status="unknown", file=outfile)
         
         do ipt=1, npt
            
            write(10,101) ipt, x(ipt),
     1           pdf_cv(ifl,ipt,1), pdf_er(ifl,ipt,1)
            
         enddo
         
      enddo
      
      close(10)

 101  format(i4,100(f15.7))
 102  format(a,a,a,i2,a)
 103  format(a,a,a,i1,a)

      stop
      end
      
