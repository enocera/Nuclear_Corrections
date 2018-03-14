// MCGEN: generates a requested number of Monte-Carlo replicas from 
// input Monte-Carlo or Hessian error PDFs. Saves them in the form of 
// LHAPDF6 grids and .plt files for conversion into meta-parametrizations
// 
// Author: Jun Gao, Pavel Nadolsky
// 
// Description: ninput PDF sets are read from the input LHAPDF6 grid. If the
// input PDFs are Hessian, nmc output replicas are generated by random 
// displacements of the input replilcas, distributed according 
// to a Gaussian distribution. If the input PDFs are 
// Monte-Carlo ones, nmc input replicas are just copied into 
// the output replicas. The x values, Q values, and random displacement 
// values  are read from input files in the ../inc directory: 
// xgrid-lha6.dat, qgrid-lha6.dat, randnum_xxx.dat, etc.
// Optionally, a parameter nstart can be passed to force generation to 
// begin from the nstart-th replica in the (always hard-wired) 
// random sequence.   
//
//
// History
// 2017-01-10 PN Fixed writing the values for x=1
// 2016-06-06 PN A cleaned-up version for public release
//========================================================================
#include "LHAPDF/LHAPDF.h"

#include <string>
#include <vector>
#include <map>
#include <iomanip>
#include <iostream>
#include <fstream>
#include <math.h>
#include <time.h>
#include <boost/foreach.hpp>
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>

using namespace std;
using namespace boost::algorithm;

//========================================================================

string cardname="mcgen.card",inpdfname="CT14nnlo", outpdfname="mcCT14nnlo", 
       err_type="he90";
string xlhaname="../inc/xgrid-lha6.dat", qlhaname="../inc/qgrid-lha6.dat", 
       xpltname="../inc/xgrid-plt.dat", qpltname="../inc/qgrid-plt.dat"; 
unsigned short int nmc=100, nstart=1;
short int nsym=1, nshift=0, ktype=1;
const double small=1.0e-10;

int MCread_card();
int MCGenerateLHAPDF();
int MCLHAPDF2plt();
int MCStdDevs();
int MCaverage(int argc, char* argv[]);
int MCadd(int argc, char* argv[]);



int main(int argc, char* argv[]) 
{
//========================================================================
  if (argc < 3){
    cout << "Usage examples"<<endl;
    cout << "   mcgen.x generate mcgen.card" <<endl;
    cout << "   mcgen.x convert LHAPDF_set" <<endl;
    cout << "   mcgen.x std_devs LHAPDF_set error_type" <<endl;
    cout << "   mcgen.x average average.dat input1.dat input2.dat ..." <<endl;
    cout << "   mcgen.x add sum.dat input1.dat input2.dat w1 w2" <<endl;
    cout << "   mcgen.x multiply prod.dat input1.dat input2.dat power1 power2" <<endl;
    cout << "Stop: too few parameters passed to mcgen" << endl;
    exit(1);
  }

  if (strcmp(argv[1],"generate")==0) {//Generate random replicas,
    //by reading parameters from the input card cardname;
    cardname=argv[2];
    MCread_card(); //Read parameters from the input card
    MCGenerateLHAPDF();
  }
  else if (strcmp(argv[1],"convert")==0) {//Create .plt grids from 
    //LHAPDF6 grids
    inpdfname=argv[2];
    MCLHAPDF2plt();
  }
  else if (strcmp(argv[1],"std_devs")==0) {//Create .er files containing
    //standard deviations for PDFs and other miscellaneous information
    if (argc < 4){
      cout << "Stop: too few parameters passed to mcgen" << endl;
      cout << "Usage: mcgen.x std_devs LHAPDF_set error_type" <<endl;
      exit(1);
    }

    inpdfname=argv[2];
    err_type=argv[3];
    MCStdDevs();
  }
  else if (strcmp(argv[1],"average")==0){ //Compute the zeroth replica,
    //equal to the MC average of all non-zero replicas in the MC ensemble
    if (argc < 5){
      cout << "Stop: too few parameters passed to mcgen" << endl;
      cout << "Usage: mcgen.x average average.dat input1.dat input2.dat ..." <<endl;
      exit(1);
    }

    MCaverage(argc, argv);
  }
  else if ((strcmp(argv[1],"add")==0) ||
           (strcmp(argv[1],"multiply")==0))
    { //Add or multiply two LHAPDF grids
    if (argc < 5){
      cout << "Stop: too few parameters passed to mcgen" << endl;
      cout << "Usage: mcgen.x add sum.dat input1.dat input2.dat w1 w2" <<endl;
      cout << "Usage: mcgen.x multiply prod.dat input1.dat input2.dat power1 power2" <<endl;
      exit(1);
    }

    MCadd(argc, argv);
  }
  else{
    cout << "mcgen does not recognize requested operation "<<argv[1]<< endl;
    exit(1);
  }
  
  return 0;
}//main -> ==============================================================


