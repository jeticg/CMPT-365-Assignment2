//
//  jmatrix.cpp
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#include "jmatrix.hpp"

const Jmatrix conv_dct(8,8,
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
            if (a[x_value-1][i]>FLOAT_DELTA || a[x_value-1][i]<-FLOAT_DELTA) {flag=false;break;}
        if (flag) {
            x_value--;
            a.resize(x_value);
        }
    }
    flag=true;
    while (flag) {
        if (y_value==0) break;
        for (int i=0;i<x();i++)
            if (a[i][y_value-1]>FLOAT_DELTA || a[i][y_value-1]<-FLOAT_DELTA) {flag=false;break;}
        if (flag) y_value--;
    }
    for (int i=0;i<x_value;i++) {
        a[i].resize(y_value);
    }
}

//  IO
int Jmatrix:: x()const {
    return x_value;
}
int Jmatrix:: y()const {
    return y_value;
}

double  Jmatrix::val(int x, int y)const {
    if (x<0 || y<0) {
        printf("Error 1, matrix cannot be read.");
        return 0;
    }
    if (x>=x_value || y>=y_value) {
        return 0;
    }
    return a[x][y];
}

void    Jmatrix::set(int x, int y, double value) {
    if (x<0 || y<0) {
        printf("Error 1, matrix cannot be written, max-size exceeded.");
        return;
    }
    if (x>=x_value) {
        a.resize(x+1);
        for (int i=x_value;i<x+1;i++)
            a[i].resize(max(y+1,y_value));
    }
    if (y>=y_value) {
        for (int i=0;i<x_value;i++)
            a[i].resize(y+1);
    }
    a[x][y]=value;
    x_value=max(x_value,x+1);
    y_value=max(y_value,y+1);
    if ((x+1==x_value || y+1==y_value) && value>=-FLOAT_DELTA && value<=FLOAT_DELTA) shrink();
}

//  Constructors
Jmatrix::Jmatrix() {
    x_value=0; y_value=0;
}

Jmatrix::~Jmatrix() {
    a.clear();
    vector <vector <double> >(a).swap(a);
}

Jmatrix::Jmatrix(int init_x, int init_y, const double init_a[]) {
    x_value=0; y_value=0;
    if (init_x<0 || init_y<0) {
        printf("Error 1, matrix cannot be written, min-size exceeded.");
        return;
    }
    for (int i=x_value-1;i>=0;i--)
        for (int j=y_value-1;j>=0;j--)
            set(i,j,init_a[i*y()+j]);
}

