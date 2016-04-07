//
//  jmatrix.cpp
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#include "jmatrix.hpp"

const Jmatrix conv_a(8,8,
                     0.3535533906,  0.3535533906,  0.3535533906,  0.3535533906,  0.3535533906,  0.3535533906,  0.3535533906,  0.3535533906,
                     0.4903926402,  0.4157348062,  0.2777851165,  0.0975451610, -0.0975451610, -0.2777851165, -0.4157348062, -0.4903926402,
                     0.4619397663,  0.1913417162, -0.1913417162, -0.4619397663, -0.4619397663, -0.1913417162,  0.1913417162,  0.4619397663,
                     0.4157348062, -0.0975451610, -0.4903926402, -0.2777851165,  0.2777851165,  0.4903926402,  0.0975451610, -0.4157348062,
                     0.3535533906, -0.3535533906, -0.3535533906,  0.3535533906,  0.3535533906, -0.3535533906, -0.3535533906,  0.3535533906,
                     0.2777851165, -0.4903926402,  0.0975451610,  0.4157348061, -0.4157348062, -0.0975451610,  0.4903926402, -0.2777851165,
                     0.1913417162, -0.4619397663,  0.4619397663, -0.1913417162, -0.1913417162,  0.4619397662, -0.4619397663,  0.1913417162,
                     0.0975451610, -0.2777851165,  0.4157348061, -0.4903926402,  0.4903926402, -0.4157348062,  0.2777851165, -0.0975451610);

//Jmatrix
//  private
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

//  Constructors
Jmatrix::Jmatrix() {
    x_value=0; y_value=0;
    memset(a, 0, sizeof(a));
}

Jmatrix::Jmatrix(int init_x, int init_y, const double init_a[]) {
    x_value=0; y_value=0;
    memset(a, 0, sizeof(a));
    if (init_x>=MAX_MATRIX || init_y>=MAX_MATRIX) {
        printf("Error, matrix cannot be written, max-size exceeded.");
        return;
    }
    for (int i=0;i<x_value;i++)
        for (int j=0;j<y_value;j++)
            set(i,j,init_a[i*y()+j]);
}

Jmatrix::Jmatrix(int init_x, int init_y, double val, ...) {
    x_value=0; y_value=0;
    memset(a, 0, sizeof(a));
    va_list ap;
    va_start(ap, val);
    set(0, 0, val);
    for (int i=0;i<init_x;i++)
        for (int j=0;j<init_y;j++)
            if (i==0 && j==0) continue;
            else set(i,j,va_arg(ap,double));
    va_end(ap);
}

//  IO
int Jmatrix:: x()const {
    return x_value;
}
int Jmatrix:: y()const {
    return y_value;
}

double  Jmatrix::val(int x, int y)const {
    if (x>=MAX_MATRIX || y>=MAX_MATRIX || x<0 || y<0) {
        printf("Error 1, matrix cannot be read.");
        return 0;
    }
    return a[x][y];
}

void    Jmatrix::set(int x, int y, double value) {
    if (x>=MAX_MATRIX || y>=MAX_MATRIX || x<0 || y<0) {
        printf("Error 1, matrix cannot be written, max-size exceeded.");
        return;
    }
    a[x][y]=value;
    x_value=max(x_value,x+1);
    y_value=max(y_value,y+1);
    if ((x+1==x_value || y+1==y_value) && value>=-FLOAT_DELTA && value<=FLOAT_DELTA)
        shrink();
}

//  Computational module
Jmatrix& Jmatrix:: operator=(const Jmatrix& m) {
    if (this != &m) {
        for (int i=max(x(),m.x());i>=0;i--)
            for (int j=max(y(),m.y());j>=0;j--)
                set(i,j,m.val(i,j));
    }
    return *this;
}

bool    Jmatrix:: operator==(const Jmatrix& m)const {
    for (int i=max(x(),m.x());i>=0;i--)
        for (int j=max(y(),m.y());j>=0;j--)
            if (val(i,j)-m.val(i,j)<-FLOAT_DELTA || val(i,j)-m.val(i,j)>FLOAT_DELTA)
                return false;
    return true;
}

Jmatrix& Jmatrix:: operator+(const Jmatrix& m)const{
    Jmatrix* result=new Jmatrix;
    //
    for (int i=max(x(),m.x());i>=0;i--)
        for (int j=max(y(),m.y());j>=0;j--)
            result->set(i,j, val(i,j)+m.val(i,j));
    //
    return *result;
}
Jmatrix& Jmatrix::operator+=(const Jmatrix& m) {
    *this=*this + m;
    return *this;
}

Jmatrix& Jmatrix:: operator-(const Jmatrix& m)const {
    Jmatrix* result=new Jmatrix;
    //
    for (int i=max(x(),m.x());i>=0;i--)
        for (int j=max(y(),m.y());j>=0;j--)
            result->set(i,j, val(i,j)-m.val(i,j));
    //
    return *result;
}
Jmatrix& Jmatrix::operator-=(const Jmatrix&    m) {
    *this=*this - m;
    return *this;
}

