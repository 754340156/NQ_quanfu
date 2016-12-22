//
//  UIImage+Blurry.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/15.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blurry)

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

@end
