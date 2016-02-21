//
//  ViewController.m
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#import "ViewController.h"
#import "jmatrix.hpp"
#include <cmath>
#define ALPHA_VALUE 1

@implementation ViewController

@synthesize imgOriginal;
@synthesize imgConv1;
@synthesize imgConv2;
@synthesize imgConv3;
@synthesize imgConv4;

@synthesize imgConv5;
@synthesize imgConv6;
@synthesize imgConv7;
@synthesize imgConv8;

@synthesize imgConv9;
@synthesize imgConv10;
@synthesize imgConv11;
@synthesize imgConv12;
@synthesize imgConvRGB;

int conv_quantisation[8][8] = {
    {2, 2, 2, 2, 2, 2, 2, 2},
    {2, 2, 2, 2, 2, 2, 2, 2},
    {2, 2, 2, 2, 2, 2, 2, 2},
    {2, 2, 2, 2, 2, 2, 2, 2},
    {2, 2, 2, 2, 2, 2, 2, 2},
    {2, 2, 2, 2, 2, 2, 2, 2},
    {2, 2, 2, 2, 2, 2, 2, 2},
    {2, 2, 2, 2, 2, 2, 2, 2}
};

- (void)viewDidLoad {
    [super viewDidLoad];
    defImage = [NSImage imageNamed:@"default.jpg"];
    [imgOriginal    setImage:defImage];
    [imgConv1       setImage:defImage];
    [imgConv2       setImage:defImage];
    [imgConv3       setImage:defImage];
    [imgConv4       setImage:defImage];
    
    [imgConv5       setImage:defImage];
    [imgConv6       setImage:defImage];
    [imgConv7       setImage:defImage];
    [imgConv8       setImage:defImage];
    
    [imgConv9       setImage:defImage];
    [imgConv10      setImage:defImage];
    [imgConv11      setImage:defImage];
    [imgConv12      setImage:defImage];
    [imgConvRGB     setImage:defImage];
    // Do any additional setup after loading the view.
}

- (IBAction)generateYUV:(id)sender{
    /*
    double a_conv_yuv[]={
        0.299, 0.587, 0.114,
        -0.299, -0.587, 0.886,
        0.701, -0.587, -0.114
    };
    double a_conv_yuv[]={ //SDTV with BT.601
        0.299, 0.587, 0.114,
        -0.14713, -0.28886, 0.436,
        0.615, -0.51499, -0.10001
    };
    double a_conv_yuv[]={ //HDTV with BT709
        0.2126, 0.7152, 0.0722,
        -0.09991, -0.33609, 0.436,
        0.615, -0.55861, -0.05639
    };
    */
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
    NSBitmapImageRep* imageRepY = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepU = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepV = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRepY pixelsWide];i++)
        for (int j=0;j<[imageRepY pixelsHigh];j++) {
            NSColor *tmp=[imageRepY colorAtX:i y:j];
            
            double R=[tmp redComponent];
            double G=[tmp greenComponent];
            double B=[tmp blueComponent];
            
            double Y=a_conv_yuv[0]*R+a_conv_yuv[1]*G+a_conv_yuv[2]*B;
            double U=a_conv_yuv[3]*R+a_conv_yuv[4]*G+a_conv_yuv[5]*B;
            double V=a_conv_yuv[6]*R+a_conv_yuv[7]*G+a_conv_yuv[8]*B;

            imgOriY.set(i, j, Y);
            #ifdef M444
                imgOriU.set(i, j, U);
                imgOriV.set(i, j, V);
            #else
                if (i%2) {
                    imgOriU.set(i, j, (j%2)?U:imgOriU.val(i, j-1));
                    imgOriV.set(i, j, (i%2)?V:imgOriV.val(i, j-1));
                } else {
                    imgOriU.set(i, j, imgOriU.val(i-1, j));
                    imgOriV.set(i, j, imgOriV.val(i-1, j));
                }
            #endif

            
            tmp=[NSColor colorWithDeviceRed:imgOriY.val(i,j)   green:imgOriY.val(i,j) blue:imgOriY.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepY setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgOriU.val(i,j)   green:imgOriU.val(i,j) blue:imgOriU.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepU setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgOriV.val(i,j)   green:imgOriV.val(i,j) blue:imgOriV.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepV setColor:tmp atX:i y:j];
            
        }
    
    NSImage *imageY = [[NSImage alloc] initWithCGImage:[imageRepY CGImage] size:NSMakeSize([imageRepY pixelsWide],[imageRepY pixelsHigh])];
    [imgConv1 setImage:imageY];
    NSImage *imageU = [[NSImage alloc] initWithCGImage:[imageRepU CGImage] size:NSMakeSize([imageRepU pixelsWide],[imageRepU pixelsHigh])];
    [imgConv5 setImage:imageU];
    NSImage *imageV = [[NSImage alloc] initWithCGImage:[imageRepV CGImage] size:NSMakeSize([imageRepV pixelsWide],[imageRepV pixelsHigh])];
    [imgConv6 setImage:imageV];
}

