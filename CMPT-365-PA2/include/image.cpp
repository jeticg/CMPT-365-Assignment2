//
//  image.cpp
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#include "image.hpp"

const double a_conv_yuv[]={
    0.299, 0.587, 0.114,
    -0.299, -0.587, 0.886,
    0.701, -0.587, -0.114
};

//
Jmatrix conv_yuv(3,3,(double*)a_conv_yuv);

// Functions
Vector          conv_BIT_RGB(unsigned char s[]);
Vector          conv_RGB_YUV(Jmatrix s);
unsigned int    conv_YUV_BIT(Vector s);

// Function Implications(image.cpp)
Vector conv_BIT_RGB(unsigned char s[]) {
    double a[3]={double(s[2]),double(s[1]),double(s[0])};
    Vector p(3,a);
    return p;
}

Vector conv_RGB_YUV(Vector s) {
    return conv_yuv*s;
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

Image::Image(FILE * infile) {
    unsigned char a, r, g, b;
    int width, height;
    struct jpeg_decompress_struct cinfo;
    struct jpeg_error_mgr jerr;
    
    JSAMPARRAY pJpegBuffer;       /* Output row buffer */
    int row_stride;       /* physical row width in output buffer */
    cinfo.err = jpeg_std_error(&jerr);
    jpeg_create_decompress(&cinfo);
    jpeg_stdio_src(&cinfo, infile);
    (void) jpeg_read_header(&cinfo, TRUE);
    (void) jpeg_start_decompress(&cinfo);
    width = cinfo.output_width;
    height = cinfo.output_height;
    
    unsigned char * pDummy = new unsigned char [width*height*4];
    unsigned char * pTest = pDummy;
    if (!pDummy) {
        printf("NO MEM FOR JPEG CONVERT!\n");
        return;
    }
    row_stride = width * cinfo.output_components;
    pJpegBuffer = (*cinfo.mem->alloc_sarray)
    ((j_common_ptr) &cinfo, JPOOL_IMAGE, row_stride, 1);
    
    while (cinfo.output_scanline < cinfo.output_height) {
        (void) jpeg_read_scanlines(&cinfo, pJpegBuffer, 1);
        for (int x = 0; x < width; x++) {
            a = 0; // alpha value is not supported on jpg
            r = pJpegBuffer[0][cinfo.output_components * x];
            if (cinfo.output_components > 2) {
                g = pJpegBuffer[0][cinfo.output_components * x + 1];
                b = pJpegBuffer[0][cinfo.output_components * x + 2];
            } else {
                g = r;
                b = r;
            }
            *(pDummy++) = b;
            *(pDummy++) = g;
            *(pDummy++) = r;
            *(pDummy++) = a;
        }
    }
    fclose(infile);
    (void) jpeg_finish_decompress(&cinfo);
    jpeg_destroy_decompress(&cinfo);
    
    bmap_value = (int*)pTest;
    height_value = height;
    width_value = width;
    depth_value = 32;
}