#include <iostream>
#include <cstdio>
#include <cstring>
#include "jmatrix.hpp"

using namespace std;

int a[100][100], b[100][100], c[100][100];
int n;
int main() {
    Jmatrix m1, m2;
    srand (time(NULL));
    n=rand()%100+1;
    cout << "size: " << n << "x" << n << endl;
    memset(c,0,sizeof(c));
    for (int i=0;i<n;i++)
        for (int j=0;j<n;j++) {
            a[i][j]=rand()%1000;
            b[i][j]=rand()%1000;
            m1.set(i,j,a[i][j]);
            m2.set(i,j,b[i][j]);
        }
    cout << "--init complete" << endl;
    Jmatrix m3=m1*m2;
    for (int i=0;i<n;i++)
        for (int j=0;j<n;j++)
            for (int k=0;k<n;k++)
                c[i][j]+=a[i][k]*b[k][j];
    cout << "--calculation complete" << endl;
    bool flag=true;
    for (int i=0;i<n;i++)
        for (int j=0;j<n;j++)
            if (c[i][j]!=m3.val(i,j)) flag=false;
    if (flag) cout << "--Passed" << endl;
    else cout << "!!Faild" << endl;
    Jmatrix conv_a;
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++) {
            double c;
            if (i==0)
                c=1/sqrt(8);
            else
                c=2/sqrt(8);
            double value=c*cos((j+0.5)*i*PI/8);
            conv_a.set(i,j,value);
        }
    for (int i=0;i<8;i++) {
        cout << endl;
        for (int j=0;j<8;j++)
            cout << conv_a.val(i,j) << " ";
    }
    cout << endl;
    return 0;
}
