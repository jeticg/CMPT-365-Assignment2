//
//  jmatrix.hpp
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#ifndef jmatrix_hpp
#define jmatrix_hpp

#include <stdio.h>
#include <cstring>
#include <cmath>
#include <stdarg.h>
#include <vector>
using std::vector;

#define MAX_MATRIX 64
#define max(x,y) (x>y)?x:y
#define min(x,y) (x<y)?x:y
#define dct_c(x) ((x==0)?sqrt(1/x):sqrt(1/x))
#define PI 3.1415926536
#define FLOAT_DELTA 0.0000001

//
class Jmatrix;
class Jvector;
//
class Jmatrix {
private:
    int x_value, y_value;      //size of the matrix
    vector <vector <double> > a;   //intity of the matrix
    void shrink();                      //remove rows and columns containing zero only;
public:
    Jmatrix();
    Jmatrix(int init_x, int init_y, const double init_a[]); //size of the matrix and intities
                                                            //of the matrix
    Jmatrix(int init_x, int init_y, double val, ...);
    int     x()const;
    int     y()const;
    double  val(int x, int y)const;
    void    set(int x, int y, double value);
    //
    Jmatrix& operator=(const Jmatrix&    m);
    bool     operator==(const Jmatrix&   m)const;
    
    Jmatrix& operator+(const Jmatrix&    m)const;
    Jmatrix& operator+=(const Jmatrix&    m);
    
    Jmatrix& operator-(const Jmatrix&    m)const;
    Jmatrix& operator-=(const Jmatrix&    m);
    
    Jmatrix& operator*(const Jmatrix&    m)const;
    Jmatrix& operator*=(const Jmatrix&    m);
    
    Jmatrix& operator*(const double&     m)const;
    Jmatrix& operator*=(const double&     m);
    
    Jmatrix& operator/(const double&     m)const;
    Jmatrix& operator/=(const double&     m);
    //
    Jmatrix T()const;
    operator Jvector();
    //Jmatrix sub_8x8_val(int x, int y); //return a 8x8 submatrix
    //void    sub_8x8_rep(int x, int y, const Jmatrix& m); //write the data from a nxn matrix to a nxn block
    Jmatrix sub_val(int n, int x, int y)const; //return a nxn submatrix
    void    sub_rep(int n, int x, int y, const Jmatrix& m); //write the data from a nxn matrix to a nxn block

    Jmatrix dct2();
    Jmatrix idct2();
};

class Jvector: public Jmatrix {
public:
    Jvector():Jmatrix(){};
    Jvector(int x, const double init_a[]):Jmatrix(x,1,init_a){};
    Jvector(int x, double val, ...);
    using Jmatrix::x;
    double  val(int x)const;
    void    set(int x, double value);
    //
    using Jmatrix::operator=;
    using Jmatrix::operator==;
    
    using Jmatrix::operator+;
    using Jmatrix::operator+=;
    
    using Jmatrix::operator-;
    using Jmatrix::operator-=;
    
    using Jmatrix::operator*;
    using Jmatrix::operator*=;
    
    using Jmatrix::operator/;
    using Jmatrix::operator/=;
    
    Jvector& operator^(const Jvector&    m)const; //cross product
    Jvector& operator^=(const Jvector&    m); //cross product
    
    double  operator*(const Jvector&    m)const; //dot product
    
    double  d()const;
    Jvector& normal()const;
};

Jmatrix strassen(const Jmatrix& A, const Jmatrix& B);
const void printJmatrix(Jvector m);
const void printJmatrix(Jmatrix m);

#endif /* jmatrix_hpp */
