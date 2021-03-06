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
#define UV_Alteration 0.5
//#define YIQ
//#define M444
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
@synthesize displayX;
@synthesize displayY;
@synthesize displayMatrix;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewPic:@"default.jpg"];
    NSTextField* quanti[8][8]= {
        {t00,t01,t02,t03,t04,t05,t06,t07},
        {t10,t11,t12,t13,t14,t15,t16,t17},
        {t20,t21,t22,t23,t24,t25,t26,t27},
        {t30,t31,t32,t33,t34,t35,t36,t37},
        
        {t40,t41,t42,t43,t44,t45,t46,t47},
        {t50,t51,t52,t53,t54,t55,t56,t57},
        {t60,t61,t62,t63,t64,t65,t66,t67},
        {t70,t71,t72,t73,t74,t75,t76,t77}
    };
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++)
            [quanti[i][j] setIntValue:2];
}

- (void)loadNewPic:(NSString*)address {
    defImage = [NSImage imageNamed:address];
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
}
- (IBAction)generateYUV:(id)sender{
#ifdef YIQ
    Jmatrix conv_yuv(3,3,
                     0.299, 0.587, 0.114,
                     0.596, -0.274, -0.322,
                     0.211, -0.523, 0.312
                     );
#else
    //SDTV with BT.601
    Jmatrix conv_yuv(3,3,
                     0.299, 0.587, 0.114,
                     -0.14713, -0.28886, 0.436,
                     0.615, -0.51499, -0.10001
                     );
    
    //HDTV with BT709
    Jmatrix conv_yuv2(3,3,
                      0.2126, 0.7152, 0.0722,
                      -0.09991, -0.33609, 0.436,
                      0.615, -0.55861, -0.05639
                      );
#endif
    NSBitmapImageRep* imageRepY = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepU = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepV = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRepY pixelsWide];i++)
        for (int j=0;j<[imageRepY pixelsHigh];j++) {
            NSColor *tmp=[imageRepY colorAtX:i y:j];
            
            double R=[tmp redComponent];
            double G=[tmp greenComponent];
            double B=[tmp blueComponent];
            
            double Y=conv_yuv.val(0,0)*R+conv_yuv.val(0,1)*G+conv_yuv.val(0,2)*B;
            double U=conv_yuv.val(1,0)*R+conv_yuv.val(1,1)*G+conv_yuv.val(1,2)*B;
            double V=conv_yuv.val(2,0)*R+conv_yuv.val(2,1)*G+conv_yuv.val(2,2)*B;

            imgOriY.set(i, j, Y);
            #ifdef M444
                imgOriU.set(i, j, U);
                imgOriV.set(i, j, V);
            #else
                if (i%2-1) {
                    imgOriU.set(i, j, (j%2-1)?U:imgOriU.val(i, j-1));
                    imgOriV.set(i, j, (j%2-1)?V:imgOriV.val(i, j-1));
                } else {
                    imgOriU.set(i, j, imgOriU.val(i-1, j));
                    imgOriV.set(i, j, imgOriV.val(i-1, j));
                }
            #endif

            
            tmp=[NSColor colorWithDeviceRed:imgOriY.val(i,j)   green:imgOriY.val(i,j) blue:imgOriY.val(i,j)  alpha:ALPHA_VALUE];
            [imageRepY setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgOriU.val(i,j)+UV_Alteration   green:imgOriU.val(i,j)+UV_Alteration blue:imgOriU.val(i,j)+UV_Alteration  alpha:ALPHA_VALUE];
            [imageRepU setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgOriV.val(i,j)+UV_Alteration   green:imgOriV.val(i,j)+UV_Alteration blue:imgOriV.val(i,j)+UV_Alteration  alpha:ALPHA_VALUE];
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
    imgDCTY=imgOriY.dct2();
    imgDCTU=imgOriU.dct2();
    imgDCTV=imgOriV.dct2();
    
    NSBitmapImageRep* imageRepY = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepU = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepV = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRepY pixelsWide];i++)
        for (int j=0;j<[imageRepY pixelsHigh];j++) {
            NSColor *tmp;
            if (int(imgDCTY.val(i, j)*255))
                tmp=[NSColor colorWithDeviceRed:1   green:1 blue:1  alpha:ALPHA_VALUE];
            else
                tmp=[NSColor colorWithDeviceRed:0   green:0 blue:0  alpha:ALPHA_VALUE];
            [imageRepY setColor:tmp atX:i y:j];
            if (int(imgDCTU.val(i, j)*255))
                tmp=[NSColor colorWithDeviceRed:1   green:1 blue:1  alpha:ALPHA_VALUE];
            else
                tmp=[NSColor colorWithDeviceRed:0   green:0 blue:0  alpha:ALPHA_VALUE];
            [imageRepU setColor:tmp atX:i y:j];
            if (int(imgDCTV.val(i, j)*255))
                tmp=[NSColor colorWithDeviceRed:1   green:1 blue:1  alpha:ALPHA_VALUE];
            else
                tmp=[NSColor colorWithDeviceRed:0   green:0 blue:0  alpha:ALPHA_VALUE];
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
            tmp=[NSColor colorWithDeviceRed:imgIDCTU.val(i,j)+UV_Alteration   green:imgIDCTU.val(i,j)+UV_Alteration blue:imgIDCTU.val(i,j)+UV_Alteration  alpha:ALPHA_VALUE];
            [imageRepU setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgIDCTV.val(i,j)+UV_Alteration   green:imgIDCTV.val(i,j)+UV_Alteration blue:imgIDCTV.val(i,j)+UV_Alteration  alpha:ALPHA_VALUE];
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
#ifdef YIQ
    Jmatrix conv_rgb(3,3,
                     1.0, 0.956, 0.621,
                     1.0, -0.272, -0.647,
                     1.0, -1.106, 0.0
                     );
#else //YUV
    Jmatrix conv_rgb(3,3,
                     1.0, 0.0, 1.13983,
                     1.0, -0.39465, -0.58060,
                     1.0, 2.03211, 0.0
                     );
#endif
    NSBitmapImageRep* imageRep = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRep pixelsWide];i++)
        for (int j=0;j<[imageRep pixelsHigh];j++) {
            NSColor *tmp=[imageRep colorAtX:i y:j];
            
            double Y = imgIDCTY.val(i, j);
            double U = imgIDCTU.val(i, j);
            double V = imgIDCTV.val(i, j);
            
            double R=conv_rgb.val(0, 0)*Y+conv_rgb.val(0, 1)*U+conv_rgb.val(0, 2)*V;
            double G=conv_rgb.val(1, 0)*Y+conv_rgb.val(1, 1)*U+conv_rgb.val(1, 2)*V;
            double B=conv_rgb.val(2, 0)*Y+conv_rgb.val(2, 1)*U+conv_rgb.val(2, 2)*V;

            
            tmp=[NSColor colorWithDeviceRed:R   green:G blue:B  alpha:ALPHA_VALUE];
            [imageRep setColor:tmp atX:i y:j];
            
        }
    
    NSImage *imageY = [[NSImage alloc] initWithCGImage:[imageRep CGImage] size:NSMakeSize([imageRep pixelsWide],[imageRep pixelsHigh])];
    [imgConvRGB setImage:imageY];
}

