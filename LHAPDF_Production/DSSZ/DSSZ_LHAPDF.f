********************************************************************************
*                                                                              *
*     This program generates the LHAPDF grids for each eigenvector of the      *
*     DSSZ sets. Bound proton nuclear PDFs are reconstructed from the ratio    *
*     R according to Eqs.(6),(14) in arXiv:1112:6324. It is implicitly assumed *
*     that the free proton PDF ucnertainty is already included in the ratio R  *
*                                                                              *
********************************************************************************

      program DSSZ_LHAPDF
      implicit none

      integer IREPB
      common / replica / irepB

      double precision Qin
      double precision A

      common / Anumber / A

      character*50 wrapfile

      Qin   = -1d0   !GeV 
      irepb = -1

      write(*,*) "Insert the atomic number ",
     1     "(iron=56; lead=208)"
      read(5,*) A

      if(A.eq.56d0)then
         wrapfile="DSSZ_NLO_Fe56"
      elseif(A.eq.208d0)then
         wrapfile="DSSZ_NLO_Pb208"
      else
         write(*,*) "Atomic number not available"
         stop
      endif

      call initPDFsetbyname("NNPDF31_nnlo_nuclear_CORR_new")
      call initPDF(0)

      call setPerturbativeOrder(2)
      call SetPoleMasses(1.51d0,4.92d0,172.5d0)
      call SetAlphaEvolution("exact")
      call SetAlphaQCDref(0.120179d0,91.1876d0)
      call SetMaxFlavourPDFs(5)
      call SetMaxFlavourAlpha(5)
      call SetPDFSet("repexternal")
      call SetLHgridParameters(100,50,1d-5,1d-1,1d0,50,
     1                         1.0000000001d0,99999.998d0)
      
      call LHAPDFgrid(50,Qin,trim(wrapfile))
      
      call CleanUp

      stop
      end

********************************************************************************

      subroutine ExternalSetAPFELRep(x,Q,irep,xf)

      implicit none
      
      integer fini, is, irep, irepb, ipdf
      common / fragini / fini
      common / replica / irepb

      double precision x, Q, Q2
      double precision RUV, RDV, RUB, RDB, RS, RC, RB, RG
      double precision xpdflh(-6:7), xf(-6:7)
      double precision A
      common / Anumber / A
      
      if(irep.ne.irepb)then
         fini = 0
      endif

      Q2 = Q * Q

      if(irep.gt.0)then
         if(mod(irep,2).eq.0)then
            is = - irep / 2
         else
            is = ( irep + 1 ) / 2
         endif
      else
         is = irep
      endif

      call DSSZINI(is)
      call DSSZ(X,Q,A,RUV,RDV,RUB,RDB,RS,RC,RB,RG)
      call evolvePDF(x,Q,xpdflh)

      xf(-6) = 0d0
      xf(-5) = RB  * xpdflh(-5)
      xf(-4) = RC  * xpdflh(-4)
      xf(-3) = RS  * xpdflh(-3)
      xf(-2) = RUB * xpdflh(-2)
      xf(-1) = RDB * xpdflh(-1)
      xf(0)  = RG  * xpdflh(0)
      xf(1)  = RDV * ( xpdflh(+1) - xpdflh(-1) )
     1       + RDB * xpdflh(-1)
      xf(2)  = RUV * ( xpdflh(+2) - xpdflh(-2) )
     1       + RUB * xpdflh(-2)
      xf(3)  = RS * xpdflh(+3)
      xf(4)  = RC * xpdflh(+4)
      xf(5)  = RB * xpdflh(+5)
      xf(6)  = 0d0
      xf(7)  = 0d0

      irepb = irep

      return
      end

********************************************************************************
