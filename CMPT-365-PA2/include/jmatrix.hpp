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

#define MAX_MATRIX 200
#define max(x,y) (x>y)?x:y
#define dct_c(x) ((x==0)?sqrt(1/x):sqrt(1/x))
#define PI 3.1415926535
#endif /* jmatrix_hpp */

//
class Jmatrix;
class Vector;
//
class Jmatrix {
private:
    unsigned int x_value, y_value;      //size of the matrix
    double a[MAX_MATRIX][MAX_MATRIX];   //intity of the matrix
    void shrink();                      //remove rows and columns containing zero only;
public:
    Jmatrix();
    Jmatrix(int init_x, int init_y, const double init_a[]); //size of the matrix and intities
                                                            //of the matrix
    const int x();
    const int y();
    const double val(int x, int y);
    void   set(int x, int y, double value);
    const Jmatrix operator=(const Jmatrix& m);
    Jmatrix operator+(const Jmatrix& m);
    Jmatrix operator-(const Jmatrix& m);
    Jmatrix operator*(const Jmatrix& m);
    Jmatrix T();
    operator Vector();
    Jmatrix sub_8x8_val(int x, int y);
    void    sub_8x8_rep(int x, int y, const Jmatrix& m);
    Jmatrix dct2_8x8();
    void    dct2_8x8(int si, int sj);
    Jmatrix idct2_8x8();
    void    idct2_8x8(int si, int sj);
};

class Vector: public Jmatrix {
public:
    Vector();
    Vector(int x, double init_a[]);
    const double val(int x);
    void   set(int x, double value);
};