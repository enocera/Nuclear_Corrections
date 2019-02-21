********************************************************************************
*                                                                              *
*     compute.f                                                                *
*     This program computes the optimal shifts                                 *
*     Input from ../A_*                                                        *
*                ../B_*                                                        *
*                ../Ainv_*                                                     *
*                ../data/DATA_*                                                *
*     Output to  ../res/[nameset]_shifts.dat                                   *
*                                                                              *
********************************************************************************

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
      parameter(mxdat=610)
      integer idum
      integer step
      integer ilbl, nlbl
      parameter(nlbl=2)

      double precision A(mxsys,mxsys,nexp,mxset,nlbl)
      double precision B(mxsys,nexp,mxset,nlbl)
      double precision sys_abs(nexp,mxset,nlbl,mxdat,mxsys)
      double precision sys_rel(nexp,mxset,nlbl,mxdat,mxsys)
      double precision ddum
      double precision r(nexp,mxset,nlbl,mxsys)
      double precision delta(nexp,mxset,nlbl,mxdat)
      double precision beta(nexp,mxset,nlbl,mxdat,mxsys)
      double precision orshif(nexp,mxset,mxdat)

      character*10  cdum
      character*100 infileA(nexp,mxset,nlbl)
      character*100 infileB(nexp,mxset,nlbl)
      character*100 datafile(nexp,mxset,nlbl)
      character*100 outfile(nexp,mxset)
      character*20  nameset(nexp,mxset)
      character*100 shiftfile(nexp,mxset)
      character*6 lbl(nlbl)

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

*     Define lbl
      lbl(1)="NucUnc"
      lbl(2)="NucCor"

*     Define infiles
      do iexp=1,nexp
         do iset=1, nset(iexp)
            do ilbl=1, nlbl
               write(infileA(iexp,iset,ilbl),101) "../res/Ainv_",
     1              trim(nameset(iexp,iset)), 
     1              "_", trim(lbl(ilbl)),".dat"
               write(infileB(iexp,iset,ilbl),101) "../res/B_",
     1              trim(nameset(iexp,iset)), 
     1              "_",trim(lbl(ilbl)),".dat"
               if(ilbl.eq.1)then
                  write(datafile(iexp,iset,ilbl),101) "../data/DATA_",
     1                 trim(nameset(iexp,iset)), "nucl.dat"
               elseif(ilbl.eq.2)then
                  write(datafile(iexp,iset,ilbl),101) "../data/DATA_",
     1                 trim(nameset(iexp,iset)), "nuclshift.dat"
               endif
            enddo
            write(shiftfile(iexp,iset),101) 
     1           "../res/shifts_new_",
     1           trim(nameset(iexp,iset)),".res"
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
            do ilbl=1, nlbl
               open(unit=10, status="old", 
     1              file=trim(infileA(iexp,iset,ilbl)))
               open(unit=20, status="old", 
     1              file=trim(infileB(iexp,iset,ilbl)))
               open(unit=40, status="old", 
     1              file=trim(datafile(iexp,iset,ilbl)))
               read(20,*) KAPPA(iexp,iset)
               do ka=1, KAPPA(iexp,iset)
                  read(20,*) B(ka,iexp,iset,ilbl)
                  read(10,*) (A(ka,kp,iexp,iset,ilbl), 
     1                 kp=1, KAPPA(iexp,iset))
               enddo
               read(40,*) cdum, nsys(iexp,iset), ndat(iexp,iset)
               do idat=1, ndat(iexp,iset)
                  read(40,*) idum, cdum, ddum, ddum, ddum, ddum, ddum,
     1                 (sys_abs(iexp,iset,ilbl,idat,isys), 
     1                 sys_rel(iexp,iset,ilbl,idat,isys), 
     1                 isys=1,nsys(iexp,iset))
               enddo
               close(10)
               close(20)
               close(40)
            enddo
         enddo
      enddo

*     Read original shifts
      do iexp=1, nexp
         do iset=1, nset(iexp)
            open(unit=60,status="old",file=shiftfile(iexp,iset))
            do idat=1, ndat(iexp,iset)
               read(60,*) idum, orshif(iexp,iset,idat)
            enddo
            close(60)
         enddo
      enddo

*     Rescale beta index
      do iexp=1, nexp
         do iset=1, nset(iexp)
            do ilbl=1, nlbl
               do idat=1, ndat(iexp,iset)
                  step=nsys(iexp,iset)-KAPPA(iexp,iset)
                  do ka=1, KAPPA(iexp,iset)
                     isys=ka+step
                     beta(iexp,iset,ilbl,idat,ka)
     1                    = sys_abs(iexp,iset,ilbl,idat,isys)
                  enddo
               enddo
            enddo
         enddo
      enddo

*     Compute rks
      do iexp=1, nexp
         do iset=1, nset(iexp)
            do ilbl=1, nlbl
               do ka=1, KAPPA(iexp,iset)
                  r(iexp,iset,ilbl,ka)=0d0
                  do kp=1, KAPPA(iexp,iset)
                     r(iexp,iset,ilbl,ka) = r(iexp,iset,ilbl,ka) 
     1                    + A(ka,kp,iexp,iset,ilbl)*B(kp,iexp,iset,ilbl)
                  enddo
               enddo
            enddo
         enddo
      enddo

*     Compute shifts
      do iexp=1, nexp
         do iset=1, nset(iexp)
            do ilbl=1, nlbl
               do idat=1, ndat(iexp,iset)
                  delta(iexp,iset,ilbl,idat)=0d0
                  do ka=1, KAPPA(iexp,iset)
                     delta(iexp,iset,ilbl,idat)  
     1                    = delta(iexp,iset,ilbl,idat)
     1                    + r(iexp,iset,ilbl,ka)
     1                    * beta(iexp,iset,ilbl,idat,ka)
                  enddo
               enddo
            enddo
         enddo
      enddo

*     Write results on file
      do iexp=1, nexp
         do iset=1, nset(iexp)
            open(unit=30, status="unknown", file=outfile(iexp,iset))
            do idat=1, ndat(iexp,iset)
               write(30,102) idat, 
     1              delta(iexp,iset,1,idat),
     1              delta(iexp,iset,2,idat),
     1              orshif(iexp,iset,idat)
     
            enddo
            close(30)
         enddo
      enddo

 101  format(a,a,a,a,a)
 102  format(i5,3(f12.7))

      stop
      end
