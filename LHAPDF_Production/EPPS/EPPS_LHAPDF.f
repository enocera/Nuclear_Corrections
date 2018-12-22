********************************************************************************
*                                                                              *
*     This program generates the LHAPDF grids for each eigenvector of the      *
*     DSSZ sets. Bound proton nuclear PDFs are reconstructed from the ratio    *
*     R according to Eqs.(6),(14) in arXiv:1112:6324. It is implicitly assumed *
*     that the free proton PDF ucnertainty is already included in the ratio R  *
*                                                                              *
********************************************************************************

      program EPPS_LHAPDF
      implicit none

      integer IREPB
      common / replica / irepB

      double precision Qin
      double precision A, Z

      common / Anumber / A, Z

      character*30 setname1, setname2, setname3

      setname1="EPPS16nlo_CT14nlo_Fe56_bd"
      setname2="EPPS16nlo_CT14nlo_Pb208_bd"
      setname3="EPPS16nlo_CT14nlo_Cu64_bd"

      Qin   = -1d0   !GeV 
      irepb = -1

      write(*,*) "Insert the atomic number A",
     1     "(iron=56; lead=208; copper=64)"
      read(5,*) A

      write(*,*) "Insert the atomic number Z",
     1     "(iron=26; lead=82; copper=29)"

      read(5,*) Z

      call setPerturbativeOrder(2)
      call SetPoleMasses(1.51d0,4.92d0,172.5d0)
      call SetAlphaEvolution("exact")
      call SetAlphaQCDref(0.118d0,91.1876d0)
      call SetMaxFlavourPDFs(5)
      call SetMaxFlavourAlpha(5)
      call SetPDFSet("repexternal")
      call SetLHgridParameters(100,50,1d-5,1d-1,1d0,50,
     1                         1.0000000001d0,99999.998d0)
      
      if(A.eq.56d0.and.Z.eq.26d0)then
         call initpdfsetbynamem(1,"EPPS16nlo_CT14nlo_Fe56")
         call initpdfsetbynamem(2,"CT14nlo")
         call initpdfsetbynamem(3,"NNPDF31_nnlo_nuclear_CORR_new")
         call LHAPDFgrid(40,Qin,trim(setname1))
      elseif(A.eq.208d0.and.Z.eq.82d0)then
         call initpdfsetbynamem(1,"EPPS16nlo_CT14nlo_Pb208")
         call initpdfsetbynamem(2,"CT14nlo")
         call initpdfsetbynamem(3,"NNPDF31_nnlo_nuclear_CORR_new")
         call LHAPDFgrid(40,Qin,trim(setname2))
      elseif(A.eq.64d0.and.Z.eq.29d0)then
         call initpdfsetbynamem(1,"EPPS16nlo_CT14nlo_Cu64")
         call initpdfsetbynamem(2,"CT14nlo")
         call initpdfsetbynamem(3,"NNPDF31_nnlo_nuclear_CORR_new")
         call LHAPDFgrid(40,Qin,trim(setname3))
      else
         call exit(-1)
      endif

      call CleanUp

      stop
      end

********************************************************************************

      subroutine ExternalSetAPFELRep(x,Q,irep,xf)

      implicit none
      
      integer irep, irepb
      common / replica / irepb
      integer ifl

      double precision x, Q, Q2
      double precision xpdflh1(-6:7) 
      double precision xpdflh2(-6:7)
      double precision xpdflh3(-6:7)
      double precision xf(-6:7)
      double precision ratio
      double precision A, Z
      common / Anumber / A, Z

      external ratio

      Q2 = Q * Q

      call initPDFm(1,irep)
      call evolvePDFm(1,x,Q,xpdflh1)
      call initPDFm(2,0)
      call evolvePDFm(2,x,Q,xpdflh2)
      call initPDFm(3,0)
      call evolvePDFm(3,x,Q,xpdflh3)

      xf(-6) = 0d0
      xf(-5) = xpdflh1(-5)
      xf(-4) = xpdflh1(-4)
      xf(-3) = xpdflh1(-3)
      xf(-2) = ( (Z-A) * xpdflh1(-1) + Z * xpdflh1(-2) ) / (2d0*Z - A)
      xf(-1) = ( (Z-A) * xpdflh1(-2) + Z * xpdflh1(-1) ) / (2d0*Z - A)
      xf(0)  = xpdflh1(0)
      xf(1)  = ( (Z-A) * xpdflh1(+2) + Z * xpdflh1(+1) ) / (2d0*Z - A)
      xf(2)  = ( (Z-A) * xpdflh1(+1) + Z * xpdflh1(+2) ) / (2d0*Z - A)
      xf(3)  = xpdflh1(+3)
      xf(4)  = xpdflh1(+4)
      xf(5)  = xpdflh1(+5)
      xf(6)  = 0d0
      xf(7)  = 0d0

      do ifl=-6, 7
         if(xpdflh2(ifl).ne.0d0)then
            xf(ifl) = xf(ifl) * (xpdflh3(ifl)/xpdflh2(ifl))
         else
            xf(ifl) = 0d0
         endif
      enddo
         
      irepb = irep

      return
      end

********************************************************************************
