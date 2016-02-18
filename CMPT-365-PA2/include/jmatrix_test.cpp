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
    return 0;
}
