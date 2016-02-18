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

class Jmatrix {
private:
    unsigned int x_value, y_value; //size of the matrix
    double a[MAX_MATRIX][MAX_MATRIX]; //intity of the matrix
    void shrink(); //remove rows and columns containing zero only;
public:
    Jmatrix();
    Jmatrix(int init_x, int init_y, const double * init_a[]); //size of the matrix and intities of the matrix
    const int x();
    const int y();
    double val(int x, int y);
    void   set(int x, int y, double value);
    Jmatrix operator=(Jmatrix& m);
    Jmatrix operator+(Jmatrix& m);
    Jmatrix operator-(Jmatrix& m);
    Jmatrix operator*(Jmatrix& m);
};

// Private Part
void Jmatrix::shrink() {
    bool flag=true;
    while (flag) {
        for (int i=0;i<y();i++)
            if (a[x()-1][i]!=0) {flag=false;break;}
        if (flag) x_value--;
    }
    flag=true;
    while (flag) {
        for (int i=0;i<x();i++)
            if (a[i][y()-1]!=0) {flag=false;break;}
        if (flag) y_value--;
    }
}

//Public Part
Jmatrix::Jmatrix() {
    x_value=0; y_value=0;
    memset(a, 0, sizeof(a));
}

Jmatrix::Jmatrix(int init_x, int init_y, const double *init_a[]) {
    x_value=init_x;
    y_value=init_y;
    //int size=x*y;
    for (int i=0;i<x_value;i++)
        for (int j=0;j<y_value;j++)
            a[i][j]=*init_a[i*y_value+j];
    shrink();
}

const int Jmatrix:: x() {
    return x_value;
}
const int Jmatrix:: y() {
    return y_value;
}

double  Jmatrix::val(int x, int y) {
    return a[x][y];
}

void    Jmatrix::set(int x, int y, double value) {
    a[x][y]=value;
    x_value=max(x_value,x);
    y_value=max(y_value,y);
    shrink();
}

Jmatrix Jmatrix:: operator=(Jmatrix& m) {
    Jmatrix result;
    //
    for (int i=0;i<MAX_MATRIX;i++)
        for (int j=0;j<MAX_MATRIX;j++)
        result.a[i][j]=m.a[i][j];
    result.x_value=m.x();
    result.y_value=m.y();
    //
    return result;
}

Jmatrix Jmatrix:: operator+(Jmatrix& m) {
    Jmatrix result;
    //
    for (int i=0;i<MAX_MATRIX;i++)
        for (int j=0;j<MAX_MATRIX;j++)
            result.a[i][j]=a[i][j]+m.a[i][j];
    result.x_value=max(x(),m.x());
    result.y_value=max(y(),m.y());
    result.shrink();
    //
    return result;
}

Jmatrix Jmatrix:: operator-(Jmatrix& m) {
    Jmatrix result;
    //
    for (int i=0;i<MAX_MATRIX;i++)
        for (int j=0;j<MAX_MATRIX;j++)
            result.a[i][j]=a[i][j]-m.a[i][j];
    result.x_value=max(x(),m.x());
    result.y_value=max(y(),m.y());
    //
    result.shrink();
    return result;
}

Jmatrix Jmatrix:: operator*(Jmatrix& m) {
    Jmatrix result;
    //
    if (y()!=m.x()) return result;
    result.x_value = x();
    result.y_value = m.y();
    for (int i=0;i<result.x();i++)
        for (int j=0;j<result.y();j++)
            for (int k=0;k<y();k++)
                result.a[i][j]+=a[i][k]*m.a[k][j];
    //
    result.shrink();
    return result;
}