int MCread_card()
//Read parameters of the calculation from an input card
//========================================================================
{
  string dummy;
  
  cout << "Reading parameters from the input card" << endl;
  ifstream infile(cardname.c_str());

  if(infile.fail()){
    cout << "Problem with reading " << cardname <<endl;
    exit(1);
  }

  getline (infile, dummy);   getline (infile, dummy);
  getline( infile, inpdfname,'#'); getline (infile, dummy);
  trim_right(inpdfname); //input PDF name
  getline( infile, outpdfname,'#'); getline (infile, dummy);
  trim_right(outpdfname); //output PDF name
  getline( infile, err_type,'#'); getline (infile, dummy);
  trim_right(err_type);  //error type (Hessian/MC)
  
  infile >> nmc; getline (infile, dummy); //number of MC replicas to generate
  infile >> nstart; getline (infile, dummy); //the starting random number
  infile >> ktype; getline (infile, dummy); //type of the replicas;
  nsym = ktype % 10; //symmetric or asymmetric PDF error
  nshift = abs(ktype/10); //shifted replicas or not
  getline( infile, xlhaname,'#'); getline (infile, dummy); //grid of output x values
  trim_right(xlhaname); 
  getline( infile, qlhaname,'#'); getline (infile, dummy); //grid of output Q values
  trim_right(qlhaname); 
  
  infile.clear();
  infile.close();

  return 0;
}//MCread_card -> ========================================================


