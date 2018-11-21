********************************************************************************
*                                                                              *
*     program duratio                                                          *
*     This program computes the ratio dbar/ubar as a function of x for the     *
*     four fits in the NNPDF31nucl paper                                       *
*     Input:                                                                   *
*     - Q value from terminal                                                  *
*     Output                                                                   *
*     - res/duratio.res                                                        *
*                                                                              *
********************************************************************************

      program duratio
      implicit none

      integer iwrap, nwrap
      parameter(nwrap=4)
      integer irep, nrep
      integer ipt, npt
      parameter(npt=30)
      
      double precision Q
      double precision x(npt)
      double precision xmin, xmax
      parameter(xmin=1d-2,xmax=0.75)
      double precision xpdflh(-6:6)
      double precision ratio, du_cv(npt,nwrap), du_er(npt,nwrap)

      character*100 infile(nwrap), outfile

*     Define infiles
      infile(1) = "NNPDF31_nnlo_as_0118_NUTEV_DBG"
      infile(2) = "NNPDF31_nnlo_nonuclear"
      infile(3) = "NNPDF31_nnlo_nuclear_CORR"
      infile(4) = "NNPDF31_nnlo_nuclear_SHIFT"

*     Define x slicing
      do ipt=1, npt
         x(ipt) = xmin*(xmax/xmin)**(dfloat(ipt-1)/dfloat(npt-1))
      enddo

*     Read input energy scale
      write(*,*) "Enter energy scale"
      read(5,*) Q

*     Define outfile
      write(outfile,102) "res/du_", Q ,".res"

*     Compute du central values and ucnertainties
      do iwrap=1, nwrap
         call initpdfsetbyname(trim(infile(iwrap)))
         call numberpdf(nrep)
         do ipt=1, npt

            du_cv(ipt,iwrap) = 0d0
            du_er(ipt,iwrap) = 0d0

            do irep=1, nrep
               call initpdf(irep)
               call evolvepdf(x(ipt),Q, xpdflh)               
               ratio = xpdflh(-1)/xpdflh(-2)
               du_cv(ipt,iwrap) = du_cv(ipt,iwrap) + ratio/nrep
               du_er(ipt,iwrap) = du_er(ipt,iwrap) + ratio**2d0/nrep
            enddo
            du_er(ipt,iwrap) = 
     1           dsqrt(du_er(ipt,iwrap) - du_cv(ipt,iwrap)**2d0)
         enddo
      enddo

*     Write results on file
      open(unit=10, status="unknown", file=outfile)
      do ipt=1, npt
         write(10,101) ipt, x(ipt), 
     1        (du_cv(ipt,iwrap), du_er(ipt,iwrap),iwrap=1, nwrap)
      enddo
      close(10)

 101  format(i5,f12.7,8(f15.5))
 102  format(a,f4.1,a)

      stop
      end
      
