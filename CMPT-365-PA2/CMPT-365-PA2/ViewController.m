//
//  ViewController.m
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize imgOriginal;
@synthesize imgConvYUV;
@synthesize imgConv2;
@synthesize imgConv3;
@synthesize imgConv4;
@synthesize imgConvRGB;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSImage *defImage;
    defImage = [NSImage imageNamed:@"default.jpg"];
    [imgOriginal    setImage:defImage];
    [imgConvYUV     setImage:defImage];
    [imgConv2       setImage:defImage];
    [imgConv3       setImage:defImage];
    [imgConv4       setImage:defImage];
    [imgConvRGB     setImage:defImage];
    // Do any additional setup after loading the view.
}

@end