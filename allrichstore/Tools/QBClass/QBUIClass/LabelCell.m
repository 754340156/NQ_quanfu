//
//  LabelCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "LabelCell.h"

#define kFont_label AdaptedFont(17)

@implementation LabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createViews]; //创建子视图
        [self layoutViews]; //布局子视图
    }
    return self;
}

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.label];
}

//布局子视图
- (void)layoutViews
{
    //添加约束
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-0.7]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.label showEffectViewWithStyle:UIBlurEffectStyleExtraLight alpha:1.0];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model



#pragma mark - lazy
//label
- (UILabel *)label
{
    if (!_label)
    {
        self.label = [UILabel new];
        _label.backgroundColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = BaseColor_Cell_TitleLabel_Text;
        _label.font = kFont_label;
    }
    return _label;
}

@end