int MCGenerateLHAPDF()
//Generate LHAPDF files for MC replicas
//========================================================================
{
  const int LHAPDFflavors[]={-5,-4,-3,-2,-1,1,2,3,4,5,21}; 
                                 //PDF flavors to write to the LHAPDF grid
  const int nfltot = 11; //Maximal number of PDF flavors
  
  vector<double> xgrid, qgrid; //Vectors with x and Q values
  double num, ErrorScaling,pdiff;

  int nxtot = 0, nqtot=0, iran, nmcmax;

  ifstream infile;      //input file stream
  ofstream outfile;     //output file stream
  vector<double> rn; //array with random displacements

  vector<vector<vector<vector<double> > > > pdfin, pdfout;
  vector<vector<vector<double> > > mean, var;

  //Prepare random displacements for conversion of Hessian replicas
  if (strcmp(err_type.c_str(),"he90")==0)
    ErrorScaling=1/1.65; 
  else if (strcmp(err_type.c_str(),"dssz")==0)
    ErrorScaling=5.477225575/2;
  else 
    ErrorScaling=1.0;
  
   //Open the LHAPDF6 object for the input PDFs 
  LHAPDF::PDFSet set(inpdfname);
  const int nmem=set.size()-1; //number of PDF sets in the input PDF ensemble, 
                             //including the zeroth set
  vector<LHAPDF::PDF*> pdfs = set.mkPDFs();
  
  //For Monte-Carlo input replicas, check that the number of required replicas
  //does not exceed the number of input replicas
  if (strcmp(err_type.c_str(),"mc")==0) 
    {
      nmcmax = nstart + nmc -1; //maximal number of the input replicas
      if (nmcmax > nmem)
        {
          cout << "GenerateMCLHAPDF: The number of final replicas exceeds "<<
            "the number of input member sets in the LHAPDF grid"<<endl;
          cout << "Number of input member sets = "<<nmem;
          cout << "Number of final replicas, # of replicas to skip = "
               <<nmc<<", "<<nstart << endl;
          exit(1);
        }//if (nmcmax > nmem..
    }//if err_type == "mc"

  //For Hessian input replicas, read in enough random numbers from an external file 
  //randnum_gaussian.dat. The file contains random numbers from a standard 
  //normal distribution defined on the interval (-infty, infty). 
  string fname="../inc/randnum_gaussian.dat";
  if (err_type != "mc")
    {
      //number of random seeds that have been read, to skip at the beginning,
      //and to read in total
      iran = 0; 
      int nskip = (nstart-1)*nmem;
      nmcmax = nmc*nmem;
      int nstop= nskip + nmcmax;
  
      infile.open(fname.c_str());

      while (infile.good() &&
             (iran < nstop) )
        {
          infile >> num;
          if (iran > nskip)
            rn.push_back(num);
          iran++;
        }
      infile.clear();
      infile.close();
      
      if(iran < nstop)
        {
          cout << "GenerateMCPLT: Not enough input random displacements" <<endl; 
          cout << "Reduce the number of final replicas or starting number" << endl;
          exit(1);
        }
    }//if err_type != "mc"

  //Read hardwired x values for the final LHAPDF6 grid
  infile.open(xlhaname.c_str());

  while (infile.good()) {  
    infile >> num;
    xgrid.push_back(num);
    nxtot++;
  }
  //pn 2016
  if (xgrid[nxtot-1] > 0.99) 
    xgrid[nxtot-1] = 1.0;

  infile.clear();
  infile.close();
  
  //Read hardwired Q values for the final LHAPDF6 grid
  infile.open(qlhaname.c_str());

  while (infile >> num) {  
    qgrid.push_back(num);
    nqtot++;
  }
  infile.clear();
  infile.close();

  //Prepare an array pdfin to store input PDFs (nqtot x nxtot x nfltot)
  pdfin.resize(nqtot);
  pdfout.resize(nqtot);
  mean.resize(nqtot);
  var.resize(nqtot);

  for (int iq=0; iq<nqtot; ++iq) {
    pdfin[iq].resize(nxtot);     
    pdfout[iq].resize(nxtot);     
    mean[iq].resize(nxtot); 
    var[iq].resize(nxtot); 
    for (int ix=0; ix<nxtot; ++ix) {
      pdfin[iq][ix].resize(nfltot);
      pdfout[iq][ix].resize(nfltot);
      mean[iq][ix].resize(nfltot);
      var[iq][ix].resize(nfltot);
      for (int ifl=0; ifl<nfltot; ++ifl) {
        pdfin [iq][ix][ifl].resize(nmem+1);
        pdfout[iq][ix][ifl].resize(nmc +1);
      }//for (int ifl
    }//for (int ix
  }// for (int iq


  //Read the input PDFs into array pdfin
  int ninput = 0;

  BOOST_FOREACH (LHAPDF::PDF *p, pdfs) {
    for (int iq=0; iq<nqtot; ++iq) {
      double q=qgrid[iq];

      for (int ix=0; ix<nxtot; ++ix) {
        double x=xgrid[ix];

        for (int ifl=0; ifl<nfltot; ++ifl) {
          
          int pid=LHAPDFflavors[ifl];
          double xf = p->xfxQ(pid, x, q);
          if(abs(nsym) == 2) 
            { //pn2016 check the positivity, sample the log of the PDF
              if (xf < 0) 
                {
                  cout << "Error: log-normal sampling requires positive PDFs"<< endl;
                  cout << "pid, x, q, xf ="<<pid<<", "<<x<<", "<<q<<", "<<xf<<endl;
                  exit(1);
                }
              else 
                if (fabs(xf) < small*x)
                  xf = small*x;              
              
              pdfin[iq][ix][ifl][ninput]=log(xf);               
            }
          else //sample the PDF itself
            pdfin[iq][ix][ifl][ninput]=xf; 
          
        }//for (int ifl
      }//  for (int ix
     }// for (int iq=0

    //pn 2017
    //cout << "g(0.15,1.3) ="  << pdfin[0][95][nfltot-1][ninput] << endl;
    ninput++;
    
    delete p;
  }//foreach (LHAPDF::PDF* p, pdfs)

  //Create LHAPDF6 .dat file for each final MC replica. 
  //imc denotes the ID of the output MC replica. The zeroth output replica, 
  //corresponding to imc=0, is just the copied zeroth set of the input set
  iran=0;
  for (int imc=0; imc < nmc+1; ++imc) {
    
    double rr[nmem/2];
    if( err_type != "mc")
      for (int imem=1; imem <= nmem/2; imem++)
        rr[imem] =  rn[iran++]*ErrorScaling;
    
    for (int ix=0; ix<nxtot-1; ++ix) { //ix=nxtot always gives pdf=0 below
      for (int iq=0; iq<nqtot; ++iq) {
        
        for (int ifl=0; ifl<nfltot; ++ifl) {
          
          if (strcmp(err_type.c_str(),"mc")==0) //input MC replicas: 
            //copy a replica with an offset and finish the cycle
            {
              pdfout[iq][ix][ifl][imc]=pdfin[iq][ix][ifl][imc+nstart-1];
              continue;
            }//input MC replicas

          //Generate Hessian replicas
          if ( imc==0 ) //zeroth output replica = zeroth input replica
            {
              pdfout[iq][ix][ifl][imc]=pdfin[iq][ix][ifl][0];
              mean[iq][ix][ifl]=0.0; //Start accumulating mean
              var[iq][ix][ifl]=0.0;   //and variance
            } 
          else 
            if (imc < nmc ) {
              double f0, fm, fp, df1, df2, pout[15];
              f0=pdfin[iq][ix][ifl][0];
              pout[ifl]=f0;

              for(int l=1; l<=nmem/2; l++) 
                {               
                  fm=pdfin[iq][ix][ifl][2*l-1];
                  fp=pdfin[iq][ix][ifl][2*l];
                  
                  if (nsym == -3) 
                    {      //Watt-Thorne'2012 asym. error                    
                      if (rr[l] > 0) //choose positive error
                        pdiff=fp-f0;
                      else         //choose negative error
                        pdiff=fm-f0;
                      pout[ifl] += pdiff*fabs(rr[l]); 
                      continue; 
                    }//nsym == -3
                  
                  //Default CT sequence: an estimate of the first derivative
                  df1=(fp-fm)/2.0;                
                  pout[ifl] += df1*rr[l];
                  
                  if (nsym < 0) //asymmetric errors;  
                    { //add an estimate of the second derivative
                      df2 = fp + fm - 2*f0;
                      pout[ifl] += 0.5*df2*rr[l]*rr[l];
                    } //asymmetric errors
                  //pn 2017
                  //if (ix == 95 && iq==0 && ifl == nfltot-1) 
                  //  cout << "imc, l, f0, fm, fp, rr, df, = "<<imc << " "<<l<<" "
                  //       <<f0<<" "<<fm<<" "<<fp<<" "<<rr[l]<<" "<< 
                  //    df1*rr[l]+0.5*df2*rr[l]*rr[l]<<endl;

                }//for (int l=1...

              pdfout[iq][ix][ifl][imc]=pout[ifl]; 
              mean[iq][ix][ifl] += pout[ifl];//accumulate the mean replica  
              var[iq][ix][ifl] += pout[ifl]*pout[ifl];//and the variance
            }
            else //imc = nmc; apply shifts if requested; 
                 //the last MC replica is the mean of all previous replicas 
              {
                mean[iq][ix][ifl] /= nmc;
                var[iq][ix][ifl] = var[iq][ix][ifl]/nmc 
                                  - mean[iq][ix][ifl]*mean[iq][ix][ifl];
                pdfout[iq][ix][ifl][imc] = mean[iq][ix][ifl];

                if(nshift != 0) 
                  for (int jmc=1; jmc < nmc+1; ++jmc)
                    {
                      double shift=pdfout[iq][ix][ifl][0] - mean[iq][ix][ifl];
                        if (abs(nsym) == 2) //additional contribution for the log shift
                          shift -= var[iq][ix][ifl]/2;

                        pdfout[iq][ix][ifl][jmc] += shift;
                    }//if(nshift != 0) 
              }//imc = nmc -1 

        }//for (int ifl=...
      }//for (int iq
    }//for (int ix
  }//for (int imc #1...
  

  //Create LHAPDF6 .dat file for each final MC replica. 
  //imc denotes the ID of the output MC replica. The zeroth output replica, 
  //corresponding to imc=-1, is just the copied zeroth set of the input set
  for (int imc=0; imc < nmc+1; ++imc) {
    
    //Generate the name of the .dat file
    if (imc<10) {
      fname=outpdfname+"_000"+boost::lexical_cast<string>(imc)+".dat";
    }
    else if (imc<100) {
      fname=outpdfname+"_00" +boost::lexical_cast<string>(imc)+".dat";
    }
    else if (imc<1000) {
      fname=outpdfname+"_0"  +boost::lexical_cast<string>(imc)+".dat";
    }
    else {
      fname=outpdfname+"_"   +boost::lexical_cast<string>(imc)+".dat";
    }

    //Write the header into the .dat file
    outfile.open(fname.c_str());
    outfile << "PdfType: central" <<endl;
    outfile << "Format: lhagrid1" <<endl;
    outfile << "---" <<endl;

    //Write the x grid into the .dat file
    for (int ix=0; ix<nxtot; ++ix) {
      if(ix==0) 
        outfile <<scientific<<setprecision(6)<< xgrid[ix];
      else 
        outfile <<" " <<scientific<<setprecision(6)<< xgrid[ix];
    }    

    outfile <<endl;
    
    //Write the Q grid into the .dat file
    for (int iq=0; iq<nqtot; ++iq) {
      if(iq==0) 
        outfile <<scientific<<setprecision(6)<< qgrid[iq];
      else 
        outfile <<" " <<scientific<<setprecision(6)<< qgrid[iq];
    }
    outfile <<endl;
    
    //Write the PDF values into the .dat file
    outfile << "-5 -4 -3 -2 -1 1 2 3 4 5 21" <<endl;
  
    for (int ix=0; ix<nxtot; ++ix) {
      for (int iq=0; iq<nqtot; ++iq) {       
        for (int ifl=0; ifl<nfltot; ++ifl) {
          
          if (ix==(nxtot-1)){ //last point; just write 0
            outfile <<setw(16)<< scientific <<setprecision(8)<<0.0;
            continue;
          }

          if (abs(nsym) == 2) //log-normal sampling
            pdfout[iq][ix][ifl][imc] = exp(pdfout[iq][ix][ifl][imc]);
          
          outfile <<setw(16)<< scientific <<setprecision(8)<<pdfout[iq][ix][ifl][imc];
        }//for (int ifl=...
        outfile <<endl;
      }//for (int iq
    }//for (int ix

    outfile << "---" <<endl;
    outfile.clear();
    outfile.close();
    
  }//for (int imc #2...
  

  return 0;
}//MCGenerateLHAPDF -> ===================================================