Jmatrix::Jmatrix(int init_x, int init_y, double val, ...) {
    x_value=0; y_value=0;
    va_list ap;
    va_start(ap, val);
    set(0, 0, val);
    for (int i=0;i<init_x;i++)
        for (int j=0;j<init_y;j++)
            if (i==0 && j==0) continue;
            else set(i,j,va_arg(ap,double));
    va_end(ap);
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

bool    Jmatrix:: operator!=(const Jmatrix& m)const {
    for (int i=max(x(),m.x());i>=0;i--)
        for (int j=max(y(),m.y());j>=0;j--)
            if (val(i,j)-m.val(i,j)<-FLOAT_DELTA || val(i,j)-m.val(i,j)>FLOAT_DELTA)
                return true;
    return false;
}

Jmatrix Jmatrix:: operator+(const Jmatrix& m)const{
    Jmatrix result;
    //
    for (int i=max(x(),m.x());i>=0;i--)
        for (int j=max(y(),m.y());j>=0;j--)
            result.set(i,j, val(i,j)+m.val(i,j));
    //
    return result;
}
Jmatrix& Jmatrix::operator+=(const Jmatrix& m) {
    for (int i=max(x(),m.x());i>=0;i--)
        for (int j=max(y(),m.y());j>=0;j--)
            set(i,j, val(i,j)+m.val(i,j));
    return *this;
}

Jmatrix Jmatrix:: operator-(const Jmatrix& m)const {
    Jmatrix result;
    //
    for (int i=max(x(),m.x());i>=0;i--)
        for (int j=max(y(),m.y());j>=0;j--)
            result.set(i,j, val(i,j)-m.val(i,j));
    //
    return result;
}
Jmatrix& Jmatrix::operator-=(const Jmatrix&    m) {
    for (int i=max(x(),m.x());i>=0;i--)
        for (int j=max(y(),m.y());j>=0;j--)
            set(i,j, val(i,j)-m.val(i,j));
    return *this;
}

Jmatrix Jmatrix:: operator*(const Jmatrix& m)const {
    Jmatrix result;
    //
    int tmp=max(y(), m.x());
    for (int i=x()-1;i>=0;i--)
        for (int j=m.y()-1;j>=0;j--) {
            result.set(i,j,0);
            for (int k=0;k<tmp;k++)
                result.set(i,j,result.val(i,j)+val(i,k)*m.val(k,j));
        }
    //
    return result;
}
Jmatrix& Jmatrix::operator*=(const Jmatrix&    m) {
    *this=*this * m;
    return *this;
}

Jmatrix Jmatrix:: operator*(const double&  m)const {
    Jmatrix result;
    //
    for (int i=x();i>=0;i--)
        for (int j=y();j>=0;j--)
            result.set(i,j, val(i,j)*m);
    //
    return result;
}
Jmatrix& Jmatrix::operator*=(const double&    m) {
    *this=*this * m;
    return *this;
}

Jmatrix Jmatrix:: operator/(const double&  m)const {
    Jmatrix result;
    //
    for (int i=x();i>=0;i--)
        for (int j=y();j>=0;j--)
            result.set(i,j, val(i,j)/m);
    //
    return result;
}
Jmatrix& Jmatrix::operator/=(const double&    m) {
    *this=*this / m;
    return *this;
}

Jmatrix Jmatrix::T()const {
    Jmatrix result;
    //
    for (int i=x();i>=0;i--)
        for (int j=y();j>=0;j--)
            result.set(j,i,val(i,j));
    //
    return result;
}

Jmatrix::operator Jvector() {
    Jvector result;
    //
    for (int i=0;i<x();i++)
        result.set(i,val(i,0));
    //
    return result;
}

Jmatrix Jmatrix::sub_val(int n, int x, int y)const {
    Jmatrix result;
    //
    for (int i=n-1;i>=0;i--)
        for (int j=n-1;j>=0;j--)
            result.set(i, j, val(x+i,y+j));
    //
    return result;
}
void    Jmatrix::sub_rep(int n, int x, int y, const Jmatrix& m) {
    for (int i=n-1;i>=0;i--)
        for (int j=n-1;j>=0;j--)
            set(x+i, y+j, m.val(i,j));
}

Jmatrix Jmatrix::dct2() {
    Jmatrix result;
    //
    for (int i=0;i<x();i+=8) {
        for (int j=0; j<y(); j+=8) {
            result.sub_rep(8, i, j, conv_dct*this->sub_val(8, i, j)*conv_dct.T());
        }
    }
    return result;
}

Jmatrix Jmatrix::idct2() {
    Jmatrix result;
    //
    for (int i=0;i<x();i+=8) {
        for (int j=0; j<y(); j+=8) {
            result.sub_rep(8, i, j, conv_dct.T()*this->sub_val(8, i, j)*conv_dct);
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

Jvector Jvector::operator^(const Jvector&  m) const{
    Jvector result;
    for (int i=min(x(),m.x());i>=0;i--)
        result.set(i,m.val(i)*val(i));
    return result;
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
            printf("\t%.10lf", m.Jmatrix::val(i,j));
        printf("\t|\n");
    }
}

const void printJmatrix(Jvector m) {
    printf("(%d, %d)\n", m.x(), m.y());
    for (int i=0;i<m.x();i++) {
        printf(" |");
        for (int j=0;j<m.y();j++)
            printf("\t%.10lf", m.Jmatrix::val(i,j));
        printf("\t|\n");
    }
}

Jmatrix strassen(const Jmatrix& A, const Jmatrix& B) {
    Jmatrix result;
    int n=max(max(A.x(),A.y()),max(B.x(),B.y()));
    if (n<=20) return A*B;
    if (n%2==1) n++;
    Jmatrix A11,A22,B11,B22,
    
            A11pA22,A21pA22,A11pA12,A21mA11,A12mA22,
            B11pB22,B12mB22,B21mB11,B11pB12,B21pB22;
    
    for (int i=(n/2)-1;i>=0;i--)
        for (int j=(n/2)-1;j>=0;j--) {
            A11.set(i, j, A.val(i, j));
            A22.set(i, j, A.val(n/2+i, n/2+j));
            B11.set(i, j, B.val(i, j));
            B22.set(i, j, B.val(n/2+i, n/2+j));
            
            A11pA22.set(i, j, A11.val(i,    j)+A22.val(i, j));
            A21pA22.set(i, j, A.val(n/2+i,  j)+A22.val(i, j));
            A11pA12.set(i, j, A11.val(i,    j)+A.val(i, n/2+j));
            A21mA11.set(i, j, A.val(n/2+i,  j)-A11.val(i, j));
            A12mA22.set(i, j, A.val(i,  n/2+j)-A22.val(i, j));
            
            B11pB22.set(i, j, B11.val(i,    j)+B22.val(i, j));
            B12mB22.set(i, j, B.val(i,  n/2+j)-B22.val(i, j));
            B21mB11.set(i, j, B.val(n/2+i,  j)-B11.val(i, j));
            B11pB12.set(i, j, B11.val(i,    j)+B.val(i, n/2+j));
            B21pB22.set(i, j, B.val(n/2+i,  j)+B22.val(i, j));
        }
            
    const Jmatrix&  M1=strassen(A11pA22, B11pB22 ),
                    M2=strassen(A21pA22, B11     ),
                    M3=strassen(A11,     B12mB22 ),
                    M4=strassen(A22,     B21mB11 ),
                    M5=strassen(A11pA12, B22     ),
                    M6=strassen(A21mA11, B11pB12 ),
                    M7=strassen(A12mA22, B21pB22 );
    
    for (int i=(n/2)-1;i>=0;i--)
        for (int j=(n/2)-1;j>=0;j--) {
            result.set(i,       j,      M1.val(i, j)+M4.val(i, j)-M5.val(i, j)+M7.val(i, j));
            result.set(i,       n/2+j,  M3.val(i, j)+M5.val(i, j));
            result.set(n/2+i,   j,      M2.val(i, j)+M4.val(i, j));
            result.set(n/2+i,   n/2+j,  M1.val(i, j)-M2.val(i, j)+M3.val(i, j)+M6.val(i, j));
        }
    return result;
}

Jmatrix ID(int n) {
    Jmatrix result;
    for (int i=n-1;i>=0;i--)
        result.set(i, i, 1.0);
    return result;
}