- (IBAction)generateQUAN:(id)sender {
    NSTextField* quanti[8][8]= {
        {t00,t01,t02,t03,t04,t05,t06,t07},
        {t10,t11,t12,t13,t14,t15,t16,t17},
        {t20,t21,t22,t23,t24,t25,t26,t27},
        {t30,t31,t32,t33,t34,t35,t36,t37},
        
        {t40,t41,t42,t43,t44,t45,t46,t47},
        {t50,t51,t52,t53,t54,t55,t56,t57},
        {t60,t61,t62,t63,t64,t65,t66,t67},
        {t70,t71,t72,t73,t74,t75,t76,t77}
    };
    NSBitmapImageRep* imageRepY = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepU = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepV = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRepY pixelsWide];i++)
        for (int j=0;j<[imageRepY pixelsHigh];j++) {
            NSColor *tmp;
            int A,B,C;
            
            A=imgDCTY.val(i, j)*255;
            B=imgDCTU.val(i, j)*255;
            C=imgDCTV.val(i, j)*255;
            
            A/=([quanti[i%8][j%8] intValue]==0)?1:[quanti[i%8][j%8] intValue];
            B/=([quanti[i%8][j%8] intValue]==0)?1:[quanti[i%8][j%8] intValue];
            C/=([quanti[i%8][j%8] intValue]==0)?1:[quanti[i%8][j%8] intValue];
            
            A*=([quanti[i%8][j%8] intValue]==0)?1:[quanti[i%8][j%8] intValue];
            B*=([quanti[i%8][j%8] intValue]==0)?1:[quanti[i%8][j%8] intValue];
            C*=([quanti[i%8][j%8] intValue]==0)?1:[quanti[i%8][j%8] intValue];
            
            imgQUANY.set(i, j, (double)A/255);
            imgQUANU.set(i, j, (double)B/255);
            imgQUANV.set(i, j, (double)C/255);
            
            if (int(imgQUANY.val(i, j)*255))
                tmp=[NSColor colorWithDeviceRed:1   green:1 blue:1  alpha:ALPHA_VALUE];
            else
                tmp=[NSColor colorWithDeviceRed:0   green:0 blue:0  alpha:ALPHA_VALUE];
            [imageRepY setColor:tmp atX:i y:j];
            if (int(imgQUANU.val(i, j)*255))
                tmp=[NSColor colorWithDeviceRed:1   green:1 blue:1  alpha:ALPHA_VALUE];
            else
                tmp=[NSColor colorWithDeviceRed:0   green:0 blue:0  alpha:ALPHA_VALUE];
            [imageRepU setColor:tmp atX:i y:j];
            if (int(imgQUANV.val(i, j)*255))
                tmp=[NSColor colorWithDeviceRed:1   green:1 blue:1  alpha:ALPHA_VALUE];
            else
                tmp=[NSColor colorWithDeviceRed:0   green:0 blue:0  alpha:ALPHA_VALUE];
            [imageRepV setColor:tmp atX:i y:j];
            
        }
    
    NSImage *imageY = [[NSImage alloc] initWithCGImage:[imageRepY CGImage] size:NSMakeSize([imageRepY pixelsWide],[imageRepY pixelsHigh])];
    [imgConv3 setImage:imageY];
    NSImage *imageU = [[NSImage alloc] initWithCGImage:[imageRepU CGImage] size:NSMakeSize([imageRepU pixelsWide],[imageRepU pixelsHigh])];
    [imgConv9 setImage:imageU];
    NSImage *imageV = [[NSImage alloc] initWithCGImage:[imageRepV CGImage] size:NSMakeSize([imageRepV pixelsWide],[imageRepV pixelsHigh])];
    [imgConv10 setImage:imageV];
}

