//
//  QButton.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/8.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, QButtonStyle)
{
    QButtonStyleNormal = 0,
    QButtonStyleImageRight,
    QButtonStyleImageTop,
    QButtonStyleImageBottom,
};

typedef NS_ENUM(NSInteger, QButtonLayoutStyle)
{
    QButtonLayoutStyleNone = 0,
    QButtonLayoutStyleLeft,
    QButtonLayoutStyleRight,
    QButtonLayoutStyleTop,
    QButtonLayoutStyleBottom,
};

typedef NS_ENUM(NSUInteger, QButtonState)
{
    QButtonNormalStateNormal       = 0,
    QButtonNormalStateSelected     = 1,
    QButtonSelectedStateNormal     = 2,
    QButtonSelectedStateSelected   = 3
};

@interface QButton : UIButton

/**
 QButton的自动布局

 @param frame 若autoSize为YES，frame.size的宽高为最大
 @param style 按钮的类型（根据图片和标题的位置区分）
 @param layoutStyle 按钮（图片和标题控件整体偏移）的方向
 @param font  按钮标题的字体
 @param title 按钮标题
 @param image 按钮的图标
 @param space 按钮中图片与标题之间的间距
 @param margin 按钮（图片和标题控件整体偏移）的距离
 @param autoSize 是否自动适配为最小的size
 @return self
 */
+ (instancetype)btnType:(UIButtonType)btnType
                  frame:(CGRect)frame
                  style:(QButtonStyle)style
            layoutStyle:(QButtonLayoutStyle)layoutStyle
                   font:(UIFont *)font
                  title:(NSString *)title
                  image:(UIImage *)image
                  space:(CGFloat)space
                 margin:(CGFloat)margin
               autoSize:(BOOL)autoSize;

- (instancetype)initWithFrame:(CGRect)frame
                        style:(QButtonStyle)style
                  layoutStyle:(QButtonLayoutStyle)layoutStyle
                         font:(UIFont *)font
                        title:(NSString *)title
                        image:(UIImage *)image
                        space:(CGFloat)space
                       margin:(CGFloat)margin
                     autoSize:(BOOL)autoSize;

- (instancetype)initWithFrame:(CGRect)frame
                        style:(QButtonStyle)style
                         font:(UIFont *)font
                        title:(NSString *)title
                        image:(UIImage *)image
                        space:(CGFloat)space
                     autoSize:(BOOL)autoSize;

- (instancetype)initWithFrame:(CGRect)frame
                  layoutStyle:(QButtonLayoutStyle)layoutStyle
                         font:(UIFont *)font
                        title:(NSString *)title
                     autoSize:(BOOL)autoSize;

@property (nonatomic ,assign) QButtonStyle style;
@property (nonatomic ,assign) QButtonLayoutStyle layoutStyle;
@property (nonatomic ,assign) CGFloat space;
@property (nonatomic ,assign) CGFloat margin;

@property (nonatomic ,assign) BOOL autoSize;
@property (nonatomic, assign) CGSize minSize;

//默认的背景色
@property (nonatomic, strong) UIColor *normalBgColor;
//选中的背景色
@property (nonatomic, strong) UIColor *selectedBgColor;

//默认的边框颜色
@property (nonatomic, strong) UIColor *normalBorderColor;
//选中的边框颜色
@property (nonatomic, strong) UIColor *selectedBorderColor;

@property (nonatomic, strong) UIColor *highlightColor;

@property (nonatomic, assign) BOOL transparentWhenhighlight;
@property (nonatomic, assign) BOOL qbSelected;

- (void)setImage:(UIImage *)image forQButtonState:(QButtonState)state;

@end
