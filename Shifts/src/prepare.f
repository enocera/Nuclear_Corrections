********************************************************************************
*                                                                              *
*     prepare.f                                                                *
*     This program computes the matrix A and the array B needed to determine   *
*     the optimal shifts                                                       *
*     Input from ../data/DATA_*                                                *
*                ../data/systype/SYSTYPE_*                                     *
*                ../theory/*                                                   *
*     Output to ../res/A_*                                                     *
*               ../res/B_*                                                     *
*                                                                              *
********************************************************************************

      program prepare
      implicit none

      integer iexp, nexp
      parameter(nexp=3)
      integer iset, nset(nexp), mxset
      parameter(mxset=2)
      integer isys, nsys(nexp,mxset), mxsys
      parameter(mxsys=915)
      integer idat, ndat(nexp,mxset), mxdat
      parameter(mxdat=417)
      integer idum
      integer nsyscor(nexp,mxset)
      integer nsysunc(nexp,mxset)
      integer k, kprime, kappa, kappaprime

      double precision D(nexp,mxset,mxdat)
      double precision T(nexp,mxset,mxdat)
      double precision stat(nexp,mxset,mxdat)
      double precision sys_abs(nexp,mxset,mxdat,mxsys)
      double precision sys_rel(nexp,mxset,mxdat,mxsys)
      double precision ddum
      double precision alpha2(nexp,mxset,mxdat)
      double precision A(nexp,mxset,mxsys,mxsys)
      double precision B(nexp,mxset,mxsys)

      character*10 cdum
      character*15 nameset(nexp,mxset)
      character*100 datafile(nexp,mxset)
      character*100 theoryfile(nexp,mxset)
      character*100 sysfile(nexp,mxset)
      character*20 namesys
      character*40 outfileA(nexp,mxset), outfileB(nexp,mxset)
      
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
      do iexp=1, nexp
         do iset=1, nset(iexp)
            write(datafile(iexp,iset),101) "../data/DATA_",
     1           trim(nameset(iexp,iset)), "nucl.dat"
            write(sysfile(iexp,iset),101) "../data/systype/SYSTYPE_",
     1           trim(nameset(iexp,iset)), "nucl_DEFAULT.dat"
            write(theoryfile(iexp,iset),102) "../theory/NucUnc/output/",
     1           "tables/experiments",iexp-1,"_",
     1           trim(nameset(iexp,iset)),
     1           "nucl_experiment_result_table.csv"
         enddo
      enddo

*     Define outfiles
      do iexp=1, nexp
         do iset=1, nset(iexp)
            write(outfileA(iexp,iset),101) "../res/A_",
     1           trim(nameset(iexp,iset)), ".dat"
            write(outfileB(iexp,iset),101) "../res/B_",
     1           trim(nameset(iexp,iset)), ".dat"
         enddo
      enddo      

*     Read data from files
      write(*,*) "Reading data from files"
      do iexp=1, nexp
         do iset=1, nset(iexp)
            open(unit=10, status="old", file=datafile(iexp,iset))
            open(unit=20, status="old", file=sysfile(iexp,iset))
            open(unit=50, status="old", file=theoryfile(iexp,iset))
            read(10,*) cdum, nsys(iexp,iset), ndat(iexp,iset)
            read(20,*) idum
            read(50,*) cdum
            do idat=1, ndat(iexp,iset)
               read(10,*) idum, cdum, ddum, ddum, ddum,
     1              D(iexp,iset,idat), stat(iexp,iset,idat),
     1              (sys_abs(iexp,iset,idat,isys), 
     1               sys_rel(iexp,iset,idat,isys), 
     1               isys=1,nsys(iexp,iset))
               read(50,*) cdum, cdum, idum, ddum, T(iexp,iset,idat)
            enddo
            nsyscor(iexp,iset) = nsys(iexp,iset)
            nsysunc(iexp,iset) = 0
            do isys=1, nsys(iexp,iset)
               read(20,*) idum, cdum, namesys
               if(trim(namesys).eq."UNCORR")then
                  nsyscor(iexp,iset) = nsyscor(iexp,iset) - 1
                  nsysunc(iexp,iset) = nsysunc(iexp,iset) + 1
               endif
            enddo
            close(10)
            close(20)
            close(50)
         enddo
      enddo

*     Compute alpha2
      write(*,*) "Computing alpha2"
      do iexp=1, nexp
         do iset=1, nset(iexp)
            do idat=1, ndat(iexp,iset)
               alpha2(iexp,iset,idat)=stat(iexp,iset,idat)**2d0
               do isys=1, nsysunc(iexp,iset)
                  alpha2(iexp,iset,idat) = alpha2(iexp,iset,idat)
     1                 + sys_abs(iexp,iset,idat,isys)**2d0
               enddo
            enddo
         enddo
      enddo

*     Compute A and B
      write(*,*) "Computing A and B"
      do iexp=1, nexp
         do iset=1, nset(iexp)
            do k=1, nsyscor(iexp,iset)-nsysunc(iexp,iset)
               kappa=k+nsysunc(iexp,iset)
               do kprime=1, nsyscor(iexp,iset)-nsysunc(iexp,iset)
                  kappaprime=kprime+nsysunc(iexp,iset)
                  if(k.eq.kprime)then
                     A(iexp,iset,k,kprime)=1d0
                  else
                     A(iexp,iset,k,kprime)=0d0
                  endif
                  do idat=1, ndat(iexp,iset)
                     A(iexp,iset,k,kprime) = A(iexp,iset,k,kprime) 
     1                    + (sys_abs(iexp,iset,idat,kappa)
     1                    *  sys_abs(iexp,iset,idat,kappaprime))
     1                    / alpha2(iexp,iset,idat)
                  enddo
               enddo
               B(iexp,iset,k)=0d0
               do idat=1,ndat(iexp,iset)
                  B(iexp,iset,k) = B(iexp,iset,k)
     1                 + sys_abs(iexp,iset,idat,kappa)
     1                 * (D(iexp,iset,idat)-T(iexp,iset,idat))
     1                 / alpha2(iexp,iset,idat)
               enddo
            enddo
         enddo
      enddo

*     Write results on file
      write(*,*) "Writing results on file"
      do iexp=1, nexp
         do iset=1, nset(iexp)
            open(unit=30, status="unknown", file=outfileA(iexp,iset))
            open(unit=40, status="unknown", file=outfileB(iexp,iset))
            write(40,105) nsyscor(iexp,iset)-nsysunc(iexp,iset)
            do k=1, nsyscor(iexp,iset)-nsysunc(iexp,iset)
               write(30,103)  ( A(iexp,iset,k,kprime),
     1              kprime=1, nsyscor(iexp,iset)-nsysunc(iexp,iset))
               write(40,104) B(iexp,iset,k)
            enddo
            close(30)
            close(40)
         enddo
      enddo

 101  format(a,a,a)
 102  format(a,a,i1,a,a,a)
 103  format(1000(f15.5))
 104  format(f15.5)
 105  format(i6)

      stop
      end
