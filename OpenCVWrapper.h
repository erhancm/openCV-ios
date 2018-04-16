//
//  OpenCVWrapper.h
//  openCV
//
//  Created by Cem Comert on 14-04-18.
//  Copyright © 2018 HAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

//function to get the current openCV version
+(NSString *) openCVVersion;

//function to convert an RGB image to grayscale
+(UIImage *) convertToGray:(UIImage *) image;

//function to apply a Gaussian blur
+(UIImage *) gaussianBlur:(UIImage *) image kernelSize:(int)kernelSize;

//function to binarize the image
+(UIImage *) binarizeImage:(UIImage *) image;

@end
