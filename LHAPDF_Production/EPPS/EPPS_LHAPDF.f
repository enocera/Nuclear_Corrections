********************************************************************************
*                                                                              *
*     This program generates the LHAPDF grids for each eigenvector of the      *
*     DSSZ sets. Bound prootn nuclear PDFs are reconstructed from the ratio    *
*     R according to Eqs.(6),(14) in arXiv:1112:6324. It is implicitly assumed *
*     that the free proton PDF ucnertainty is already included in the ratio R  *
*                                                                              *
********************************************************************************

      program DSSZ_LHAPDF
      implicit none

      integer IREPB
      common / replica / irepB

      double precision Qin
      double precision A, Z

      common / Anumber / A, Z

      character*30 wrapfilein, wrapfileou

      Qin   = -1d0   !GeV 
      irepb = -1

      write(*,*) "Insert the atomic number A",
     1     "(iron=56; lead=208)"
      read(5,*) A

      write(*,*) "insert the atomic number Z",
     1     "(iron=26; lead=82)"

      read(5,*) Z

      if(A.eq.56d0.and.Z.eq.26)then
         wrapfilein="EPPS16nlo_CT14nlo_Fe56"
         wrapfileou="EPPS16nlo_CT14nlo_Fe56_bound"
      elseif(A.eq.208d0.and.Z.eq.82)then
         wrapfilein="EPPS16nlo_CT14nlo_Pb208"
         wrapfileou="EPPS16nlo_CT14nlo_Pb208_bound"
      else
         write(*,*) "Atomic number not available"
         stop
      endif

      call initpdfsetbyname(wrapfilein)

      call setPerturbativeOrder(1)
      call SetPoleMasses(1.3d0,4.75d0,172d10)
      call SetAlphaEvolution("exact")
      call SetAlphaQCDref(0.118d0,91.1876d0)
      call SetMaxFlavourPDFs(5)
      call SetMaxFlavourAlpha(5)
      call SetPDFSet("repexternal")
      call SetLHgridParameters(100,50,1d-5,1d-1,1d0,50,
     1                         1.0000000001d0,99999.998d0)
      
      call LHAPDFgrid(96,Qin,trim(wrapfileou))

      call CleanUp

      stop
      end

********************************************************************************

      subroutine ExternalSetAPFELRep(x,Q,irep,xf)

      implicit none
      
      integer irep, irepb
      common / replica / irepb

      double precision x, Q, Q2
      double precision xpdflh(-6:7), xf(-6:7)
      double precision A, Z
      common / Anumber / A, Z

      Q2 = Q * Q

      call initPDF(irep)
      call evolvePDF(x,Q,xpdflh)

      xf(-6) = 0d0
      xf(-5) = xpdflh(-5)
      xf(-4) = xpdflh(-4)
      xf(-3) = xpdflh(-3)
      xf(-2) = ( (Z-A) * xpdflh(-1) + Z * xpdflh(-2) ) / (2d0*Z - A)
      xf(-1) = ( (Z-A) * xpdflh(-2) + Z * xpdflh(-1) ) / (2d0*Z - A)
      xf(0)  = xpdflh(0)
      xf(1)  = ( (Z-A) * xpdflh(+2) + Z * xpdflh(+1) ) / (2d0*Z - A)
      xf(2)  = ( (Z-A) * xpdflh(+1) + Z * xpdflh(+2) ) / (2d0*Z - A)
      xf(3)  = xpdflh(+3)
      xf(4)  = xpdflh(+4)
      xf(5)  = xpdflh(+5)
      xf(6)  = 0d0
      xf(7)  = 0d0

      irepb = irep

      return
      end

********************************************************************************
