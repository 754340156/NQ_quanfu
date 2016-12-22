//
//  FoldMenu_HeaderView.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "FoldMenu_HeaderView.h"

//底线的属性
#define kBottomLineView_Color   [UIColor colorWithWhite:0.92 alpha:1.0]
#define kBottomLineView_Height  1.0

@implementation FoldMenu_HeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addOwnViews]; //添加子控件
        [self layoutViews]; //布局子控件
    }
    return self;
}

#pragma mark - addOwnviews
//添加子控件
- (void)addOwnViews
{
    [self.contentView addSubview:self.menuBtn];
    [self.contentView addBottomLineWithColor:kBottomLineView_Color height:kBottomLineView_Height];
}

#pragma mark - layoutViews
//布局子控件
- (void)layoutViews
{
    _menuBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_menuBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_menuBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_menuBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_menuBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-kBottomLineView_Height]];
}

#pragma mark - lazy
- (QButton *)menuBtn
{
    if (!_menuBtn)
    {
        self.menuBtn = [[QButton alloc] initWithFrame:self.bounds style:QButtonStyleImageRight layoutStyle:QButtonLayoutStyleNone font:AdaptedFont(18) title:@"百货" image:Image(@"") space:Adapted(6) margin:0 autoSize:NO];
        [_menuBtn setImage:Image(@"foldBtnImg_Nor@2x") forState:UIControlStateNormal];
        [_menuBtn setImage:Image(@"foldBtnImg_Sel@2x")  forState:UIControlStateSelected];
        _menuBtn.layer.cornerRadius = 1.0;
    }
    return _menuBtn;
}

@end
