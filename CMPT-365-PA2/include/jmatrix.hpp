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

#define MAX_MATRIX 100
#define max(x,y) (x>y)?x:y

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
};

class Vector: public Jmatrix {
public:
    Vector();
    Vector(int x, double init_a[]);
    const double val(int x);
    void   set(int x, double value);
};