- (IBAction)quanti0:(id)sender {
    NSTextField* quanti[8][8]= {
        {t00,t01,t02,t03,t04,t05,t06,t07},
        {t10,t11,t12,t13,t14,t15,t16,t17},
        {t20,t21,t22,t23,t24,t25,t26,t27},
        {t30,t31,t32,t33,t34,t35,t36,t37},
        
        {t40,t41,t42,t43,t44,t45,t46,t47},
        {t50,t51,t52,t53,t54,t55,t56,t57},
        {t60,t61,t62,t63,t64,t65,t66,t67},
        {t70,t71,t72,t73,t74,t75,t76,t77}
    };
    int tmp[8][8]={
        {16, 11, 10, 16, 24, 40, 51, 61},
        {12, 12, 14, 19, 26, 58, 60, 55},
        {14, 13, 16, 24, 40, 57, 69, 56},
        {14, 17, 22, 29, 51, 87, 80, 62},
        
        {18, 22, 37, 56, 68, 109, 103, 77},
        {24, 35, 55, 64, 81, 104, 113, 92},
        {49, 64, 78, 87, 103, 121, 120, 101},
        {72, 92, 95, 98, 112, 100, 103, 99}
    };
    
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++)
            [quanti[i][j] setIntValue:tmp[i][j] ];
}
- (IBAction)quanti1:(id)sender {
    NSTextField* quanti[8][8]= {
        {t00,t01,t02,t03,t04,t05,t06,t07},
        {t10,t11,t12,t13,t14,t15,t16,t17},
        {t20,t21,t22,t23,t24,t25,t26,t27},
        {t30,t31,t32,t33,t34,t35,t36,t37},
        
        {t40,t41,t42,t43,t44,t45,t46,t47},
        {t50,t51,t52,t53,t54,t55,t56,t57},
        {t60,t61,t62,t63,t64,t65,t66,t67},
        {t70,t71,t72,t73,t74,t75,t76,t77}
    };
    int tmp[8][8]={
        {8, 5, 5, 8, 12, 20, 25, 30},
        {6, 6, 7, 9, 13, 29, 30, 27},
        {7, 6, 8, 12, 20, 28, 34, 28},
        {7, 8, 11, 14, 25, 43, 40, 31},
        
        {9, 11, 18, 28, 34, 54, 51, 38},
        {12, 17, 27, 32, 40, 52, 56, 46},
        {24, 32, 39, 43, 51, 60, 60, 50},
        {36, 46, 47, 49, 56, 50, 51, 49}
    };
    
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++)
            [quanti[i][j] setIntValue:tmp[i][j] ];
}
- (IBAction)quanti2:(id)sender {
    NSTextField* quanti[8][8]= {
        {t00,t01,t02,t03,t04,t05,t06,t07},
        {t10,t11,t12,t13,t14,t15,t16,t17},
        {t20,t21,t22,t23,t24,t25,t26,t27},
        {t30,t31,t32,t33,t34,t35,t36,t37},
        
        {t40,t41,t42,t43,t44,t45,t46,t47},
        {t50,t51,t52,t53,t54,t55,t56,t57},
        {t60,t61,t62,t63,t64,t65,t66,t67},
        {t70,t71,t72,t73,t74,t75,t76,t77}
    };
    int tmp[8][8]={
        {16<<2, 11<<2, 10<<2, 16<<2, 24<<2, 40<<2, 51<<2, 61<<2},
        {12<<2, 12<<2, 14<<2, 19<<2, 26<<2, 58<<2, 60<<2, 55<<2},
        {14<<2, 13<<2, 16<<2, 24<<2, 40<<2, 57<<2, 69<<2, 56<<2},
        {14<<2, 17<<2, 22<<2, 29<<2, 51<<2, 87<<2, 80<<2, 62<<2},
        
        {18<<2, 22<<2, 37<<2, 56<<2, 68<<2, 109<<2, 103<<2, 77<<2},
        {24<<2, 35<<2, 55<<2, 64<<2, 81<<2, 104<<2, 113<<2, 92<<2},
        {49<<2, 64<<2, 78<<2, 87<<2, 103<<2, 121<<2, 120<<2, 101<<2},
        {72<<2, 92<<2, 95<<2, 98<<2, 112<<2, 100<<2, 103<<2, 99<<2}
    };
    
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++)
            [quanti[i][j] setIntValue:tmp[i][j] ];
}
- (IBAction)quanti3:(id)sender {
    NSTextField* quanti[8][8]= {
        {t00,t01,t02,t03,t04,t05,t06,t07},
        {t10,t11,t12,t13,t14,t15,t16,t17},
        {t20,t21,t22,t23,t24,t25,t26,t27},
        {t30,t31,t32,t33,t34,t35,t36,t37},
        
        {t40,t41,t42,t43,t44,t45,t46,t47},
        {t50,t51,t52,t53,t54,t55,t56,t57},
        {t60,t61,t62,t63,t64,t65,t66,t67},
        {t70,t71,t72,t73,t74,t75,t76,t77}
    };
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++)
            [quanti[i][j] setIntValue:32 ];
}
- (IBAction)quanti4:(id)sender {
    NSTextField* quanti[8][8]= {
        {t00,t01,t02,t03,t04,t05,t06,t07},
        {t10,t11,t12,t13,t14,t15,t16,t17},
        {t20,t21,t22,t23,t24,t25,t26,t27},
        {t30,t31,t32,t33,t34,t35,t36,t37},
        
        {t40,t41,t42,t43,t44,t45,t46,t47},
        {t50,t51,t52,t53,t54,t55,t56,t57},
        {t60,t61,t62,t63,t64,t65,t66,t67},
        {t70,t71,t72,t73,t74,t75,t76,t77}
    };
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++)
            [quanti[i][j] setIntValue:2 ];
}
- (IBAction)quanti5:(id)sender {
    NSTextField* quanti[8][8]= {
        {t00,t01,t02,t03,t04,t05,t06,t07},
        {t10,t11,t12,t13,t14,t15,t16,t17},
        {t20,t21,t22,t23,t24,t25,t26,t27},
        {t30,t31,t32,t33,t34,t35,t36,t37},
        
        {t40,t41,t42,t43,t44,t45,t46,t47},
        {t50,t51,t52,t53,t54,t55,t56,t57},
        {t60,t61,t62,t63,t64,t65,t66,t67},
        {t70,t71,t72,t73,t74,t75,t76,t77}
    };
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++)
            [quanti[i][j] setIntValue:128 ];
}

