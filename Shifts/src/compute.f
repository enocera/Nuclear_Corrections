****************
*
*
*
****************

      program compute
      implicit none

      integer iexp, nexp
      parameter(nexp=3)
      integer iset, nset(nexp), mxset
      parameter(mxset=2)
      integer KAPPA(nexp,mxset), ka, kp
      integer isys, nsys(nexp,mxset), mxsys
      parameter(mxsys=915)
      integer idat, ndat(nexp,mxset), mxdat
      parameter(mxdat=417)
      integer idum
      integer step

      double precision A(mxsys,mxsys,nexp,mxset), B(mxsys,nexp,mxset)
      double precision sys_abs(nexp,mxset,mxdat,mxsys)
      double precision sys_rel(nexp,mxset,mxdat,mxsys)
      double precision ddum
      double precision r(nexp,mxset,mxsys)
      double precision delta(nexp,mxset,mxdat)
      double precision beta(nexp,mxset,mxdat,mxsys)

      character*10  cdum
      character*100 infileA(nexp,mxset), infileB(nexp,mxset)
      character*100 datafile(nexp,mxset)
      character*100 outfile(nexp,mxset)
      character*20  nameset(nexp,mxset)

*     Define nset
      nset(1)=2
      nset(2)=2
      nset(3)=1

*     Define nameset
      nameset(1,1)="CHORUSNU"
      nameset(1,2)="CHORUSNB"
      nameset(2,1)="NTVNUDMN"
      nameset(2,2)="NTVNBDMN"
      nameset(3,1)="DYE605"

*     Define infiles
      do iexp=1,nexp
         do iset=1, nset(iexp)
            write(infileA(iexp,iset),101) "../res/Ainv_",
     1           trim(nameset(iexp,iset)), ".dat"
            write(infileB(iexp,iset),101) "../res/B_",
     1           trim(nameset(iexp,iset)), ".dat"
            write(datafile(iexp,iset),101) "../data/DATA_",
     1           trim(nameset(iexp,iset)), "nucl.dat"
         enddo
      enddo

*     Define outfiles
      do iexp=1, nexp
         do iset=1, nset(iexp)
            write(outfile(iexp,iset),101) "../res/",
     1           trim(nameset(iexp,iset)), "_shifts.dat"
         enddo
      enddo

*     Read infiles
      do iexp=1, nexp
         do iset=1, nset(iexp)
            open(unit=10, status="old", file=trim(infileA(iexp,iset)))
            open(unit=20, status="old", file=trim(infileB(iexp,iset)))
            open(unit=40, status="old", file=trim(datafile(iexp,iset)))
            read(20,*) KAPPA(iexp,iset)
            do ka=1, KAPPA(iexp,iset)
               read(20,*) B(ka,iexp,iset)
               read(10,*) (A(ka,kp,iexp,iset), kp=1, KAPPA(iexp,iset))
            enddo
            read(40,*) cdum, nsys(iexp,iset), ndat(iexp,iset)
            do idat=1, ndat(iexp,iset)
               read(40,*) idum, cdum, ddum, ddum, ddum, ddum, ddum,
     1              (sys_abs(iexp,iset,idat,isys), 
     1               sys_rel(iexp,iset,idat,isys), 
     1               isys=1,nsys(iexp,iset))
            enddo
            close(10)
            close(20)
            close(40)
         enddo
      enddo

*     Rescale beta index
      do iexp=1, nexp
         do iset=1, nset(iexp)
            do idat=1, ndat(iexp,iset)
               step=nsys(iexp,iset)-KAPPA(iexp,iset)
               do ka=1, KAPPA(iexp,iset)
                  isys=ka+step
                  beta(iexp,iset,idat,ka)=sys_abs(iexp,iset,idat,isys)
               enddo
            enddo
         enddo
      enddo

*     Compute rks
      do iexp=1, nexp
         do iset=1, nset(iexp)
            do ka=1, KAPPA(iexp,iset)
               r(iexp,iset,ka)=0d0
               do kp=1, KAPPA(iexp,iset)
                  r(iexp,iset,ka) = r(iexp,iset,ka) 
     1                 + A(ka,kp,iexp,iset)*B(kp,iexp,iset)
               enddo
            enddo
         enddo
      enddo

*     Compute shifts
      do iexp=1, nexp
         do iset=1, nset(iexp)
            do idat=1, ndat(iexp,iset)
               delta(iexp,iset,idat)=0d0
               do ka=1, KAPPA(iexp,iset)
                  delta(iexp,iset,idat) = delta(iexp,iset,idat)
     1                 + r(iexp,iset,ka)*beta(iexp,iset,idat,ka)
               enddo
            enddo
         enddo
      enddo

*     Write results on file
      do iexp=1, nexp
         do iset=1, nset(iexp)
            open(unit=30, status="unknown", file=outfile(iexp,iset))
            do idat=1, ndat(iexp,iset)
               write(30,102) idat, delta(iexp,iset,idat)
            enddo
            close(30)
         enddo
      enddo


 101  format(a,a,a)
 102  format(i5,f12.7)

      stop
      end