- (IBAction)generateDCT:(id)sender; {
    imgDCTY=imgOriY;
    imgDCTY=imgOriY.dct2();
    imgDCTU=imgOriU.dct2();
    imgDCTV=imgOriV.dct2();
    
    NSBitmapImageRep* imageRepY = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepU = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepV = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRepY pixelsWide];i++)
        for (int j=0;j<[imageRepY pixelsHigh];j++) {
            NSColor *tmp;
            
            tmp=[NSColor colorWithDeviceRed:imgDCTY.val(i,j)   green:imgDCTY.val(i,j) blue:imgDCTY.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepY setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgDCTU.val(i,j)   green:imgDCTU.val(i,j) blue:imgDCTU.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepU setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgDCTV.val(i,j)   green:imgDCTV.val(i,j) blue:imgDCTV.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepV setColor:tmp atX:i y:j];
            
        }
    
    NSImage *imageY = [[NSImage alloc] initWithCGImage:[imageRepY CGImage] size:NSMakeSize([imageRepY pixelsWide],[imageRepY pixelsHigh])];
    [imgConv2 setImage:imageY];
    NSImage *imageU = [[NSImage alloc] initWithCGImage:[imageRepU CGImage] size:NSMakeSize([imageRepU pixelsWide],[imageRepU pixelsHigh])];
    [imgConv7 setImage:imageU];
    NSImage *imageV = [[NSImage alloc] initWithCGImage:[imageRepV CGImage] size:NSMakeSize([imageRepV pixelsWide],[imageRepV pixelsHigh])];
    [imgConv8 setImage:imageV];
    
}

