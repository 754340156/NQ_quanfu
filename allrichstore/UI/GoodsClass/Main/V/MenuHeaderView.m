//
//  MenuHeaderView.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MenuHeaderView.h"

#define kMargin_level   kCollectionCell_Margin
@implementation MenuHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
    [self addSubview:self.titleLabel];
    [self addSubview:self.btn];
}

//布局子视图
- (void)layoutViews
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(kMargin_level);
        make.right.offset(-kMargin_level);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(kMargin_level);
        make.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
}

#pragma mark - lazy
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        self.titleLabel = [UILabel new];
        _titleLabel.textColor = QF_BlackColor;
        _titleLabel.font = AdaptedFont(16);
    }
    return _titleLabel;
}

- (QButton *)btn
{
    if (!_btn)
    {
        self.btn = [[QButton alloc] initWithFrame:CGRectZero style:QButtonStyleImageRight layoutStyle:QButtonLayoutStyleRight font:nil title:nil image:Image(@"youjiantou") space:0 margin:kMargin autoSize:NO];
    }
    return _btn;
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model



@end
