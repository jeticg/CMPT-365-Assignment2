//
//  ViewController.m
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#import "ViewController.h"
#include "image.hpp"

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
    [self generateYUV];
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

- (void)generateYUV {
    NSBitmapImageRep* imageRep = [[NSBitmapImageRep alloc] initWithData:[defImage TIFFRepresentation]];
    unsigned char* bmap = [imageRep bitmapData];
    
}

@end