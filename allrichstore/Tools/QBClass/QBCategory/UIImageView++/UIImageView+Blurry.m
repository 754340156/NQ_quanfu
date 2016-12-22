//
//  UIImageView+Blurry.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/15.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "UIImageView+Blurry.h"

@implementation UIImageView (Blurry)

- (UIImage *)blurryImage:(UIImage *)image
           withBlurLevel:(CGFloat)blur {
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                  keysAndValues:kCIInputImageKey, inputImage,
                        @"inputRadius", @(blur),
                        nil];
    CIImage *outputCIImage = filter.outputImage;
    
    UIImage *blurryImage = [UIImage imageWithCGImage:[context createCGImage:outputCIImage fromRect:outputCIImage.extent]];
    
    return blurryImage;
}

@end