- (void)openFile:(id)sender {
    NSOpenPanel* openPanel = [NSOpenPanel openPanel];
    
    openPanel.title = @"Choose a .jpg file (max size 300*300)";
    openPanel.showsResizeIndicator = YES;
    openPanel.showsHiddenFiles = NO;
    openPanel.canChooseDirectories = NO;
    openPanel.canCreateDirectories = YES;
    openPanel.allowsMultipleSelection = NO;
    openPanel.allowedFileTypes = @[@"jpg"];
    
    [openPanel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL*  theDoc = [[openPanel URLs] objectAtIndex:0];
            NSLog(@"%@",[theDoc absoluteURL]);
            defImage = [[NSImage alloc] initWithContentsOfURL:theDoc];
            
            [imgOriginal    setImage:defImage];
        }
                          
    }];
}


- (IBAction)displayDCT:(id)sender {
    NSBitmapImageRep* imageRep = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    int x=[displayX intValue];
    int y=[displayY intValue];
    if (x*8>[imageRep pixelsWide] || y*8>[imageRep pixelsWide]) return;
    Jmatrix orzY=imgDCTY.sub_val(8, x, y);
    int a[8][8];
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++)
            a[i][j]=orzY.val(i, j)*255;
    int i=0;
    NSString *tmp=[[NSString alloc]initWithFormat:@"%4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n",
        a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
        a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
        a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
        a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
        
        a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
        a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
        a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
        a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7]
    ];
    [displayMatrix setStringValue:tmp];
}
- (IBAction)displayQUAN:(id)sender {
    NSTextField* quanti[8][8]= {
        {t00,t01,t02,t03,t04,t05,t06,t07},
        {t10,t11,t12,t13,t14,t15,t16,t17},
        {t20,t21,t22,t23,t24,t25,t26,t27},
        {t30,t31,t32,t33,t34,t35,t36,t37},
        
        {t40,t41,t42,t43,t44,t45,t46,t47},
        {t50,t51,t52,t53,t54,t55,t56,t57},
        {t60,t61,t62,t63,t64,t65,t66,t67},
        {t70,t71,t72,t73,t74,t75,t76,t77}
    };
    NSBitmapImageRep* imageRep = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    int x=[displayX intValue];
    int y=[displayY intValue];
    if (x*8>[imageRep pixelsWide] || y*8>[imageRep pixelsWide]) return;
    Jmatrix orzY=imgQUANY.sub_val(8, x, y);
    int a[8][8];
    for (int i=0;i<8;i++)
        for (int j=0;j<8;j++)
            a[i][j]=orzY.val(i, j)*255/[quanti[i][j] intValue];
    int i=0;
    NSString *tmp=[[NSString alloc]initWithFormat:@"%4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n %4d, %4d, %4d, %4d, %4d, %4d, %4d, %4d\n",
                   a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
                   a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
                   a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
                   a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
                   
                   a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
                   a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
                   a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7],
                   a[i][0], a[i][1], a[i][2], a[i][3], a[i][4], a[i][5], a[i][6], a[i++][7]
                   ];
    [displayMatrix setStringValue:tmp];
}
@end