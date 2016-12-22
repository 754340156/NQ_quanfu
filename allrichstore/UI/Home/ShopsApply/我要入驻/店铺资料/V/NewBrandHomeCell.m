//
//  NewBrandHomeCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "NewBrandHomeCell.h"
#import "NewBrandHomeModel.h"
@interface NewBrandHomeCell ()
/**  品牌名称 */
@property(nonatomic,strong) UILabel * nameLabel;
/**  品牌logo */
@property(nonatomic,strong) UIButton * logo;
/**  商标注册人 */
@property(nonatomic,strong) UILabel * personLabel;
/**  申请品牌按钮 */
@property(nonatomic,strong) UIButton * applyBrandBtn;
@end

@implementation NewBrandHomeCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = QF_BlackColor;
    self.nameLabel.font = Font_Mid;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    
    self.logo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logo.enabled = NO;
    self.logo.contentMode = UIViewContentModeCenter;
    self.logo.titleLabel.font = Font_Mid;
    [self.logo setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self.contentView addSubview:self.logo];
    [self.logo addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    
    self.personLabel = [[UILabel alloc] init];
    self.personLabel.textColor = QF_BlackColor;
    self.personLabel.font = Font_Mid;
    self.personLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.personLabel];
    [self.personLabel addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    
    self.applyBrandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applyBrandBtn.titleLabel.font = Font_Mid;
    [self.applyBrandBtn addTarget:self action:@selector(applyBrandAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.applyBrandBtn];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.offset(Adapted(80));
    }];
    
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.top.bottom.offset(0);
        make.width.offset(Adapted(90));
    }];
    
    [self.applyBrandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.width.offset(Adapted(70));
    }];
    
    [self.personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.offset(0);
        make.left.equalTo(self.logo.mas_right);
        make.right.equalTo(self.applyBrandBtn.mas_left);
    }];
}

#pragma mark - custom method

#pragma mark - handle action
- (void)applyBrandAction
{
    
}
#pragma mark - setter model
- (void)setModel:(NewBrandHomeModel *)model
{
    _model = model;
    self.nameLabel.text = model.name;
    model.isTitle ? [self.logo setTitle:@"品牌logo" forState:UIControlStateNormal]:[self.logo setImage:Image(model.logoImage) forState:UIControlStateNormal];
    self.personLabel.text = model.person;
    [self.applyBrandBtn setTitle:model.isTitle ? @"操作":@"申请品牌" forState:UIControlStateNormal];
    [self.applyBrandBtn setTitleColor:model.isTitle ? QF_BlackColor:QF_RedColor forState:UIControlStateNormal];
}
@end
