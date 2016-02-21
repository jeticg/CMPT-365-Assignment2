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

@synthesize t00; @synthesize t10; @synthesize t20; @synthesize t30;
@synthesize t01; @synthesize t11; @synthesize t21; @synthesize t31;
@synthesize t02; @synthesize t12; @synthesize t22; @synthesize t32;
@synthesize t03; @synthesize t13; @synthesize t23; @synthesize t33;
@synthesize t04; @synthesize t14; @synthesize t24; @synthesize t34;
@synthesize t05; @synthesize t15; @synthesize t25; @synthesize t35;
@synthesize t06; @synthesize t16; @synthesize t26; @synthesize t36;
@synthesize t07; @synthesize t17; @synthesize t27; @synthesize t37;

@synthesize t40; @synthesize t50; @synthesize t60; @synthesize t70;
@synthesize t41; @synthesize t51; @synthesize t61; @synthesize t71;
@synthesize t42; @synthesize t52; @synthesize t62; @synthesize t72;
@synthesize t43; @synthesize t53; @synthesize t63; @synthesize t73;
@synthesize t44; @synthesize t54; @synthesize t64; @synthesize t74;
@synthesize t45; @synthesize t55; @synthesize t65; @synthesize t75;
@synthesize t46; @synthesize t56; @synthesize t66; @synthesize t76;
@synthesize t47; @synthesize t57; @synthesize t67; @synthesize t77;

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
    [t00 setIntValue:2]; [t10 setIntValue:2]; [t20 setIntValue:2]; [t30 setIntValue:2];
    [t01 setIntValue:2]; [t11 setIntValue:2]; [t21 setIntValue:2]; [t31 setIntValue:2];
    [t02 setIntValue:2]; [t12 setIntValue:2]; [t22 setIntValue:2]; [t32 setIntValue:2];
    [t03 setIntValue:2]; [t13 setIntValue:2]; [t23 setIntValue:2]; [t33 setIntValue:2];
    [t04 setIntValue:2]; [t14 setIntValue:2]; [t24 setIntValue:2]; [t34 setIntValue:2];
    [t05 setIntValue:2]; [t15 setIntValue:2]; [t25 setIntValue:2]; [t35 setIntValue:2];
    [t06 setIntValue:2]; [t16 setIntValue:2]; [t26 setIntValue:2]; [t36 setIntValue:2];
    [t07 setIntValue:2]; [t17 setIntValue:2]; [t27 setIntValue:2]; [t37 setIntValue:2];
    
    
    [t40 setIntValue:2]; [t50 setIntValue:2]; [t60 setIntValue:2]; [t70 setIntValue:2];
    [t41 setIntValue:2]; [t51 setIntValue:2]; [t61 setIntValue:2]; [t71 setIntValue:2];
    [t42 setIntValue:2]; [t52 setIntValue:2]; [t62 setIntValue:2]; [t72 setIntValue:2];
    [t43 setIntValue:2]; [t53 setIntValue:2]; [t63 setIntValue:2]; [t73 setIntValue:2];
    [t44 setIntValue:2]; [t54 setIntValue:2]; [t64 setIntValue:2]; [t74 setIntValue:2];
    [t45 setIntValue:2]; [t55 setIntValue:2]; [t65 setIntValue:2]; [t75 setIntValue:2];
    [t46 setIntValue:2]; [t56 setIntValue:2]; [t66 setIntValue:2]; [t76 setIntValue:2];
    [t47 setIntValue:2]; [t57 setIntValue:2]; [t67 setIntValue:2]; [t77 setIntValue:2];
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
    conv_quantisation[0][0]=[t00 intValue]; conv_quantisation[4][0]=[t40 intValue];
    conv_quantisation[0][1]=[t01 intValue]; conv_quantisation[4][1]=[t41 intValue];
    conv_quantisation[0][2]=[t02 intValue]; conv_quantisation[4][2]=[t42 intValue];
    conv_quantisation[0][3]=[t03 intValue]; conv_quantisation[4][3]=[t43 intValue];
    conv_quantisation[0][4]=[t04 intValue]; conv_quantisation[4][4]=[t44 intValue];
    conv_quantisation[0][5]=[t05 intValue]; conv_quantisation[4][5]=[t45 intValue];
    conv_quantisation[0][6]=[t06 intValue]; conv_quantisation[4][6]=[t46 intValue];
    conv_quantisation[0][7]=[t07 intValue]; conv_quantisation[4][7]=[t47 intValue];
    
    conv_quantisation[1][0]=[t10 intValue]; conv_quantisation[5][0]=[t50 intValue];
    conv_quantisation[1][1]=[t11 intValue]; conv_quantisation[5][1]=[t51 intValue];
    conv_quantisation[1][2]=[t12 intValue]; conv_quantisation[5][2]=[t52 intValue];
    conv_quantisation[1][3]=[t13 intValue]; conv_quantisation[5][3]=[t53 intValue];
    conv_quantisation[1][4]=[t14 intValue]; conv_quantisation[5][4]=[t54 intValue];
    conv_quantisation[1][5]=[t15 intValue]; conv_quantisation[5][5]=[t55 intValue];
    conv_quantisation[1][6]=[t16 intValue]; conv_quantisation[5][6]=[t56 intValue];
    conv_quantisation[1][7]=[t17 intValue]; conv_quantisation[5][7]=[t57 intValue];
    
    conv_quantisation[2][0]=[t20 intValue]; conv_quantisation[6][0]=[t60 intValue];
    conv_quantisation[2][1]=[t21 intValue]; conv_quantisation[6][1]=[t61 intValue];
    conv_quantisation[2][2]=[t22 intValue]; conv_quantisation[6][2]=[t62 intValue];
    conv_quantisation[2][3]=[t23 intValue]; conv_quantisation[6][3]=[t63 intValue];
    conv_quantisation[2][4]=[t24 intValue]; conv_quantisation[6][4]=[t64 intValue];
    conv_quantisation[2][5]=[t25 intValue]; conv_quantisation[6][5]=[t65 intValue];
    conv_quantisation[2][6]=[t26 intValue]; conv_quantisation[6][6]=[t66 intValue];
    conv_quantisation[2][7]=[t27 intValue]; conv_quantisation[6][7]=[t67 intValue];
    
    conv_quantisation[3][0]=[t30 intValue]; conv_quantisation[7][0]=[t70 intValue];
    conv_quantisation[3][1]=[t31 intValue]; conv_quantisation[7][1]=[t71 intValue];
    conv_quantisation[3][2]=[t32 intValue]; conv_quantisation[7][2]=[t72 intValue];
    conv_quantisation[3][3]=[t33 intValue]; conv_quantisation[7][3]=[t73 intValue];
    conv_quantisation[3][4]=[t34 intValue]; conv_quantisation[7][4]=[t74 intValue];
    conv_quantisation[3][5]=[t35 intValue]; conv_quantisation[7][5]=[t75 intValue];
    conv_quantisation[3][6]=[t36 intValue]; conv_quantisation[7][6]=[t76 intValue];
    conv_quantisation[3][7]=[t37 intValue]; conv_quantisation[7][7]=[t77 intValue];
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