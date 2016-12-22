//
//  CreateOrderAmountCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CreateOrderAmountCell.h"
#import "CreateOrderModel.h"

#define kLabelH 20.0f
@interface CreateOrderAmountCell ()
/**  商品金额 */
@property(nonatomic,strong) UILabel * amountLabel;
/**  运费 */
@property(nonatomic,strong) UILabel * freightLabel;
/**  优惠 */
@property(nonatomic,strong) UILabel * couponLabel;
@end

@implementation CreateOrderAmountCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.amountLabel = [[UILabel alloc] init];
    [self setLabelWithLabel:self.amountLabel];
    [self.contentView addSubview:self.amountLabel];
    
    self.freightLabel = [[UILabel alloc] init];
    [self setLabelWithLabel:self.freightLabel];
    [self.contentView addSubview:self.freightLabel];
    
    self.couponLabel = [[UILabel alloc] init];
    [self setLabelWithLabel:self.couponLabel];
    [self.contentView addSubview:self.couponLabel];
}

//布局子视图
- (void)layoutViews
{
    UILabel * amountTitleL = [[UILabel alloc] init];
    amountTitleL.text = String(@"商品金额");
    [self setLabelWithLabel:amountTitleL];
    [self.contentView addSubview:amountTitleL];
    [amountTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(Adapted(kMargin));
        make.left.offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));

    }];
    
    UILabel * freightTitleL = [[UILabel alloc] init];
    freightTitleL.text = String(@"运费");
    [self setLabelWithLabel:freightTitleL];
    [self.contentView addSubview:freightTitleL];
    [freightTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(amountTitleL.mas_bottom).offset(Adapted(kMargin / 2));
        make.left.offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    UILabel * couponTitleL = [[UILabel alloc] init];
    couponTitleL.text = String(@"优惠");
    [self setLabelWithLabel:couponTitleL];
    [self.contentView addSubview:couponTitleL];
    [couponTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(freightTitleL.mas_bottom).offset(Adapted(kMargin / 2));
        make.left.offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(Adapted(-kMargin));
        make.top.offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(Adapted(-kMargin));
        make.top.equalTo(self.amountLabel.mas_bottom).offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(Adapted(-kMargin));
        make.top.equalTo(self.freightLabel.mas_bottom).offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
}

#pragma mark - custom method
- (void)setLabelWithLabel:(UILabel *)label
{
    label.textColor = QF_BlackColor;
    label.font = Font_Mid;
    [label sizeToFit];
}
#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(CreateOrderGoodsPrices *)model
{
    _model = model;
    self.amountLabel.text = [NSString stringWithFormat:@"¥%@",model.goodPrice];
    self.freightLabel.text = [NSString stringWithFormat:@"¥%@",model.freight];
    self.couponLabel.text = [NSString stringWithFormat:@"¥%@",model.preference];
}
@end