int MCLHAPDF2plt()
//Convert LHAPDF files into .plt files
//========================================================================
{

  const int inflavors[]={21,2,-2,1,-1,3,-3,4,5};
  //PDF flavors to read from the input grid
  const int nfltot = 9;
  
  vector<double> xgrid, xigrid, qgrid; //Vectors with x and Q values
  double num;
  int nxtot = 0, nqtot=0;

  ifstream infile;     //input file stream
  ofstream outfile;     //output file streams
  string fname;

  vector<vector<vector<vector<double> > > > pdfin;//stores input PDFs

  //Open the LHAPDF6 object for the input PDFs 
  LHAPDF::PDFSet set(inpdfname);
  vector<LHAPDF::PDF*> pdfs = set.mkPDFs();
  const int nmem=set.size()-1; //number of PDF sets in the input PDF ensemble, 
  //including the zeroth set

  //Read hardwired x values for .plt files
  infile.open(xpltname.c_str());

  while (infile.good()) {  
    infile >> num;
    xgrid.push_back(num);
    nxtot++;
  }
  infile.clear();
  infile.close();

  //Read hardwired Q values for the .plt grid
  infile.open(qpltname.c_str());
  while (infile >> num) {  
    qgrid.push_back(num);
    nqtot++;
  }
  infile.clear();
  infile.close();

  //Prepare an array pdfin to store input PDFs (nqtot x nxtot x nfltot)
  pdfin.resize(nqtot);

  for (int iq=0; iq<nqtot; ++iq) {
    pdfin[iq].resize(nxtot);
    
    for (int ix=0; ix<nxtot; ++ix) {
      pdfin[iq][ix].resize(nfltot);
      
      for (int ifl=0; ifl<nfltot; ++ifl) {
        pdfin[iq][ix][ifl].resize(nmem+1);
      }//for (int ifl
    }//for (int ix
  }// for (int iq


  //Read the input PDFs into array pdfin
  int ninput = 0;
  BOOST_FOREACH (LHAPDF::PDF* p, pdfs) {
    for (int iq=0; iq<nqtot; ++iq) {
      double q=qgrid[iq];
      for (int ix=0; ix<nxtot; ++ix) {
        double x=xgrid[ix];
        
        for (int ifl=0; ifl<nfltot; ++ifl) {
          
          int pid=inflavors[ifl];
          const double xf = p->xfxQ(pid, x, q);
          pdfin[iq][ix][ifl][ninput]=3.*pow(x, 2./3.)*xf; 
          
        }//for (int ifl
      }//  for (int ix
    }// for (int iq=0
    
    ninput++;
    
    delete p;
  }//foreach (LHAPDF::PDF* p, pdfs)

  //Create .plt file for each input replica. 
  //imc denotes the ID of the output MC replica. 
  for (int imc=0; imc < nmem+1; ++imc) {
    
    //Generate the name of the .plt file
    if (imc< 10) 
      fname=inpdfname+"_000"+boost::lexical_cast<string>(imc)+".plt";
    else if (imc< 100) 
      fname=inpdfname+"_00" +boost::lexical_cast<string>(imc)+".plt";    
    else if (imc<1000) 
      fname=inpdfname+"_0"  +boost::lexical_cast<string>(imc)+".plt";
    else 
      fname=inpdfname+"_"   +boost::lexical_cast<string>(imc)+".plt";
    
    //Write the header into the .dat file
    outfile.open(fname.c_str());
    
    for (int iq=0; iq<nqtot; ++iq) {
      double qq=qgrid[iq];
      outfile << "#   Q = "<<setw(15)<< scientific <<setprecision(6)<<qq<<endl;
      outfile << "# ZZ"<<endl;
      
      for (int ix=0; ix<nxtot; ++ix) {
        
        double pout[15]={};
        pout[0]=1.;
        pout[1]=xgrid[ix];
        
        for (int ifl=0; ifl<nfltot; ++ifl) 
          pout[2+ifl]=pdfin[iq][ix][ifl][imc];

        for (int ifl=0; ifl<15; ++ifl) 
          outfile <<setw(15)<< scientific <<setprecision(6)<<pout[ifl];
        outfile <<endl;
                
      }//for (int ix
    }//for (int iq

    outfile.clear();
    outfile.close();

  }//for (int imc...

  return 0;

}//MCLHAPDF2plt -> ==============================================================

