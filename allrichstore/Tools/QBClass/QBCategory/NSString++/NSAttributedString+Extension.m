//
//  NSAttributedString+Extension.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/13.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

//简写属性字符串 自定义文字颜色
+ (NSAttributedString *)attributedStringWithString:(NSString *)string color:(UIColor *)color
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = color;
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    return attributedStr;
}

//简写属性字符串 自定义文字颜色和字体
+ (NSAttributedString *)attributedStringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = color;
    attrs[NSFontAttributeName] = font;
    NSAttributedString *attributedStr = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    return attributedStr;
}

@end
