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
    [self generateYUV];
    // Do any additional setup after loading the view.
}

- (void)generateYUV {
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
    NSBitmapImageRep* imageRepY = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepU = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepV = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRepY pixelsWide];i++)
        for (int j=0;j<[imageRepY pixelsHigh];j++) {
            NSColor *tmp=[imageRepY colorAtX:i y:j];
            
            Vector c;
            c.set(0, [tmp redComponent]);
            c.set(1, [tmp greenComponent]);
            c.set(2, [tmp blueComponent]);
            
            c=conv_yuv*c;

            imgOriY.set(i, j, c.val(0));
            #ifdef M444
                imgOriU.set(i, j, c.val(1));
                imgOriV.set(i, j, c.val(2));
            #else
                if (i%2) {
                    imgOriU.set(i, j, (j%2)?c.val(1):imgOriU.val(i, j-1));
                    imgOriV.set(i, j, (i%2)?c.val(2):imgOriV.val(i, j-1));
                } else {
                    imgOriU.set(i, j, imgOriU.val(i-1, j));
                    imgOriV.set(i, j, imgOriV.val(i-1, j));
                }
            #endif

            
            tmp=[NSColor colorWithDeviceRed:imgOriY.val(i,j)   green:imgOriY.val(i,j) blue:imgOriY.val(i,j)  alpha:0];
            [imageRepY setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgOriU.val(i,j)   green:imgOriU.val(i,j) blue:imgOriU.val(i,j)  alpha:0];
            [imageRepU setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgOriV.val(i,j)   green:imgOriV.val(i,j) blue:imgOriV.val(i,j)  alpha:0];
            [imageRepV setColor:tmp atX:i y:j];
            
        }
    
    NSImage *imageY = [[NSImage alloc] initWithCGImage:[imageRepY CGImage] size:NSMakeSize([imageRepY pixelsWide],[imageRepY pixelsHigh])];
    [imgConv1 setImage:imageY];
    NSImage *imageU = [[NSImage alloc] initWithCGImage:[imageRepU CGImage] size:NSMakeSize([imageRepU pixelsWide],[imageRepU pixelsHigh])];
    [imgConv5 setImage:imageU];
    NSImage *imageV = [[NSImage alloc] initWithCGImage:[imageRepV CGImage] size:NSMakeSize([imageRepV pixelsWide],[imageRepV pixelsHigh])];
    [imgConv6 setImage:imageV];
}

- (void)generateDCT {
    imgDCTY=imgOriY.dct2_8x8();
    imgDCTU=imgOriU.dct2_8x8();
    imgDCTV=imgOriV.dct2_8x8();
    
    NSBitmapImageRep* imageRepY = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepU = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    NSBitmapImageRep* imageRepV = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    
    for (int i=0;i<[imageRepY pixelsWide];i++)
        for (int j=0;j<[imageRepY pixelsHigh];j++) {
            NSColor *tmp;
            
            tmp=[NSColor colorWithDeviceRed:imgDCTY.val(i,j)   green:imgDCTY.val(i,j) blue:imgDCTY.val(i,j)  alpha:0];
            [imageRepY setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgDCTU.val(i,j)   green:imgDCTU.val(i,j) blue:imgDCTU.val(i,j)  alpha:0];
            [imageRepU setColor:tmp atX:i y:j];
            tmp=[NSColor colorWithDeviceRed:imgDCTV.val(i,j)   green:imgDCTV.val(i,j) blue:imgDCTV.val(i,j)  alpha:0];
            [imageRepV setColor:tmp atX:i y:j];
            
        }
    
    NSImage *imageY = [[NSImage alloc] initWithCGImage:[imageRepY CGImage] size:NSMakeSize([imageRepY pixelsWide],[imageRepY pixelsHigh])];
    [imgConv2 setImage:imageY];
    NSImage *imageU = [[NSImage alloc] initWithCGImage:[imageRepU CGImage] size:NSMakeSize([imageRepU pixelsWide],[imageRepU pixelsHigh])];
    [imgConv7 setImage:imageU];
    NSImage *imageV = [[NSImage alloc] initWithCGImage:[imageRepV CGImage] size:NSMakeSize([imageRepV pixelsWide],[imageRepV pixelsHigh])];
    [imgConv8 setImage:imageV];
    
}
@end