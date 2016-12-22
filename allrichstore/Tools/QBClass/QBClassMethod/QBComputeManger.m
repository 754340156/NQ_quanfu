//
//  QBComputeManger.m
//  RQBClass
//
//  Created by apple on 15/1/12.
//  Copyright © 2015年 任强宾. All rights reserved.
//

#import "QBComputeManger.h"

@implementation QBComputeManger

#pragma mark - 根据字符串及其属性 --> 获取字符串宽高

//通过字符串及其属性获取字符串的宽度
+ (CGFloat)getWidthByString:(NSString *)string
                 Attributes:(NSDictionary *)Attributes
{
    CGSize size =  [string sizeWithAttributes:Attributes];
    return size.width;
}

//通过字符串及其属性获取字符串的高度
+ (CGFloat)getHeightByString:(NSString *)string
                  Attributes:(NSDictionary *)Attributes
{
    CGSize size = [string sizeWithAttributes:Attributes];
    return size.height;
}

//通过label求出label自适应需要的高度
+ (CGFloat)getAutoHeightForLabel:(UILabel *)label
                       withWidth:(CGFloat)width
{
    // 01: 约定绘制文本的最大范围
    // 02: 绘制文本的方式, 枚举类型
    // 03: 绘制文本的属性, 字体大小/行的截取方式等.
    NSDictionary *dic = @{NSFontAttributeName :label.font};
    CGFloat height = [label.text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}

//通过string和字体大小求出text自适应需要的高度
+ (CGFloat)getAutoHeightForString:(NSString *)String
                        withWidth:(CGFloat)width
                     withFontSize:(CGFloat)fontSize
{
    // 01: 约定绘制文本的最大范围
    // 02: 绘制文本的方式, 枚举类型
    // 03: 绘制文本的属性, 字体大小/行的截取方式等.
    NSDictionary *dic = @{NSFontAttributeName :[UIFont systemFontOfSize:fontSize]};
    CGFloat height = [String boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}

//获取字符串的宽度
+ (CGFloat)widthForString:(NSString *)text fontSize:(CGFloat)fontSize andHeight:(CGFloat)height
{
    CGSize sizeToFit = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.width;
}

@end
