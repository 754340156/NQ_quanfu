//
//  MyOrderDetailPriceCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderDetailPriceCell.h"
#import "MyOrderDetailModel.h"
@interface MyOrderDetailPriceCell ()
/**  subtitleLabel */
@property(nonatomic,strong)UILabel* subTitleLabel;
@end

@implementation MyOrderDetailPriceCell
#pragma mark - override super
//创建子视图
- (void)createViews
{
    [self.contentView addSubview: self.titleLabel];
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.font = Font_Mid;
    self.subTitleLabel.textAlignment = NSTextAlignmentRight;
    [self.subTitleLabel sizeToFit];
    [self.contentView addSubview:self.subTitleLabel];
}

//布局子视图
- (void)layoutViews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.offset(Adapted(kMargin));
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(Adapted(-kMargin));
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(MyOrderDetailPriceModel *)model
{
    _model = model;
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    if (model.isRed) self.subTitleLabel.textColor = QF_RedColor;
}
@end
