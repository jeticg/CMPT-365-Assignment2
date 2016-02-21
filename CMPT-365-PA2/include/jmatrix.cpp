//
//  jmatrix.cpp
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#include "jmatrix.hpp"

// Private Part
void Jmatrix::shrink() {
    bool flag=true;
    while (flag) {
        if (x_value==0) break;
        for (int i=0;i<y();i++)
            if (a[x()-1][i]!=0) {flag=false;break;}
        if (flag) x_value--;
    }
    flag=true;
    while (flag) {
        if (y_value==0) break;
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

Jmatrix::Jmatrix(int init_x, int init_y, const double init_a[]) {
    x_value=init_x;
    y_value=init_y;
    //int size=x*y;
    for (int i=0;i<x_value;i++)
        for (int j=0;j<y_value;j++)
            a[i][j]=init_a[i*y()+j];
    shrink();
}

const int Jmatrix:: x() {
    return x_value;
}
const int Jmatrix:: y() {
    return y_value;
}

const double  Jmatrix::val(int x, int y) {
    return a[x][y];
}

void    Jmatrix::set(int x, int y, double value) {
    a[x][y]=value;
    x_value=max(x_value,x+1);
    y_value=max(y_value,y+1);
    shrink();
}

const Jmatrix Jmatrix:: operator=(const Jmatrix& m) {
    Jmatrix result;
    //
    for (int i=0;i<MAX_MATRIX;i++)
        for (int j=0;j<MAX_MATRIX;j++)
            result.a[i][j]=m.a[i][j];
    result.x_value=m.x_value;
    result.y_value=m.y_value;
    //
    return result;
}

Jmatrix Jmatrix:: operator+(const Jmatrix& m) {
    Jmatrix result;
    //
    for (int i=0;i<MAX_MATRIX;i++)
        for (int j=0;j<MAX_MATRIX;j++)
            result.a[i][j]=a[i][j]+m.a[i][j];
    result.x_value=max(x(),m.x_value);
    result.y_value=max(y(),m.y_value);
    result.shrink();
    //
    return result;
}

Jmatrix Jmatrix:: operator-(const Jmatrix& m) {
    Jmatrix result;
    //
    for (int i=0;i<MAX_MATRIX;i++)
        for (int j=0;j<MAX_MATRIX;j++)
            result.a[i][j]=a[i][j]-m.a[i][j];
    result.x_value=max(x(),m.x_value);
    result.y_value=max(y(),m.y_value);
    //
    result.shrink();
    return result;
}

Jmatrix Jmatrix:: operator*(const Jmatrix& m) {
    Jmatrix result;
    //
    if (y()!=m.x_value) y_value=max(y(), m.x_value);

    result.x_value = x();
    result.y_value = m.y_value;
    for (int i=0;i<result.x();i++)
        for (int j=0;j<result.y();j++)
            for (int k=0;k<y();k++)
                result.a[i][j]+=a[i][k]*m.a[k][j];
    //
    result.shrink();
    return result;
}

Jmatrix Jmatrix::T() {
    Jmatrix result;
    //
    result.x_value=y_value;
    result.y_value=x_value;
    for (int i=0;i<x_value;i++)
        for (int j=0;j<y_value;j++)
            result.a[j][i]=a[i][j];
    //
    return result;
}

Jmatrix::operator Vector() {
    Vector result;
    //
    for (int i=0;i<x_value;i++)
        result.set(i,a[i][1]);
    result.x_value=x();
    result.y_value=y();
    //
    return result;
}

Vector::Vector() {
    Jmatrix();
}
Vector::Vector(int x, double init_a[]) {
    Jmatrix(x,0,init_a);
}

const double Vector::val(int x) {
    return Jmatrix::val(x, 0);
}
void   Vector::set(int x, double value) {
    Jmatrix::set(x, 0, value);
}

Jmatrix Jmatrix::sub_8x8_val(int x, int y) {
    Jmatrix result; int n=8;
    //
    for (int i=0;i<n;i++)
        for (int j=0;j<n;j++)
            result.set(i, j, a[x+i][y+j]);
    //
    return result;
}
void    Jmatrix::sub_8x8_rep(int x, int y, const Jmatrix& m) {
    int n=8;
    for (int i=0;i<n;i++)
        for (int j=0;j<n;j++)
            set(x+i, y+j, m.a[i][j]);
}

Jmatrix Jmatrix::dct2_8x8() {
    Jmatrix result=*this;
    //
    for (int i=0;i<x_value;i+=8)
        for (int j=0; j<y_value; j+=8)
            result.dct2_8x8(i,j);
    //
    return result;
}

void    Jmatrix::dct2_8x8(int si, int sj) {
    Jmatrix S=sub_8x8_val(si, sj);
    Jmatrix conv_a;
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++) {
            int c;
            if (i==0)
                c=0.3535533906; //sqrt(1/8)
            else
                c=0.5; //sqrt(2/8)
            conv_a.set(i,j,c*cos(PI*(j+0.5)*i/8));
        }
    //
    S=conv_a*S*conv_a.T();
    sub_8x8_rep(si, sj, S);
}

Jmatrix Jmatrix::idct2_8x8() {
    Jmatrix result=*this;
    //
    for (int i=0;i<x_value;i+=8)
        for (int j=0; j<y_value; j+=8)
            result.dct2_8x8(i,j);
    //
    return result;
}

void    Jmatrix::idct2_8x8(int si, int sj) {
    Jmatrix S=sub_8x8_val(si, sj);
    Jmatrix conv_a;
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++) {
            int c;
            if (i==0)
                c=0.3535533906; //sqrt(1/8)
            else
                c=0.5; //sqrt(2/8)
            conv_a.set(i,j,c*cos(PI*(j+0.5)*i/8));
        }
    //
    S=conv_a.T()*S*conv_a;
    sub_8x8_rep(si, sj, S);
}
