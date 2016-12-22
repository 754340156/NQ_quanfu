//
//  HorLineLabelView.h
//  StarStory
//
//  Created by 任强宾 on 16/12/7.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorLineLabelView : UIView

/**
 frame方式：初始化
 @param frame       frame
 @param text        label的内容
 @param textColor   label的文字颜色
 @param font        label的字体
 @param space       横线与文字之间的水平距离
 */
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                    textColor:(UIColor *)textColor
                         font:(UIFont *)font
                        space:(CGFloat)space;
/**
 init方式：初始化
 @param text        label的内容
 @param textColor   label的文字颜色
 @param font        label的字体
 @param space       横线与文字之间的水平距离
 */
- (instancetype)initWithText:(NSString *)text
                   textColor:(UIColor *)textColor
                        font:(UIFont *)font
                       space:(CGFloat)space;

- (void)autoHeight;

@end
