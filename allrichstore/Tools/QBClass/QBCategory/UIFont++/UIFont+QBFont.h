//
//  UIFont+QBFont.h
//  PRJ_CreditRecruit
//
//  Created by 任强宾 on 16/5/17.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (QBFont)

//系统字体
+ (UIFont *)qbSystemFontOfSize:(CGFloat)fontSize;

//自定义字体（通过沙盒路径取出字体）
+ (UIFont *)customFontWithName:(NSString *)name size:(CGFloat)size;

@end
