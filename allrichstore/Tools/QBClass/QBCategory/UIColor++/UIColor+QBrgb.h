//
//  UIColor+QBrgb.h
//  PRJ_CreditRecruit
//
//  Created by 任强宾 on 16/6/27.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (QBrgb)

//不需要除以255.0的颜色配置方法
+ (UIColor *)red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

//16进制的颜色值，转颜色
+ (UIColor *)rgbValue:(NSUInteger)rgbValue alpha:(CGFloat)alpha;

//十六进制颜色值字符串，转颜色
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
