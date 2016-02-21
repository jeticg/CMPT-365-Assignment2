//
//  ViewController.h
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "jmatrix.hpp"

@interface ViewController : NSViewController {
    NSImage *defImage;
    Jmatrix imgOriY;
    Jmatrix imgOriU;
    Jmatrix imgOriV;
    
    Jmatrix imgDCTY;
    Jmatrix imgDCTU;
    Jmatrix imgDCTV;
    
    Jmatrix imgQUANY;
    Jmatrix imgQUANU;
    Jmatrix imgQUANV;
    
    Jmatrix imgIDCTY;
    Jmatrix imgIDCTU;
    Jmatrix imgIDCTV;
    
    NSImageView* imgOriginal;
    NSImageView* imgConv1;
    NSImageView* imgConv2;
    NSImageView* imgConv3;
    NSImageView* imgConv4;
    
    NSImageView* imgConv5;
    NSImageView* imgConv6;
    NSImageView* imgConv7;
    NSImageView* imgConv8;
    
    
    NSImageView* imgConv9;
    NSImageView* imgConv10;
    NSImageView* imgConv11;
    NSImageView* imgConv12;
    
    NSImageView* imgConvRGB;
    
    NSTextField* t00; NSTextField* t10; NSTextField* t20; NSTextField* t30;
    NSTextField* t01; NSTextField* t11; NSTextField* t21; NSTextField* t31;
    NSTextField* t02; NSTextField* t12; NSTextField* t22; NSTextField* t32;
    NSTextField* t03; NSTextField* t13; NSTextField* t23; NSTextField* t33;
    NSTextField* t04; NSTextField* t14; NSTextField* t24; NSTextField* t34;
    NSTextField* t05; NSTextField* t15; NSTextField* t25; NSTextField* t35;
    NSTextField* t06; NSTextField* t16; NSTextField* t26; NSTextField* t36;
    NSTextField* t07; NSTextField* t17; NSTextField* t27; NSTextField* t37;
    
    NSTextField* t40; NSTextField* t50; NSTextField* t60; NSTextField* t70;
    NSTextField* t41; NSTextField* t51; NSTextField* t61; NSTextField* t71;
    NSTextField* t42; NSTextField* t52; NSTextField* t62; NSTextField* t72;
    NSTextField* t43; NSTextField* t53; NSTextField* t63; NSTextField* t73;
    NSTextField* t44; NSTextField* t54; NSTextField* t64; NSTextField* t74;
    NSTextField* t45; NSTextField* t55; NSTextField* t65; NSTextField* t75;
    NSTextField* t46; NSTextField* t56; NSTextField* t66; NSTextField* t76;
    NSTextField* t47; NSTextField* t57; NSTextField* t67; NSTextField* t77;
}
@property(retain) IBOutlet NSImageView* imgOriginal;
@property(retain) IBOutlet NSImageView* imgConv1;
@property(retain) IBOutlet NSImageView* imgConv2;
@property(retain) IBOutlet NSImageView* imgConv3;
@property(retain) IBOutlet NSImageView* imgConv4;

@property(retain) IBOutlet NSImageView* imgConv5;
@property(retain) IBOutlet NSImageView* imgConv6;
@property(retain) IBOutlet NSImageView* imgConv7;
@property(retain) IBOutlet NSImageView* imgConv8;

@property(retain) IBOutlet NSImageView* imgConv9;
@property(retain) IBOutlet NSImageView* imgConv10;
@property(retain) IBOutlet NSImageView* imgConv11;
@property(retain) IBOutlet NSImageView* imgConv12;
@property(retain) IBOutlet NSImageView* imgConvRGB;

@property(retain) IBOutlet NSTextField* t00;
@property(retain) IBOutlet NSTextField* t01;
@property(retain) IBOutlet NSTextField* t02;
@property(retain) IBOutlet NSTextField* t03;
@property(retain) IBOutlet NSTextField* t04;
@property(retain) IBOutlet NSTextField* t05;
@property(retain) IBOutlet NSTextField* t06;
@property(retain) IBOutlet NSTextField* t07;

@property(retain) IBOutlet NSTextField* t10;
@property(retain) IBOutlet NSTextField* t11;
@property(retain) IBOutlet NSTextField* t12;
@property(retain) IBOutlet NSTextField* t13;
@property(retain) IBOutlet NSTextField* t14;
@property(retain) IBOutlet NSTextField* t15;
@property(retain) IBOutlet NSTextField* t16;
@property(retain) IBOutlet NSTextField* t17;

@property(retain) IBOutlet NSTextField* t20;
@property(retain) IBOutlet NSTextField* t21;
@property(retain) IBOutlet NSTextField* t22;
@property(retain) IBOutlet NSTextField* t23;
@property(retain) IBOutlet NSTextField* t24;
@property(retain) IBOutlet NSTextField* t25;
@property(retain) IBOutlet NSTextField* t26;
@property(retain) IBOutlet NSTextField* t27;

@property(retain) IBOutlet NSTextField* t30;
@property(retain) IBOutlet NSTextField* t31;
@property(retain) IBOutlet NSTextField* t32;
@property(retain) IBOutlet NSTextField* t33;
@property(retain) IBOutlet NSTextField* t34;
@property(retain) IBOutlet NSTextField* t35;
@property(retain) IBOutlet NSTextField* t36;
@property(retain) IBOutlet NSTextField* t37;

@property(retain) IBOutlet NSTextField* t40;
@property(retain) IBOutlet NSTextField* t41;
@property(retain) IBOutlet NSTextField* t42;
@property(retain) IBOutlet NSTextField* t43;
@property(retain) IBOutlet NSTextField* t44;
@property(retain) IBOutlet NSTextField* t45;
@property(retain) IBOutlet NSTextField* t46;
@property(retain) IBOutlet NSTextField* t47;

@property(retain) IBOutlet NSTextField* t50;
@property(retain) IBOutlet NSTextField* t51;
@property(retain) IBOutlet NSTextField* t52;
@property(retain) IBOutlet NSTextField* t53;
@property(retain) IBOutlet NSTextField* t54;
@property(retain) IBOutlet NSTextField* t55;
@property(retain) IBOutlet NSTextField* t56;
@property(retain) IBOutlet NSTextField* t57;

@property(retain) IBOutlet NSTextField* t60;
@property(retain) IBOutlet NSTextField* t61;
@property(retain) IBOutlet NSTextField* t62;
@property(retain) IBOutlet NSTextField* t63;
@property(retain) IBOutlet NSTextField* t64;
@property(retain) IBOutlet NSTextField* t65;
@property(retain) IBOutlet NSTextField* t66;
@property(retain) IBOutlet NSTextField* t67;

@property(retain) IBOutlet NSTextField* t70;
@property(retain) IBOutlet NSTextField* t71;
@property(retain) IBOutlet NSTextField* t72;
@property(retain) IBOutlet NSTextField* t73;
@property(retain) IBOutlet NSTextField* t74;
@property(retain) IBOutlet NSTextField* t75;
@property(retain) IBOutlet NSTextField* t76;
@property(retain) IBOutlet NSTextField* t77;

- (IBAction)generateYUV:(id)sender;
- (IBAction)generateDCT:(id)sender;
- (IBAction)generateIDCT:(id)sender;
- (IBAction)generateRGB:(id)sender;
- (IBAction)generateQUAN:(id)sender;

- (IBAction)quanti0:(id)sender;
- (IBAction)quanti1:(id)sender;
- (IBAction)quanti2:(id)sender;
- (IBAction)quanti3:(id)sender;
- (IBAction)quanti4:(id)sender;
- (IBAction)quanti5:(id)sender;
@end
