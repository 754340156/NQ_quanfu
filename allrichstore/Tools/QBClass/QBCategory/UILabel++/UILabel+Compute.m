//
//  UILabel+Compute.m
//  LiveTest
//
//  Created by 任强宾 on 16/9/14.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "UILabel+Compute.h"

@implementation UILabel (Compute)

//计算字符串宽度(单行)
- (CGFloat)getWidth
{
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    return rect.size.width;
}

//计算字符串的高度(单行)
- (CGFloat)getHeight
{
    CGSize size = [@"哈哈" sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGFloat height = ceilf(size.height);
    NSInteger lineNum = (self.numberOfLines == 0) ? 1 : self.numberOfLines;
    return height * lineNum;
}


//计算文字绘制所需大小
- (CGSize)getSize
{
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
}

//计算文字绘制所需大小
- (CGSize)getSizeWithWidth:(CGFloat)width
{
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    return CGSizeMake(ceilf(rect.size.width), ceilf(rect.size.height));
}

//计算文字绘制所需大小
+ (CGFloat)getHeightWithFont:(UIFont *)font
{
    CGRect rect = [@"哈哈" boundingRectWithSize:CGSizeMake(1000, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceilf(rect.size.height);
}

//计算文字绘制所需宽度
+ (CGFloat)getWidthWithFont:(UIFont *)font text:(NSString *)text
{
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat width = ceilf(size.width);
    return width;
}

//计算文字绘制所需宽度
- (CGFloat)getWidthWithText:(NSString *)text
{
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGFloat width = ceilf(size.width);
    return width;
}

//根据字体,宽度绘制所需高度
+ (CGFloat)getHeightWithFont:(UIFont *)font Width:(CGFloat)width text:(NSString *)text
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceilf(rect.size.height);
}
@end