- (IBAction)generateIDCT:(id)sender; {
    imgIDCTY=imgQUANY.idct2();
    imgIDCTU=imgQUANU.idct2();
    imgIDCTV=imgQUANV.idct2();
    
    NSBitmapImageRep* imageRepY = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepU = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepV = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRepY pixelsWide];i++)
        for (int j=0;j<[imageRepY pixelsHigh];j++) {
            NSColor *tmp;
            
            tmp=[NSColor colorWithDeviceRed:imgIDCTY.val(i,j)   green:imgIDCTY.val(i,j) blue:imgIDCTY.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepY setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgIDCTU.val(i,j)   green:imgIDCTU.val(i,j) blue:imgIDCTU.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepU setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgIDCTV.val(i,j)   green:imgIDCTV.val(i,j) blue:imgIDCTV.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepV setColor:tmp atX:i y:j];
            
        }
    
    NSImage *imageY = [[NSImage alloc] initWithCGImage:[imageRepY CGImage] size:NSMakeSize([imageRepY pixelsWide],[imageRepY pixelsHigh])];
    [imgConv4 setImage:imageY];
    NSImage *imageU = [[NSImage alloc] initWithCGImage:[imageRepU CGImage] size:NSMakeSize([imageRepU pixelsWide],[imageRepU pixelsHigh])];
    [imgConv11 setImage:imageU];
    NSImage *imageV = [[NSImage alloc] initWithCGImage:[imageRepV CGImage] size:NSMakeSize([imageRepV pixelsWide],[imageRepV pixelsHigh])];
    [imgConv12 setImage:imageV];
    
}
- (IBAction)generateRGB:(id)sender {
    double a_conv_rgb[]={
        1, 0, 1.13983,
        1, -0.39465, -0.58060,
        1, 2.03211, 0
    };
    Jmatrix conv_rgb(3,3,(double*)a_conv_rgb);
    NSBitmapImageRep* imageRep = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRep pixelsWide];i++)
        for (int j=0;j<[imageRep pixelsHigh];j++) {
            NSColor *tmp=[imageRep colorAtX:i y:j];
            
            double Y = imgIDCTY.val(i, j);
            double U = imgIDCTU.val(i, j);
            double V = imgIDCTV.val(i, j);
            
            double R=a_conv_rgb[0]*Y+a_conv_rgb[1]*U+a_conv_rgb[2]*V;
            double G=a_conv_rgb[3]*Y+a_conv_rgb[4]*U+a_conv_rgb[5]*V;
            double B=a_conv_rgb[6]*Y+a_conv_rgb[7]*U+a_conv_rgb[8]*V;

            
            tmp=[NSColor colorWithDeviceRed:R   green:G blue:B  alpha:ALPHA_VALUE];
            [imageRep setColor:tmp atX:i y:j];
            
        }
    
    NSImage *imageY = [[NSImage alloc] initWithCGImage:[imageRep CGImage] size:NSMakeSize([imageRep pixelsWide],[imageRep pixelsHigh])];
    [imgConvRGB setImage:imageY];
}

- (IBAction)generateQUAN:(id)sender {
    NSBitmapImageRep* imageRepY = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepU = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepV = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRepY pixelsWide];i++)
        for (int j=0;j<[imageRepY pixelsHigh];j++) {
            NSColor *tmp;
            double A,B,C;
            
            A=imgDCTY.val(i, j);
            B=imgDCTU.val(i, j);
            C=imgDCTV.val(i, j);
            
            A/=conv_quantisation[i%8][j%8];
            B/=conv_quantisation[i%8][j%8];
            C/=conv_quantisation[i%8][j%8];
            
            A*=conv_quantisation[i%8][j%8];
            B*=conv_quantisation[i%8][j%8];
            C*=conv_quantisation[i%8][j%8];
            
            imgQUANY.set(i, j, (double)A);
            imgQUANU.set(i, j, (double)B);
            imgQUANV.set(i, j, (double)C);
            
            tmp=[NSColor colorWithDeviceRed:imgQUANY.val(i,j)   green:imgQUANY.val(i,j) blue:imgQUANY.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepY setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgQUANU.val(i,j)   green:imgQUANU.val(i,j) blue:imgQUANU.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepU setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgQUANV.val(i,j)   green:imgQUANV.val(i,j) blue:imgQUANV.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepV setColor:tmp atX:i y:j];
            
        }
    
    NSImage *imageY = [[NSImage alloc] initWithCGImage:[imageRepY CGImage] size:NSMakeSize([imageRepY pixelsWide],[imageRepY pixelsHigh])];
    [imgConv3 setImage:imageY];
    NSImage *imageU = [[NSImage alloc] initWithCGImage:[imageRepU CGImage] size:NSMakeSize([imageRepU pixelsWide],[imageRepU pixelsHigh])];
    [imgConv9 setImage:imageU];
    NSImage *imageV = [[NSImage alloc] initWithCGImage:[imageRepV CGImage] size:NSMakeSize([imageRepV pixelsWide],[imageRepV pixelsHigh])];
    [imgConv10 setImage:imageV];
}
@end