int MCStdDevs()
//Compute central PDF values, standard deviations, and other miscellaneous
//information for the provided LHAPDF ensemble inpdfname. Write this information
//into inpdfname_ce.er, inpdfname_up.err, inpdfname_dn.err files. 
//========================================================================
{

  const int inflavors[]={21,2,-2,1,-1,3,-3,4,5};
  //PDF flavors to read from the input grid
  const int outflavors[]={-3,-2,-1,21,1,2,3,4,5}; 
  //PDF flavors to write into the output .plt
  const int nfltot = 9;
  
  vector<double> xgrid, xigrid, qgrid; //Vectors with x and Q values
  double num, ErrorScaling,auxu, auxd;
  int nxtot = 0, nixtot=0, nqtot=0, ierr;

  ifstream infile;     //input file stream
  ofstream outfile, outerrfile[3];     //output file streams
  
  const char* strarray[] = {"ce.err","up.err","dn.err"};
  vector <string> outerrname(strarray,strarray+3);
  
  vector<vector<vector<vector<double> > > > pdfin;//stores input PDFs
  vector<vector<vector<double> > > pdferr[3]; //store PDF errors
  vector<vector<vector<double> > > &pdfce=pdferr[0], //aliases for arrays
    &pdfu1=pdferr[1],  &pdfd1=pdferr[2];           //with PDF errors

  //Prepare random displacements for conversion of Hessian replicas
  if (strcmp(err_type.c_str(),"he90")==0)
    ErrorScaling=1/1.65; 
  else if (strcmp(err_type.c_str(),"dssz")==0)
    ErrorScaling=5.477225575/2; 
  else
    ErrorScaling=1.0; 

  //Open the LHAPDF6 object for the input PDFs 
  LHAPDF::PDFSet set(inpdfname);
  const int nmem=set.size()-1; //number of PDF sets in the input PDF ensemble, 
  //including the zeroth set
  vector<LHAPDF::PDF*> pdfs = set.mkPDFs();

  //Read hardwired x values for .plt files
  infile.open(xpltname.c_str());

  while (infile.good()) {  
    infile >> num;
    xgrid.push_back(num);
    nxtot++;
  }
  infile.clear();
  infile.close();

  //Read hardwired Q values for the final LHAPDF6 grid
  infile.open(qpltname.c_str());
  while (infile >> num) {  
    qgrid.push_back(num);
    nqtot++;
  }
  infile.clear();
  infile.close();

  //Read hardwired x values for .int file
  string fname="../inc/evo-xg.gd";
  infile.open(fname.c_str());

  while (infile.good()) {  
    infile >> num;
    xigrid.push_back(num);
    nixtot++;
  }
  infile.clear();
  infile.close();
  
  //Prepare an array pdfin to store input PDFs (nqtot x nxtot x nfltot)
  pdfin.resize(nqtot);
  for (ierr =0; ierr <=2; ierr++)
    pdferr[ierr].resize(nqtot); 
  
  for (int iq=0; iq<nqtot; ++iq) {
    pdfin[iq].resize(nxtot);
    for (ierr =0; ierr <=2; ierr++)
      pdferr[ierr][iq].resize(nxtot); 
  
    for (int ix=0; ix<nxtot; ++ix) {
      pdfin[iq][ix].resize(nfltot);
      for (ierr =0; ierr <=2; ierr++)
        pdferr[ierr][iq][ix].resize(nfltot); 
      
      for (int ifl=0; ifl<nfltot; ++ifl) {
        pdfin[iq][ix][ifl].resize(nmem+1);
      }//for (int ifl
    }//for (int ix
  }// for (int iq


  //Read the input PDFs into array pdfin
  int ninput = 0;
  BOOST_FOREACH (LHAPDF::PDF* p, pdfs) {
    for (int iq=0; iq<nqtot; ++iq) {
      double q=qgrid[iq];
      for (int ix=0; ix<nxtot; ++ix) {
        double x=xgrid[ix];
        
        for (int ifl=0; ifl<nfltot; ++ifl) {
          
          int pid=inflavors[ifl];
          const double xf = p->xfxQ(pid, x, q);
          pdfin[iq][ix][ifl][ninput]=3.*pow(x, 2./3.)*xf; 
          
        }//for (int ifl
      }//  for (int ix
    }// for (int iq=0

    if (ninput == 0)  { //Write the central PDF into a .int file
      fname=inpdfname+".int";
      outfile.open(fname.c_str());
      for (int ifl=0; ifl<nfltot; ++ifl) {
        int pid=outflavors[ifl];
        for (int ix=0; ix<nixtot; ++ix) {
          double x=xigrid[ix];
          const double ff = (p->xfxQ(pid, x, 8.))/x;
          outfile <<setw(15)<< scientific <<setprecision(6)<<ff;
        }
        outfile << endl;
      }
      outfile.clear();
      outfile.close();
    }//if (ninput == 0)

    ninput++;
    
    delete p;
  }//foreach (LHAPDF::PDF* p, pdfs)


  //Write input 68% c.l. errors into .er files 
  for (int iq=0; iq<nqtot; ++iq) {
    for (int ix=0; ix<nxtot; ++ix) {
      for (int ifl=0; ifl<nfltot; ++ifl) {

        //central PDF value
        pdfce[iq][ix][ifl]=pdfin[iq][ix][ifl][0];

        double sumup=0.0, sumdn=0.0;

        for (int n=1; n<=nmem/2; ++n){
          if (strcmp(err_type.c_str(),"mc")==0 ) { //MC symmetric errors
            auxu= (pdfin[iq][ix][ifl][2*n]-pdfin[iq][ix][ifl][0])
              *(pdfin[iq][ix][ifl][2*n]-pdfin[iq][ix][ifl][0])
              +(pdfin[iq][ix][ifl][2*n-1]-pdfin[iq][ix][ifl][0])
              *(pdfin[iq][ix][ifl][2*n-1]-pdfin[iq][ix][ifl][0]);
            auxd=auxu;
          }
          else {//Hessian asymmetric errors
            auxu=max( max( pdfin[iq][ix][ifl][2*n]  - pdfin[iq][ix][ifl][0],
                           pdfin[iq][ix][ifl][2*n-1]- pdfin[iq][ix][ifl][0]
                           ), 0.);
            auxd=max( max( pdfin[iq][ix][ifl][0] - pdfin[iq][ix][ifl][2*n],
                           pdfin[iq][ix][ifl][0] - pdfin[iq][ix][ifl][2*n-1]
                           ), 0.);
            auxu *=auxu; auxd *=auxd;
          }
 
          sumup += auxu; sumdn += auxd;

        }// for (int n=1; n<=nmem/2
        
        if (strcmp(err_type.c_str(),"mc")==0 ) { //MC symmetric errors
          pdfu1[iq][ix][ifl]=sqrt(sumup/max(nmem-2,1));
          pdfd1[iq][ix][ifl]=sqrt(sumdn/max(nmem-2,1));
        }
        else {//Hessian errors
          pdfu1[iq][ix][ifl]=sqrt(sumup);
          pdfd1[iq][ix][ifl]=sqrt(sumdn);
          if (strcmp(err_type.c_str(),"he90")==0 ) {
            pdfu1[iq][ix][ifl] *= ErrorScaling;
            pdfd1[iq][ix][ifl] *= ErrorScaling;
          }
          if (strcmp(err_type.c_str(),"dssz")==0 ) {
            pdfu1[iq][ix][ifl] *= ErrorScaling;
            pdfd1[iq][ix][ifl] *= ErrorScaling;
          }
        }//if (err_type == "mc"...
        
      }//for (int ifl=0; ifl
    }//for (int ix=0; ix<nxtot; ++ix)
  }//for (int iq=0; iq<nqtot; ++iq)

//write all errors into .err files
  for (int ierr=0; ierr <= 2; ierr++){
    outerrname[ierr]=inpdfname+"_"+outerrname[ierr];
    outerrfile[ierr].open(outerrname[ierr].c_str());

    for (int iq=0; iq<nqtot; ++iq) {
      double qq=qgrid[iq];
      outerrfile[ierr] << "#   Q = "<<qq<<endl;
      outerrfile[ierr] << "# ZZ"<<endl;
      for (int ix=0; ix<nxtot; ++ix) {
        for (int ifl=0; ifl<nfltot; ++ifl) 
          outerrfile[ierr] <<setw(15)<< scientific 
                           <<setprecision(6)<<pdferr[ierr][iq][ix][ifl];
        
        outerrfile[ierr] <<endl;
      }//for int ix        
    }//for (int iq
    
    outerrfile[ierr].clear();
    outerrfile[ierr].close();
  }//for int ierr

  return 0;

}//MCStdDevs -> ==============================================================

