//
//  NSAttributedString+Extension.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/13.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Extension)

//简写属性字符串 自定义文字颜色
+ (NSAttributedString *)attributedStringWithString:(NSString *)string color:(UIColor *)color;

//简写属性字符串 自定义文字颜色和字体
+ (NSAttributedString *)attributedStringWithString:(NSString *)string color:(UIColor *)color font:(UIFont *)font;

@end
