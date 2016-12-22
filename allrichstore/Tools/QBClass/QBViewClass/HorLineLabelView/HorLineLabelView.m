//
//  HorLineLabelView.m
//  StarStory
//
//  Created by 任强宾 on 16/12/7.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "HorLineLabelView.h"    //———— label ————视图

@interface HorLineLabelView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation HorLineLabelView

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
                        space:(CGFloat)space
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //创建label
        UILabel *label = [UILabel new];
        label.text = text;
        label.font = font;
        label.textColor = textColor;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.textLabel = label;
        
        //创建左右边线
        UIView *leftLine = [UIView new];
        leftLine.backgroundColor = textColor;
        leftLine.alpha = 0.5;
        [self addSubview:leftLine];
        
        UIView *rightLine = [UIView new];
        rightLine.backgroundColor = textColor;
        rightLine.alpha = 0.5;
        [self addSubview:rightLine];
        
        //计算出label的宽度
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
        CGFloat labelWidth = size.width + 2 * space;
        
        //添加约束
        label.translatesAutoresizingMaskIntoConstraints = NO;
        leftLine.translatesAutoresizingMaskIntoConstraints = NO;
        rightLine.translatesAutoresizingMaskIntoConstraints = NO;
        
        //label的约束
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:labelWidth]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        //左边线的约束
        [self addConstraint:[NSLayoutConstraint constraintWithItem:leftLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:leftLine attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:leftLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:0.5]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:leftLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        //右边线的约束
        [self addConstraint:[NSLayoutConstraint constraintWithItem:rightLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:rightLine attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:rightLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:0.5]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:rightLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    }
    return self;
}

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
                        space:(CGFloat)space
{
    self = [super init];
    if (self)
    {
        //创建label
        UILabel *label = [UILabel new];
        label.text = text;
        label.font = font;
        label.textColor = textColor;
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.textLabel = label;
        
        //创建左右边线
        UIView *leftLine = [UIView new];
        leftLine.backgroundColor = textColor;
        leftLine.alpha = 0.5;
        [self addSubview:leftLine];
        
        UIView *rightLine = [UIView new];
        rightLine.backgroundColor = textColor;
        rightLine.alpha = 0.5;
        [self addSubview:rightLine];
        
        //计算出label的宽度
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
        CGFloat labelWidth = size.width + 2 * space;
        
        //添加约束
        label.translatesAutoresizingMaskIntoConstraints = NO;
        leftLine.translatesAutoresizingMaskIntoConstraints = NO;
        rightLine.translatesAutoresizingMaskIntoConstraints = NO;
        
        //label的约束
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:labelWidth]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        
        //左边线的约束
        [self addConstraint:[NSLayoutConstraint constraintWithItem:leftLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:leftLine attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:leftLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:0.5]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:leftLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        
        //右边线的约束
        [self addConstraint:[NSLayoutConstraint constraintWithItem:rightLine attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:rightLine attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:rightLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:0.5]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:rightLine attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:label attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    }
    return self;
}

//自适应高度
- (void)autoHeight
{
    CGRect rect = self.frame;
    rect.size.height = [self.textLabel getHeight];
    self.frame = rect;
}

@end
