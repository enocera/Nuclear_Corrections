C *********************************************************************
      PROGRAM SAMPLE
C ---------------------------------------------------------------------
      IMPLICIT REAL*8(A-H,O-Z)
      PARAMETER (NX=200, NPAR=12)
      DIMENSION DNPDF(-4:4), GRAD(-4:4,12)
     >          ,E(-4:4), AA(12,9)

      DATA XMIN,XMAX/1.D-3,1.D0/
      DATA Q2/1.D0/ 
      DATA IORDER/2/
      DATA ISET/9/

      COMMON/ERRM/EM(12,12)   ! Error matrix: Dchi^2*H_ij^-1
                              ! EM(12,12) is defined in npdf07e.f

      XLSTEP=(DLOG10(XMAX)-DLOG10(XMIN))/DFLOAT(NX)
      DO L=1,NX+1
        DLOGX=DFLOAT(L-1)*XLSTEP+DLOG10(XMIN)
        X=10.D0**(DLOGX)

        Call HKNNPDF(Q2,X,ISET,IORDER,DNPDF,GRAD)
C     DNPDF(I) --> nuclear parton distribution functions. 
C      I = -4 ... c-bar quark (c-bar = c)
C          -3 ... s-bar quark
C          -2 ... d-bar quark
C          -1 ... u-bar quark
C           0 ... gluon
C           1 ... u quark
C           2 ... d quark
C           3 ... s quark
C           4 ... c quark

C NOTE: Please avoid using write(20), write(21), read(20), read(21)
C       because 20 and 21 are used in the SUBROUTINE HKNNPDF(...).
C       If you cannot avoid 20 and 21, you may change IFILE=20
C       in the beginning of SUBROUTINE HKNNPDF(...):
C       PARAMETER (NQ=33, NX=117, ND=94, NFF=7, IFILE=20,NPAR=12).
C       IFILE=20 and IFILE+1=21 are used in HKNNPDF(...).

        Write(12,1010) X,(DNPDF(I),I=-4,4)

        DO J=1,9
          E(J-5)=0.D0
          DO I=1,NPAR
            AA(I,J)=0.D0
          ENDDO
        ENDDO

C Calculating the uncertainties of NPDFs by the Hessian method
       DO N=1,9
          EE=0.D0
          DO I=1,NPAR 
            DO J=1,NPAR
                K=N-5
              AA(I,N)=AA(I,N)+EM(I,J)*GRAD(K,J)
            ENDDO
            EE=EE+GRAD(K,I)*AA(I,N)
          ENDDO
          E(N-5)=DSQRT(EE)
        ENDDO
C     E(I) --> uncertainties of nuclear parton distribution functions.
C      I = -4 ... c-bar quark (c-bar = c)
C          -3 ... s-bar quark
C          -2 ... d-bar quark
C          -1 ... u-bar quark
C           0 ... gluon
C           1 ... u quark
C           2 ... d quark
C           3 ... s quark
C           4 ... c quark 
        Write(13,1010) X,(E(I),I=-4,4)

      ENDDO
 1010 FORMAT(' ', 10(1PE12.3))

      STOP
      END
C *********************************************************************
C THE END OF THE PROGRAM.
C *********************************************************************

