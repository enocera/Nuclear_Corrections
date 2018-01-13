********************************************************************************
*                                                                              *
*     This program tests the DSSZ grids                                        *
*                                                                              *
********************************************************************************

      program test_DSSZ
      implicit none

      integer ipt, npt
      parameter(npt=36)
      integer iset, nset
      
      double precision A, Z
      double precision x
      double precision Q, Q2
      double precision xpdflh1(-6:6), xpdflh2(-6:6)
      double precision RUV, RDV, RUB, RDB, RS, RC, RB, RG
      
      dimension x(npt)
      
      data x / 1d-4, 2d-4, 3d-4, 4d-4, 5d-4, 6d-4, 7d-4, 8d-4, 9d-4,
     1     1d-3, 2d-3, 3d-3, 4d-3, 5d-3, 6d-3, 7d-3, 8d-3, 9d-3,
     1     1d-2, 2d-2, 3d-2, 4d-2, 5d-2, 6d-2, 7d-2, 8d-2, 9d-2,
     1     1d-1, 2d-1, 3d-1, 4d-1, 5d-1, 6d-1, 7d-1, 8d-1, 9d-1 /

      character*100 pdfset

*     Initialise PDF set
      pdfset="DSSZ_NLO_Pb208"
      A = 208d0
      Z = 82d0
      call initPDFSetbynameM(1,pdfset)
      call initPDFSetbynameM(2,"MSTW2008nlo68cl")

*     Initialise energy scale
      Q2 = 10d0 !GeV2
      Q  = dsqrt(Q2)

*     Initialise x space
C      do ipt=1, npt
C         
C         if(ipt.le.npt/2)then
C            x(ipt)=xmin*(xch/xmin)**(2d0*dfloat(ipt-1)/dfloat(npt-1))
C         else
C            x(ipt)=xch+(xmax-xch)*(dble(ipt-npt/2-1)
C     1              /dble(npt-npt/2-1))
C         endif
C         
C      enddo
      
*     Initialise PDF memeber number
      call numberPDFM(1,nset)

*     Initialise central value
      call initPDFM(1,0)
      call initPDFM(2,0)
      call DSSZINI(0)

*     Compute the ratio R
      do ipt=1, npt
         
         call evolvepdfM(1,x(ipt),Q,xpdflh1)
         call evolvepdfM(2,x(ipt),Q,xpdflh2)
         call DSSZ(x(ipt),Q,A,RUV,RDV,RUB,RDB,RS,RC,RB,RG)
         
         write(*,*) ipt, x(ipt), !(xpdflh1(3)/xpdflh2(3)-RS)/RS*100, RS
     1        (( (Z-A) * xpdflh1(-1) + Z * xpdflh1(-2) ) /
     1        (xpdflh2(-2) * (2d0*Z - A))-RUB)/RUB*100, RUB


      enddo


      stop
      end


