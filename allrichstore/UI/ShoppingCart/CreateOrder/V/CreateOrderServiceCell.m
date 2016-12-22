//
//  CreateOrderServiceCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CreateOrderServiceCell.h"
#import "CreateOrderModel.h"
#define kIconSize 30.0f
@interface CreateOrderServiceCell ()
/**  箭头的ImageView */
@property(nonatomic,strong) UIImageView * arrowImageV;
/**  副标题 */
@property(nonatomic,strong) UILabel * attestationLabel;
@end

@implementation CreateOrderServiceCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview: self.titleLabel];
    
    self.attestationLabel = [[UILabel alloc] init];
    self.attestationLabel.font = Font_Min;
    self.attestationLabel.textColor = QF_GrayColor;
    [self.attestationLabel sizeToFit];
    [self.contentView addSubview:self.attestationLabel];
    
    self.arrowImageV = [[UIImageView alloc] init];
    self.arrowImageV.contentMode = UIViewContentModeCenter;
    self.arrowImageV.image = Image(@"youjiantou");
    [self.contentView addSubview:self.arrowImageV];
    
    [self addTopLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.offset(-kMargin);
        make.size.mas_offset(kArrowImageVSize);
    }];
    
    [self.attestationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageV.mas_left).offset(Adapted(-kMargin));
        make.centerY.equalTo(self.mas_centerY);
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(CreateOrderServiceModel *)model
{
    _model = model;
    self.titleLabel.text = model.title;
    if (model.serviceArray.count) {
        self.attestationLabel.hidden = NO;
        self.attestationLabel.text = model.serviceArray[0];
    }
}

@end
