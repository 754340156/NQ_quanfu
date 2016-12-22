//
//  UILabel+Compute.h
//  LiveTest
//
//  Created by 任强宾 on 16/9/14.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Compute)

//计算字符串宽度(单行)
- (CGFloat)getWidth;

//计算字符串的高度(单行)
- (CGFloat)getHeight;

//计算文字绘制所需大小
- (CGSize)getSize;

//计算文字绘制所需大小
- (CGSize)getSizeWithWidth:(CGFloat)width;

//计算文字绘制所需高度
+ (CGFloat)getHeightWithFont:(UIFont *)font;

//计算文字绘制所需宽度
+ (CGFloat)getWidthWithFont:(UIFont *)font text:(NSString *)text;

//计算文字绘制所需宽度
- (CGFloat)getWidthWithText:(NSString *)text;

//根据字体,宽度绘制所需高度
+ (CGFloat)getHeightWithFont:(UIFont *)font Width:(CGFloat)width text:(NSString *)text;
@end
