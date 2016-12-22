//
//  UIColor+QBrgb.m
//  PRJ_CreditRecruit
//
//  Created by 任强宾 on 16/6/27.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import "UIColor+QBrgb.h"

@implementation UIColor (QBrgb)

//不需要除以255.0的颜色配置方法
+ (UIColor *)red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

//16进制的颜色值，转颜色
+ (UIColor *)rgbValue:(NSUInteger)rgbValue alpha:(CGFloat)alpha
{
   return  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                    green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                     blue:((float)(rgbValue & 0xFF))/255.0
                    alpha:alpha];
}

//十六进制颜色值字符串，转颜色
+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor colorWithWhite:1.0 alpha:0.5];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end
