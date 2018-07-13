********************************************************************************
*                                                                              *
*     program relunc                                                           *
*     This program computes the relative uncertainty between the original      *
*     Hessian nPDF grid and the corresponding MC grid (in percentage)          *
*                                                                              *
********************************************************************************

      program relunc
      implicit none

      integer ipt, npt
      parameter(npt=36)
      integer iwrap, nwrap
      parameter(nwrap=2)
      integer irep, nrep
      integer ifl

      double precision x, Q, Q2
      double precision xpdflh(-6:6)
      double precision pdf_cv(-3:3,npt,nwrap), pdf_er(-3:3,npt,nwrap)
      double precision xpdfup(-3:3,npt), xpdfdo(-3:3,npt)
      double precision factor

      character*100 wrapfile(nwrap), outfile

      dimension x(npt)

      data x / 1d-4, 2d-4, 3d-4, 4d-4, 5d-4, 6d-4, 7d-4, 8d-4, 9d-4,
     1     1d-3, 2d-3, 3d-3, 4d-3, 5d-3, 6d-3, 7d-3, 8d-3, 9d-3,
     1     1d-2, 2d-2, 3d-2, 4d-2, 5d-2, 6d-2, 7d-2, 8d-2, 9d-2,
     1     1d-1, 2d-1, 3d-1, 4d-1, 5d-1, 6d-1, 7d-1, 8d-1, 9d-1 /
      
*     Initialise energy scale
      Q2 = 10d0 !GeV2
      Q  = dsqrt(Q2)

*     Read wrapfiles
      read(5,*) wrapfile(1)
      read(5,*) wrapfile(2)
      
*     Initialise rescaling factor
      if(trim(wrapfile(1)).eq."DSSZ_NLO_Fe56".or.
     1     trim(wrapfile(1)).eq."DSSZ_NLO_Pb208")then
         factor=5.48d0/2d0 !Rescale by the toleracne t=0.5*sqrt(30)
      else
         factor=1d0/1.65d0 !Rescale from 90% CM to 68% CL
      endif


*     Initialise arrays
      do iwrap=1, nwrap

         do ipt=1, npt

            do ifl=-3, 3, 1

                pdf_cv(ifl,ipt,iwrap)=0d0
                pdf_er(ifl,ipt,iwrap)=0d0

            enddo

         enddo
        
      enddo

*     Compute central values and ucnertainties
      do iwrap=1, nwrap

         call initpdfsetbyname(wrapfile(iwrap))
         call numberpdf(nrep)

         if(iwrap.eq.1)then
            
            call initpdf(0)
            
            do ipt=1, npt

               do ifl=-3, 3, 1

                  call evolvepdf(x(ipt),Q,xpdflh)
                  pdf_cv(ifl,ipt,iwrap) = xpdflh(ifl)

               enddo

            enddo

            do irep=1, nrep/2

               call initpdf(2*irep-1)

               do ipt=1, npt
                  
                  do ifl=-3, 3, 1

                     call evolvepdf(x(ipt),Q,xpdflh)
                     xpdfup(ifl,ipt) = xpdflh(ifl)
   
                  enddo
                  
               enddo

               call initpdf(2*irep)

               do ipt=1, npt
                  
                  do ifl=-3, 3, 1
                     
                     call evolvepdf(x(ipt),Q,xpdflh)
                     xpdfdo(ifl,ipt) = xpdflh(ifl)
   
                  enddo
                  
               enddo
       
               do ipt=1, npt

                  do ifl=-3, 3, 1

                     pdf_er(ifl,ipt,iwrap) = pdf_er(ifl,ipt,iwrap)
     1                    + (xpdfup(ifl,ipt) - xpdfdo(ifl,ipt))**2d0

                  enddo

               enddo

            enddo

            do ipt=1, npt

               do ifl=-3, 3, 1

                  pdf_er(ifl,ipt,iwrap) = factor *
     1                 0.5d0 * dsqrt(pdf_er(ifl,ipt,iwrap))

               enddo

            enddo

         else
            
            do irep=1, nrep

               call initpdf(irep)
               
               do ipt=1, npt

                  call evolvepdf(x(ipt),Q,xpdflh)
                  
                  do ifl=-3, 3, 1
                     
                     pdf_cv(ifl,ipt,iwrap) = pdf_cv(ifl,ipt,iwrap) 
     1                    + xpdflh(ifl)/nrep
                     pdf_er(ifl,ipt,iwrap) = pdf_er(ifl,ipt,iwrap)
     1                    + xpdflh(ifl)**2d0/nrep

                  enddo

               enddo

            enddo

            do ipt=1, npt

               do ifl=-3, 3, 1

                  pdf_er(ifl,ipt,iwrap) 
     1                 = dsqrt(pdf_er(ifl,ipt,iwrap)
     1                 - pdf_cv(ifl,ipt,iwrap)**2d0)

               enddo

            enddo

         endif

      enddo

*     Compute the relative difference
      do ifl=-2,3,1

         if(ifl.lt.0)then
            write(outfile,102) "../res/", trim(wrapfile(1)),
     1           "/relunc_", ifl, ".res"
            
         else
            write(outfile,103) "../res/", trim(wrapfile(1)),
     1           "/relunc_", ifl, ".res"
            
         endif
         
         open(unit=10, status="unknown", file=outfile)
         
         do ipt=1, npt
            
            write(10,101) ipt, x(ipt),
     1           (1d0 - pdf_cv(ifl,ipt,2)/pdf_cv(ifl,ipt,1))*100, 
     1           (1d0 - pdf_er(ifl,ipt,2)/pdf_er(ifl,ipt,1))*100
         enddo
         
      enddo
      
      close(10)

 101  format(i4,100(f15.7))
 102  format(a,a,a,i2,a)
 103  format(a,a,a,i1,a)

      stop
      end
      
