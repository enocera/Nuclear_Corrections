********************************************************************************
*                                                                              *
*     This program generates the LHAPDF grid for the central value fo the      *
*     CTEQ6.1 PDF set required to normalise the nCTEQ15 nuclear PDFs.          *
*                                                                              *
********************************************************************************

      program cteq61_LHAPDF
      implicit none

      integer IREPB
      common / replica / irepB

      double precision Qin

      character*30 setname

      setname="cteq61"

      Qin   = -1d0   !GeV 
      irepb = -1

      call setPerturbativeOrder(1)
      call SetPoleMasses(1.51d0,4.92d0,172.5d0)
      call SetAlphaEvolution("exact")
      call SetAlphaQCDref(0.118d0,91.1876d0)
      call SetMaxFlavourPDFs(5)
      call SetMaxFlavourAlpha(5)
      call SetPDFSet("repexternal")
      call SetLHgridParameters(100,50,1d-5,1d-1,1d0,50,
     1                         1.0000000001d0,99999.998d0)
      
      call LHAPDFgrid(40,Qin,trim(setname))

      call CleanUp

      stop
      end

********************************************************************************

      subroutine ExternalSetAPFELRep(x,Q,irep,xf)

      implicit none
      
      integer irep, irepb
      common / replica / irepb

      double precision x, Q, Q2
      double precision xf(-6:7)
      double precision Ctq6pdf
      external Ctq6pdf

      Q2 = Q * Q

      call SetCtq6(irep+200)

      xf(-6) = 0d0
      xf(-5) = x*Ctq6pdf(-5, x, Q)
      xf(-4) = x*Ctq6pdf(-4, x, Q)
      xf(-3) = x*Ctq6pdf(-3, x, Q)
      xf(-2) = x*Ctq6pdf(-1, x, Q)
      xf(-1) = x*Ctq6pdf(-2, x, Q)
      xf(0)  = x*Ctq6pdf(0, x, Q)
      xf(1)  = x*Ctq6pdf(2, x, Q)
      xf(2)  = x*Ctq6pdf(1, x, Q)
      xf(3)  = x*Ctq6pdf(3, x, Q)
      xf(4)  = x*Ctq6pdf(4, x, Q)
      xf(5)  = x*Ctq6pdf(5, x, Q)
      xf(6)  = 0d0
      xf(7)  = 0d0
         
      irepb = irep

      return
      end

********************************************************************************