int MCaverage(int argc, char* argv[])
//========================================================================
// Usage: MCaverage average outgrid ingrid1 ingrid2 ...
//Creates an LHAPDF grid outgrid containing the average of PDFs in
//LHAPDF grids ingrid1 ingrid2....
{
  vector <double> pdf; 
  unsigned int ival, wc0=0;
  double num;

  ifstream infile;
  vector <vector <string> > headers;

  if ((string)argv[1] != "average"){
    cout << "Usage MCaverage:"<<endl;
    cout << "MCaverage average out_lha_grid.dat in_lha_grid1.dat in_lha_grid2.dat ..." <<endl;
    exit(1);
  }

  string outpdfname=argv[2]; 
  const int Nindat=argc-3; //Number of input PDF files

  headers.resize(Nindat); //each .dat header contains 6 lines

  //read the LHAPDF grids from the input dat files and average them
  for (int idat=0; idat < Nindat; idat++){
    string inpdfname=argv[idat+3];
   
    infile.open(inpdfname.c_str());
    
    if(infile.fail()){
      cout << "Problem with reading " << inpdfname <<endl;
      exit(1);
    }

    headers[idat].resize(6); //each header contains 6 lines
    for (int iheader=0; iheader < 6; iheader++)
      { //read and compare headers
        getline(infile,headers[idat][iheader]); 
        if ( (idat>0) && 
             (headers[idat][iheader] != headers[0][iheader]))
          {
            cout <<"Error in MCaverage: mismatch in headers of .dat files" << endl;
            cout << "headers[0]["<<iheader<<"] = "<<headers[0][iheader]<<endl;
            cout << "headers["<<idat<<"]["<<iheader<<"] = "<<headers[idat][iheader]<<endl;
            exit(1);
          }
      }//for (int iheader=...       
        
    ival=0;
    while (infile.good())
      {
        infile >> num;
        if (idat == 0)
          pdf.push_back(num);
        else
          if (ival <= wc0) 
            pdf[ival] += num;
          else{
            cout << "Error in MCaverage: The PDF table is of a wrong length in "<<inpdfname<<endl;
            exit(1);
          }
        ival++;
      }
    
    //Verify that the lengths of all input PDF grids are the same
    if (idat == 0) 
      wc0=ival-1;
    else
      if (ival-1 != wc0 ){
        cout << "MCaverage: lengths of input .dat files do not match"<<endl;
        exit(1);
      }

    infile.clear();
    infile.close();
  
  }//for (int idat=1
  
  //Write the header into the .dat file
  //Analyze line 6; count the number of flavors per line 
  //temporary restriction: allow only up to 4 or 5 quark flavors
  if ((headers[0][5] != "-5 -4 -3 -2 -1 1 2 3 4 5 21") &&
      (headers[0][5] != "-4 -3 -2 -1 1 2 3 4 21") )
    {
      cout <<"Error in MCaverage: unsupported flavor assignment (line 6) in the .dat file:"<<endl;
      cout <<headers[0][5]<<endl;
      cout <<"Implemented flavor assignments are"<<endl;
      cout <<"-5 -4 -3 -2 -1 1 2 3 4 5 21"<<endl;
      cout <<"-4 -3 -2 -1 1 2 3 4 21"<<endl;
      exit(1);
    }

  int iflav=0;
  stringstream ss(headers[0][5]);
  while (ss.good())
    {
      ss >> num;
      iflav++;
    }

  ofstream outfile;
  outfile.open(outpdfname.c_str());
  for (int iheader=0; iheader < 6; iheader++)
    outfile << headers[0][iheader]<<endl;
  
  //Average the pdf values and write them into the output file
  ival=0;
  while(ival < wc0)
    {
      for (int ifl=0; ifl < iflav; ifl++){
        outfile <<setw(16)<< scientific <<setprecision(8)<<pdf[ival]/Nindat;
        ival++;
      }
      outfile << endl;
    }
  outfile << "---" <<endl;
  outfile.clear();
  outfile.close();

  cout << "Averaged "<<Nindat << " LHAPDF files"<<endl;

return 0;
}//MCaverage -> 


