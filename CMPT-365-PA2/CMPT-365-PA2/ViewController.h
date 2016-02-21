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

- (IBAction)generateYUV:(id)sender;
- (IBAction)generateDCT:(id)sender;
- (IBAction)generateIDCT:(id)sender;
- (IBAction)generateRGB:(id)sender;
- (IBAction)generateQUAN:(id)sender;

@end
