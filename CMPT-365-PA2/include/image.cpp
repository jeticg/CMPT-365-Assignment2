//
//  image.cpp
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#include "image.hpp"

// Functions
Vector          conv_BIT_RGB(unsigned char s[]);
Vector          conv_RGB_YUV(Jmatrix s);
Vector          conv_YUV_RGB(Jmatrix s);
unsigned int    conv_YUV_BIT(Vector s);

// Function Implications(image.cpp)
Vector conv_BIT_RGB(unsigned int s) {
    double R=s>>16, G=(s>>8)%(1<<8), B=s%(1<<8);
    double a[3]={R,G,B};
    Vector p(3,a);
    return p;
}

Vector conv_RGB_YUV(Vector s) {
    return conv_yuv*s;
}

Vector conv_YUV_RGB(Vector s) {
    return conv_rgb*s;
}

unsigned int conv_YUV_BIT(Vector s) {
    unsigned int result;
    result= ((unsigned char)s.val(2)<<16)
            +((unsigned char)s.val(1)<<8)
            +((unsigned char)s.val(0));
    return result;
}

// Class Function Implications(image.hpp)
Image::Image() {
    bmap_value=NULL;
    height_value=width_value=depth_value=0;
}

Image::Image(int hi, int wi) {
    height_value=hi; width_value=wi;
    bmap_value = new unsigned int[hi*wi];
}

const int Image::h() {
    return height_value;
}

const int Image::w() {
    return width_value;
}

Image Image::RGBtoYUV() {
    Image result;
    unsigned int *pointer=result.bmap_value;
    //
    for (int i=0;i<h();i++)
        for (int j=0;j<w();j++) {
            *pointer=conv_YUV_BIT(conv_RGB_YUV(conv_BIT_RGB(*pointer)));
            pointer++;
        }
    //
    return result;
}