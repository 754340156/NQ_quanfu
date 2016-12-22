//
//  UIFont+QBFont.m
//  PRJ_CreditRecruit
//
//  Created by 任强宾 on 16/5/17.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import "UIFont+QBFont.h"

#define kCustomFontPath @"Fonts"    //自定义字体文件夹的沙盒路径

@implementation UIFont (QBFont)

//系统字体
+ (UIFont *)qbSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont systemFontOfSize:fontSize];
}

//自定义字体（通过沙盒路径取出字体）
+ (UIFont *)customFontWithName:(NSString *)name size:(CGFloat)size
{
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    resourcePath = [resourcePath stringByAppendingPathComponent:kCustomFontPath];
    NSString *path = [resourcePath stringByAppendingPathComponent:name];
    
    NSURL *fontUrl = [NSURL fileURLWithPath:path];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)fontUrl);
    CGFontRef fontRef = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(fontRef, NULL);
    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontRef));
    UIFont *font = [UIFont fontWithName:fontName size:size];
    CGFontRelease(fontRef);
    return font;
}

@end
