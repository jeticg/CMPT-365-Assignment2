//
//  image.hpp
//  CMPT-365-PA2
//
//  Created by Jetic Gu on 17.02.16.
//  Copyright © 2016 Jetic Gu. All rights reserved.
//

#ifndef image_hpp
#define image_hpp

#include <stdio.h>
#include "jmatrix.hpp"
#include </usr/local/include/jpeglib.h>

#endif /* image_hpp */

class Image {
private:
    int *bmap_value;
    int height_value, width_value, depth_value;
public:
    Image();
    Image(FILE *infile);
};