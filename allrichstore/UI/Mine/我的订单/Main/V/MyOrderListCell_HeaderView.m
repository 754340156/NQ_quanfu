//
//  MyOrderListCell_HeaderView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderListCell_HeaderView.h"

#define kImageVH 40.0f
#import "MyOrderListModel.h"
@interface MyOrderListCell_HeaderView ()
/**  头像 */
@property(nonatomic,strong) UIImageView * iconImageV;
/**  店铺名 */
@property(nonatomic,strong) UILabel * nickNameL;
/**  商品状态 */
@property(nonatomic,strong) UILabel * goodStatusL;
@end

@implementation MyOrderListCell_HeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
       self.contentView.backgroundColor = kWhiteColor;
        [self setup];
        [self setLayout];
    }
    return self;
}

#pragma mark - setup
- (void)setup
{
    self.iconImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageV];
    
    self.nickNameL = [[UILabel alloc] init];
    [self.nickNameL sizeToFit];
    self.nickNameL.font = Font_Mid;
    self.nickNameL.textColor = QF_BlackColor;
    [self.contentView addSubview:self.nickNameL];
    
    self.goodStatusL = [[UILabel alloc] init];
    [self.goodStatusL sizeToFit];
    self.goodStatusL.textAlignment = NSTextAlignmentRight;
    self.goodStatusL.font = Font_Min;
    self.goodStatusL.textColor = QF_GrayColor;
    [self.contentView addSubview:self.goodStatusL];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}
- (void)setLayout
{
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(kImageVH), Adapted(kImageVH)));
    }];
    
    [self.nickNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_right).offset(Adapted(kMargin));
        make.centerY.equalTo(self.iconImageV.mas_centerY);
    }];
    
    [self.goodStatusL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageV.mas_centerY);
        make.right.offset(Adapted(-kMargin));
    }];
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(MyOrderListModel *)model
{
    _model = model;
    self.iconImageV.image = ImageStr(model.shopIcon);
    self.nickNameL.text = model.shopName;
    self.goodStatusL.text = model.goodsStatus;
}

@end
