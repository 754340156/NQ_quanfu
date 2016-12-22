//
//  Mine_IconLogoutCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/7.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Mine_IconCell.h"
#import "UserModel.h"
#define kIconSize 44.0f
@interface Mine_IconCell ()
/**   */
@property(nonatomic,strong) UIImageView * iconImageV;
/**  星级图标 */
@property(nonatomic,strong) UIImageView * starImageV;
/**  箭头 */
@property(nonatomic,strong) UIImageView * arrowImageV;
@end


@implementation Mine_IconCell
#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.iconImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageV];
    
    self.titleLabel.font = Font_Mid;
    self.titleLabel.text = String(@"登录/注册");
    [self.titleLabel sizeToFit];
    [self.contentView addSubview: self.titleLabel];
    
    self.starImageV = [[UIImageView alloc] init];
    self.starImageV.image = Image(@"zuanshi");
    self.starImageV.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.starImageV];
    
    self.arrowImageV = [[UIImageView alloc] init];
    self.arrowImageV.contentMode = UIViewContentModeCenter;
    self.arrowImageV.image = Image(@"youjiantou");
    [self.contentView addSubview:self.arrowImageV];
    
    [self addTopLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    
}

//布局子视图
- (void)layoutViews
{
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(kIconSize, kIconSize));
        make.left.offset(kMargin);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.iconImageV.mas_right).offset(kMargin);
    }];
    
    [self.starImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(kMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.offset(-kMargin);
        make.size.mas_offset(kArrowImageVSize);
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(UserModel *)model
{
    _model = model;
    if ([Single isLogin]) {
        //登录
        [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:model.uHeadimage] placeholderImage:Image(@"weidenglutouxiang")];
#warning 预留昵称
        self.titleLabel.text = [model.uNickname isEqualToString:@""] ? @"全富用户": model.uNickname;
        self.arrowImageV.hidden = NO;
        self.starImageV.hidden = NO;
    }else
    {
        //未登录
        self.arrowImageV.hidden = YES;
        self.iconImageV.image = Image(@"weidenglutouxiang");
        self.starImageV.hidden = YES;
        self.titleLabel.text = String(@"登录/注册");
    }
}
@end
