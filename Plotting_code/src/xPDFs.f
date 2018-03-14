********************************************************************************
*                                                                              *
*     program xPDFs                                                            *
*                                                                              *
********************************************************************************

      program relunc
      implicit none

      integer ipt, npt
      parameter(npt=100)
      integer iwrap, nwrap
      parameter(nwrap=1)
      integer irep, nrep
      integer ifl

      double precision x(npt), Q, Q2
      double precision xmin, xmax, xch
      parameter(xmin=1d-4,xmax=1d0,xch=1d-1)
      double precision xpdflh(-6:6)
      double precision pdf_cv(-4:4,npt,nwrap), pdf_er(-4:4,npt,nwrap)
      double precision factor

      character*100 wrapfile(nwrap), outfile
      
*     Initialise energy scale
      Q2 = 100d0 !GeV2
      Q  = dsqrt(Q2)

*     Initialise x space
      do ipt=1, npt
         
         if(ipt.le.npt/2)then
            x(ipt)=xmin*(xch/xmin)**(2d0*dfloat(ipt-1)/dfloat(npt-1))
         else
            x(ipt)=xch+(xmax-xch)*(dble(ipt-npt/2-1)
     1              /dble(npt-npt/2-1))
         endif
         
      enddo

*     Read wrapfiles
      read(5,*) wrapfile(1)
      
*     Initialise rescaling factor
      if(trim(wrapfile(1)).eq."DSSZ_NLO_Fe56".or.
     1     trim(wrapfile(1)).eq."DSSZ_NLO_Pb208")then
         factor=1d0
      else
         factor=1d0
      endif


*     Initialise arrays
      do iwrap=1, nwrap

         do ipt=1, npt

            do ifl=-4, 4, 1

                pdf_cv(ifl,ipt,iwrap)=0d0
                pdf_er(ifl,ipt,iwrap)=0d0

            enddo

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
               
               do ifl=-4, 4, 1
                  
                  pdf_cv(ifl,ipt,iwrap) = pdf_cv(ifl,ipt,iwrap) 
     1                 + xpdflh(ifl)/nrep
                  pdf_er(ifl,ipt,iwrap) = pdf_er(ifl,ipt,iwrap)
     1                 + xpdflh(ifl)**2d0/nrep
                  
               enddo
               
            enddo
            
         enddo

         do ipt=1, npt
            
            do ifl=-4, 4, 1
               
               pdf_er(ifl,ipt,iwrap) 
     1                 = dsqrt(pdf_er(ifl,ipt,iwrap)
     1              - pdf_cv(ifl,ipt,iwrap)**2d0)
               
            enddo
            
         enddo
         
      enddo
      
*     Write results on file
      do ifl=-2,4,1

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
     1           pdf_cv(ifl,ipt,1), factor*pdf_er(ifl,ipt,1)
            
         enddo
         
      enddo
      
      close(10)

 101  format(i4,100(f15.7))
 102  format(a,a,a,i2,a)
 103  format(a,a,a,i1,a)

      stop
      end
      
