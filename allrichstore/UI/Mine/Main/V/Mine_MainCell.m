//
//  Mine_MainCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/7.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Mine_MainCell.h"
#define kIconSize 30.0f
@interface Mine_MainCell ()
/**   */
@property(nonatomic,strong) UIImageView * iconImageV;

/**  箭头的ImageView */
@property(nonatomic,strong) UIImageView * arrowImageV;
/**  立即认证 */
@property(nonatomic,strong) UILabel * attestationLabel;
@end

@implementation Mine_MainCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.iconImageV = [[UIImageView alloc] init];
    self.iconImageV.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.iconImageV];
    
    self.titleLabel.font = Font_Mid;
    [self.titleLabel sizeToFit];
    self.titleLabel.textColor = QF_BlackColor;
    [self.contentView addSubview: self.titleLabel];
    
    self.attestationLabel = [[UILabel alloc] init];
    self.attestationLabel.font = Font_Min;
    self.attestationLabel.textColor = QF_GrayColor;
    [self.attestationLabel sizeToFit];
    self.attestationLabel.hidden = YES;
    [self.contentView addSubview:self.attestationLabel];
    
    
    self.arrowImageV = [[UIImageView alloc] init];
    self.arrowImageV.image = Image(@"youjiantou");
    self.arrowImageV.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.arrowImageV];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(kIconSize, kIconSize));
        make.centerY.equalTo(self.mas_centerY);
        make.left.offset(kMargin);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_right).offset(kMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.attestationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageV.mas_left).offset(-kMargin);
        make.centerY.equalTo(self.mas_centerY);
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
- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    self.iconImageV.image = Image(icon);
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}- (void)setAttestation:(NSString *)attestation
{
    _attestation = attestation;
    if (attestation) {
        self.attestationLabel.hidden = NO;
        self.attestationLabel.text = attestation;
    }
}
@end
