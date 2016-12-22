//
//  QBComputeManger.h
//  RQBClass
//
//  Created by apple on 15/1/12.
//  Copyright © 2015年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBComputeManger : NSObject

#pragma mark - 根据字符串及其属性 --> 获取字符串宽高

//通过字符串及其属性获取字符串的宽度
+ (CGFloat)getWidthByString:(NSString *)string
                 Attributes:(NSDictionary *)Attributes;

//通过字符串及其属性获取字符串的高度
+ (CGFloat)getHeightByString:(NSString *)string
                  Attributes:(NSDictionary *)Attributes;

//获取字符串的宽度
+ (CGFloat)widthForString:(NSString *)text fontSize:(CGFloat)fontSize andHeight:(CGFloat)height;

//通过label求出label自适应需要的高度
+ (CGFloat)getAutoHeightForLabel:(UILabel *)label
                       withWidth:(CGFloat)width;


//通过string和字体大小求出text自适应需要的高度
+ (CGFloat)getAutoHeightForString:(NSString *)String
                        withWidth:(CGFloat)width
                     withFontSize:(CGFloat)fontSize;


@end
