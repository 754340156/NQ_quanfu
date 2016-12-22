//
//  HobbyCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "HobbyCell.h"   //爱好标签cell

@implementation HobbyCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    //创建爱好标签按钮
    self.tagBtn = [QButton buttonWithType:UIButtonTypeCustom];
    _tagBtn.frame = self.bounds;
    _tagBtn.userInteractionEnabled = NO;
    _tagBtn.normalBgColor = QFColor_BaseVCViewBg;
    _tagBtn.selectedBgColor = QF_OrangeColor;
    [_tagBtn setTitleColor:kGrayColor_D forState:UIControlStateNormal];
    [_tagBtn setTitleColor:kWhiteColor forState:UIControlStateSelected];
    _tagBtn.titleLabel.font = AdaptedFont(14);
    _tagBtn.layer.masksToBounds = YES;
    _tagBtn.layer.cornerRadius = _tagBtn.height / 2.0;
    [self addSubview:_tagBtn];
}

//布局子视图
- (void)layoutViews
{
    
}

#pragma mark - setter model
- (void)setModel:(HobbySubModel *)model
{
    _model = model;
    [self.tagBtn setTitle:model.h_name forState:UIControlStateNormal];
    _tagBtn.selected = model.isSelected;
}

@end
