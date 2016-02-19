//
//  ViewController.h
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController {
    NSImageView* imgOriginal;
    NSImageView* imgConvYUV;
    NSImageView* imgConv2;
    NSImageView* imgConv3;
    NSImageView* imgConv4;
    NSImageView* imgConvRGB;
}
@property(retain) IBOutlet NSImageView* imgOriginal;
@property(retain) IBOutlet NSImageView* imgConvYUV;
@property(retain) IBOutlet NSImageView* imgConv2;
@property(retain) IBOutlet NSImageView* imgConv3;
@property(retain) IBOutlet NSImageView* imgConv4;
@property(retain) IBOutlet NSImageView* imgConvRGB;

@end
