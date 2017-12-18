********************************************************************************
*                                                                              *
*     This program generates the LHAPDF grids for each eigenvector of the      *
*     DSSZ sets. Nuclear PDFs are reconstructed from the ratio R according     *
*     to Eqs.(6),(14) in arXiv:1112:6324                                       *
*                                                                              *
********************************************************************************

      program DSSZ_LHAPDF
      implicit none

      integer IO, A, Z
      common / DSSpars / IO, A, Z

      integer IREPB
      common / replica / irepB

      double precision Qin

      IO    = 1  !NLO
      A     = 208 !Fe
      Z     = 82 !Fe

      Qin   = 1d0 !GeV 
      
      irepb = -1

      call dsszini(0)
      call initPDFsetbyname("MSTW2008nlo68cl")
      call initPDF(0)

      call setPerturbativeOrder(IO)
      call SetPoleMasses(1.4d0,4.75d0,1d10)
      call SetAlphaEvolution("exact")
      call SetAlphaQCDref(0.120179d0,91.1876d0)
      call SetMaxFlavourPDFs(5)
      call SetMaxFlavourAlpha(5)
      call SetPDFSet("repexternal")
      call SetLHgridParameters(100,50,1d-4,1d-1,1d0,50,
     1                         1.0000000001d0,99999.998d0)
      
      call LHAPDFgrid(50,Qin,"DSSZ_NLO_Pb208")

      call CleanUp

      stop
      end

********************************************************************************

      subroutine ExternalSetAPFELRep(x,Q,irep,xf)

      implicit none
      

      integer fini, is, irep, irepb
      integer IO, A, Z
      common / fragini / fini
      common / replica / irepb
      common / DSSpars / IO, A, Z

      double precision x, Q, Q2
      double precision RUV, RDV, RUB, RDB, RS, RC, RB, RG
      double precision xpdflh(-6:7), xf(-6:7)
      

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

      call DSSZ(X,Q,A,RUV,RDV,RUB,RDB,RS,RC,RB,RG)
      call evolvePDF(x,Q,xpdflh)

      xf(-6) = 0d0
      xf(-5) = RB * xpdflh(-5)
      xf(-4) = RC * xpdflh(-4)
      xf(-3) = RS * xpdflh(-3)
      xf(-2) = Z/A * RUB * xpdflh(-2) 
     1     + (A-Z)/A * RDB * xpdflh(-1) 
      xf(-1) = Z/A * RDB * xpdflh(-1) 
     1     + (A-Z)/A * RUB * xpdflh(-2) 
      xf(0)  = RG * xpdflh(0)
      xf(1)  =  Z/A * (RDV + RDB) * xpdflh(+1) 
     1     + (A-Z)/A * (RUV + RUB) * xpdflh(+2) 
      xf(2)  = Z/A * (RUV + RUB) * xpdflh(+2) 
     1     + (A-Z)/A * (RDV + RDB) * xpdflh(+1) 
      xf(3)  = RS * xpdflh(+3)
      xf(4)  = RC * xpdflh(+4)
      xf(5)  = RB * xpdflh(+5)
      xf(6)  = 0d0
      xf(7)  = 0d0

      irepb = irep

      return
      end