Jmatrix& Jmatrix:: operator*(const Jmatrix& m)const {
    Jmatrix* result=new Jmatrix;
    //
    int tmp=max(y(), m.x());
    result->x_value = x();
    result->y_value = m.y();
    for (int i=0;i<result->x();i++)
        for (int j=0;j<result->y();j++)
            for (int k=0;k<tmp;k++)
                result->a[i][j]+=val(i,k)*m.val(k,j);
    //
    result->shrink();
    return *result;
}
Jmatrix& Jmatrix::operator*=(const Jmatrix&    m) {
    *this=*this * m;
    return *this;
}

Jmatrix& Jmatrix:: operator*(const double&  m)const {
    Jmatrix *result=new Jmatrix;
    //
    for (int i=x();i>=0;i--)
        for (int j=y();j>=0;j--)
            result->set(i,j, val(i,j)*m);
    //
    return *result;
}
Jmatrix& Jmatrix::operator*=(const double&    m) {
    *this=*this * m;
    return *this;
}

Jmatrix& Jmatrix:: operator/(const double&  m)const {
    Jmatrix *result=new Jmatrix;
    //
    for (int i=x();i>=0;i--)
        for (int j=y();j>=0;j--)
            result->set(i,j, val(i,j)/m);
    //
    return *result;
}
Jmatrix& Jmatrix::operator/=(const double&    m) {
    *this=*this / m;
    return *this;
}

Jmatrix Jmatrix::T()const {
    Jmatrix result;
    //
    result.x_value=y();
    result.y_value=x();
    for (int i=x();i>=0;i--)
        for (int j=y();j>=0;j--)
            result.a[j][i]=a[i][j];
    //
    return result;
}

Jmatrix::operator Jvector() {
    Jvector* result=new Jvector;
    //
    for (int i=0;i<x();i++)
        result->set(i,val(i,0));
    //
    return *result;
}
/*
Jmatrix Jmatrix::sub_8x8_val(int x, int y) {
    Jmatrix result; int n=8;
    //
    for (int i=0;i<n;i++)
        for (int j=0;j<n;j++)
            result.set(i, j, val(x+i,y+j));
    //
    return result;
}
void    Jmatrix::sub_8x8_rep(int x, int y, const Jmatrix& m) {
    int n=8;
    for (int i=0;i<n;i++)
        for (int j=0;j<n;j++)
            set(x+i, y+j, m.val(i,j));
}
*/
Jmatrix Jmatrix::sub_val(int n, int x, int y) {
    Jmatrix result;
    //
    for (int i=0;i<n;i++)
        for (int j=0;j<n;j++)
            result.set(i, j, val(x+i,y+j));
    //
    return result;
}
void    Jmatrix::sub_rep(int n, int x, int y, const Jmatrix& m) {
    for (int i=0;i<n;i++)
        for (int j=0;j<n;j++)
            set(x+i, y+j, m.val(i,j));
}

Jmatrix Jmatrix::dct2() {
    Jmatrix result=*this;
    //
    for (int i=0;i<x();i+=8) {
        for (int j=0; j<y(); j+=8) {
            result.sub_rep(8, i, j, conv_a*result.sub_val(8, i, j)*conv_a.T());
        }
    }
    return result;
}

Jmatrix Jmatrix::idct2() {
    Jmatrix result=*this;
    //
    for (int i=0;i<x();i+=8) {
        for (int j=0; j<y(); j+=8) {
            result.sub_rep(8, i, j, conv_a.T()*result.sub_val(8, i, j)*conv_a);
        }
    }
    return result;
}

//Jvector
//  Constructors
Jvector::Jvector(int x, double val, ...):Jmatrix() {
    va_list ap;
    va_start(ap, val);
    set(0,val);
    for (int i=1;i<x; i++) {
        set(i,va_arg(ap,double));
    }
    va_end(ap);
}

double Jvector::val(int x)const {
    return Jmatrix::val(x, 0);
}

void   Jvector::set(int x, double value) {
    Jmatrix::set(x, 0, value);
}

double  Jvector::d()const {
    double result=0;
    for (int i=0;i<x();i++) result+=val(i)*val(i);
    return sqrt(result);
}

Jvector& Jvector::normal()const{
    Jvector* tmp=new Jvector;
    for (int i=x();i>=0;i--)
        tmp->set(i, val(i)/d());
    return *tmp;
}

Jvector& Jvector::operator^(const Jvector&  m) const{
    Jvector* result=new Jvector;
    for (int i=min(x(),m.x());i>=0;i--)
        result->set(i,m.val(i)*val(i));
    return *result;
}
Jvector& Jvector::operator^=(const Jvector&    m) {
    *this=*this ^ m;
    return *this;
}

double Jvector::operator*(const Jvector&  m) const{
    double result=0;
    for (int i=max(x(),m.x());i>=0;i--)
        result+=m.val(i)*val(i);
    return result;
}

const void printJmatrix(Jmatrix m) {
    printf("(%d, %d)\n", m.x(), m.y());
    for (int i=0;i<m.x();i++) {
        printf(" |");
        for (int j=0;j<m.y();j++)
            printf(" %.10lf", m.Jmatrix::val(i,j));
        printf(" |\n");
    }
}

const void printJmatrix(Jvector m) {
    printf("(%d, %d)\n", m.x(), m.y());
    for (int i=0;i<m.x();i++) {
        printf(" |");
        for (int j=0;j<m.y();j++)
            printf(" %.10lf", m.Jmatrix::val(i,j));
        printf(" |\n");
    }
}
