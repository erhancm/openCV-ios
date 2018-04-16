//
//  OpenCVWrapper.m
//  openCV
//
//  Created by Cem Comert on 14-04-18.
//  Copyright © 2018 HAN. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import "OpenCVWrapper.h"

@implementation OpenCVWrapper

+(NSString *) openCVVersion
{
    return [NSString stringWithFormat:@"OpenCV Version: %s", CV_VERSION];
}

+(UIImage *) convertToGray:(UIImage *) image
{
    //create an empty matrix and put the input image in there
    cv::Mat inputImage;
    UIImageToMat(image, inputImage);
    
    //if the image is already grayscale, return it
    if (inputImage.channels() == 1) return image;
    
    //convert to gray
    cv::Mat grayImage;
    cv::cvtColor(inputImage, grayImage, CV_BGR2GRAY);
    
    //transform matrix to image again and return
    return MatToUIImage(grayImage);
}

+(UIImage *) gaussianBlur:(UIImage *) image kernelSize:(int)kernelSize
{
    //create an empty matrix and put the input image in there
    cv::Mat inputImage, outputImage;
    UIImageToMat(image, inputImage);
    
    //blur the image slightly
    cv::Size sigmaXY = cv::Size(kernelSize, kernelSize);
    cv::GaussianBlur(inputImage, outputImage, sigmaXY, 0);
    
    //transform matrix to image again and return
    return MatToUIImage(outputImage);
}

+(UIImage *) binarizeImage:(UIImage *) image
{
    //create an empty matrix and put the input image in there
    cv::Mat inputImage, outputImage;
    UIImageToMat(image, inputImage);
    
    //binarize image
    cv::threshold(inputImage, outputImage, 0, 255, CV_THRESH_BINARY | CV_THRESH_OTSU);
    
    //give the image back
    return MatToUIImage(outputImage);
}


@end