int MCadd(int argc, char* argv[])
//========================================================================
// Usage: MCadd add outgrid ingrid1 ingrid2 w1 w2
//Creates an LHAPDF grid outgrid containing the sum of PDFs in
//LHAPDF grids ingrid1 and ingrid2, multiplied by real numbers
// w1 and w2. The PDFs in the final grid satistfy
//
// pdf(x, Q, ifl, out) = w1*pdf(x,Q,ifl,in1) + w2*pdf(x,Q,ifl,in2).
{
  vector <double> pdf; 
  unsigned int ival, wc0=0;
  double num;

  ifstream infile;
  vector <vector <string> > headers;

  string outpdfname=argv[2];
  unsigned short int operation;
  if (strcmp(argv[1],"add")==0)
    operation = 1;
  else 
    operation = 2; 

  const int Nindat=2; //number of input files

  double w[Nindat]; 
  w[0]=boost::lexical_cast<double>(argv[5]); 
  w[1]=boost::lexical_cast<double>(argv[6]);

  headers.resize(Nindat); //each .dat header contains 6 lines

  //read the LHAPDF grids from the input dat files and average them
  for (int idat=0; idat < Nindat; idat++){
    string inpdfname=argv[idat+3];
   
    infile.open(inpdfname.c_str());
    
    if(infile.fail()){
      cout << "Problem with reading " << inpdfname <<endl;
      exit(1);
    }

    headers[idat].resize(6); //each header contains 6 lines
    for (int iheader=0; iheader < 6; iheader++)
      { //read and compare headers
        getline(infile,headers[idat][iheader]); 
        if ( (idat>0) && 
             (headers[idat][iheader] != headers[0][iheader]))
          {
            cout <<"Error in MCadd: mismatch in headers of .dat files" << endl;
            cout << "headers[0]["<<iheader<<"] = "<<headers[0][iheader]<<endl;
            cout << "headers["<<idat<<"]["<<iheader<<"] = "<<headers[idat][iheader]<<endl;
            exit(1);
          }
      }//for (int iheader=...       
    
    ival=0;
    while (infile.good())
      {
        infile >> num;
        if (idat == 0)
          if (operation == 2) //multiply
            {
              if (fabs(num) < small)
                num = copysign(small,num);
              pdf.push_back(pow(num,w[0]));
            }
          else //add
            pdf.push_back(w[0]*num);
          else
            if (ival <= wc0) 
              if (operation == 2) //multiply
                {
                  if (fabs(num) < small)
                    num = copysign(small,num);
                  pdf[ival] *= pow(num,w[idat]);
                }
              else //add
                pdf[ival] += w[idat]*num;
            else{
              cout << "Error in MCadd: The PDF table is of a wrong length in "<<inpdfname<<endl;
              exit(1);
            }
        ival++;
      }
    
    //Verify that the lengths of all input PDF grids are the same
    if (idat == 0) 
      wc0=ival-1;
    else
      if (ival-1 != wc0 ){
        cout << "MCadd: lengths of input .dat files do not match"<<endl;
        cout << "ival, wc0 ="<<ival<<", "<<wc0<<endl;
        exit(1);
      }

    infile.clear();
    infile.close();
  
  }//for (int idat=1
  
  //Write the header into the .dat file
  //Analyze line 6; count the number of flavors per line 
  //temporary restriction: allow only up to 4 or 5 quark flavors
  if ((headers[0][5] != "-5 -4 -3 -2 -1 1 2 3 4 5 21") &&
      (headers[0][5] != "-4 -3 -2 -1 1 2 3 4 21") )
    {
      cout <<"Error in MCadd: unsupported flavor assignment (line 6) in the .dat file:"<<endl;
      cout <<headers[0][5]<<endl;
      cout <<"Implemented flavor assignments are"<<endl;
      cout <<"-5 -4 -3 -2 -1 1 2 3 4 5 21"<<endl;
      cout <<"-4 -3 -2 -1 1 2 3 4 21"<<endl;
      exit(1);
    }

  int iflav=0;
  stringstream ss(headers[0][5]);
  while (ss.good())
    {
      ss >> num;
      iflav++;
    }

  ofstream outfile;
  outfile.open(outpdfname.c_str());
  for (int iheader=0; iheader < 6; iheader++)
    outfile << headers[0][iheader]<<endl;
  
  //Write the pdf values into the output file
  ival=0;
  while(ival < wc0)
    {
      for (int ifl=0; ifl < iflav; ifl++){
        outfile <<setw(16)<< scientific <<setprecision(8)<<pdf[ival];
        ival++;
      }
      outfile << endl;
    }
  outfile << "---" <<endl;
  outfile.clear();
  outfile.close();

return 0;
}//MCadd -> 



