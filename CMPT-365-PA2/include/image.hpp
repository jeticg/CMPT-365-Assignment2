//
//  image.hpp
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#ifndef image_hpp
#define image_hpp

#include <stdio.h>
#include "jmatrix.hpp"

#endif /* image_hpp */

class Image {
private:
    unsigned int *bmap_value;
    int height_value, width_value, depth_value;
public:
    Image();
    Image(int hi, int wi);
    const int h();
    const int w();
    Image RGBtoYUV();
};

Vector conv_BIT_RGB(unsigned int s);
Vector conv_RGB_YUV(Vector s);
Vector conv_YUV_RGB(Vector s);
unsigned int conv_YUV_BIT(Vector s);

double a_conv_yuv[]={
    0.299, 0.587, 0.114,
    -0.299, -0.587, 0.886,
    0.701, -0.587, -0.114
};
Jmatrix conv_yuv(3,3,(double*)a_conv_yuv);

double a_conv_rgb[]={
    1, 0, 1.13983,
    1, -0.39465, -0.58060,
    1, 2.03211, 0
};
Jmatrix conv_rgb(3,3,(double*)a_conv_rgb);

double a_conv_ycbcr[]={
    0.299, 0.587, 0.114,
    -0.168736, -0.331264, 0.5,
    0.5, -0.418688, -0.081312
};
Jmatrix conv_ycbcr(3,3,(double*)a_conv_ycbcr);