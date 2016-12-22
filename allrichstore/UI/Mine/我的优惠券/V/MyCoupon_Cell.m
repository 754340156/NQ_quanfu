//
//  MyCoupon_Cell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCoupon_Cell.h"
#import "MyCouponModel.h"
#define kImageViewH 65.0f
#define kRedImageW 120.0f
#define kPriceW 80.0f
@interface MyCoupon_Cell ()
/**  BackImage */
@property(nonatomic,strong) UIImageView * backImageV;
/**  价格 */
@property(nonatomic,strong) UILabel * priceLabel;
/**  满多少使用 */
@property(nonatomic,strong) UILabel* fullLabel;
/**  是否过期 */
@property(nonatomic,strong) UILabel * usedLabel;

@end


@implementation MyCoupon_Cell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
         //2488580
    self.backImageV = [[UIImageView alloc] init];
    self.backImageV.image = Image(@"youhuiquan-shangjia copy");
    [self.contentView addSubview:self.backImageV];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = AdaptedFont(20);
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.textColor = QF_RedColor;
    [self.contentView addSubview:self.priceLabel];
    
    self.fullLabel = [[UILabel alloc] init];
    self.fullLabel.font = Font_Min;
    self.fullLabel.textColor = QF_RedColor;
    self.fullLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.fullLabel];

    self.timeLabel.font = QFFont_GoodsSquareCell_Min;
    self.timeLabel.textColor = QF_RedColor;
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLabel];
    
    self.usedLabel = [[UILabel alloc] init];
    self.usedLabel.textColor = kWhiteColor;
    self.usedLabel.font = Font_Mid;
    [self.usedLabel sizeToFit];
    self.usedLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.usedLabel];
}

//布局子视图
- (void)layoutViews
{
    [self.backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
        make.top.offset(Adapted(kMargin * 3 / 4));
        make.height.offset(Adapted(kImageViewH));
        make.bottom.offset(Adapted(-kMargin * 3 / 4));
    }];
    
    [self.usedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backImageV.mas_centerY);
        make.right.equalTo(self.backImageV.mas_right);
        make.width.offset(Adapted(kRedImageW));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageV.mas_top).offset(Adapted(kMargin * 3 / 2));
        make.left.equalTo(self.backImageV.mas_left);
        make.width.offset(Adapted(kPriceW));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.usedLabel.mas_left).offset(Adapted(-kMargin * 3));
        make.bottom.equalTo(self.backImageV.mas_bottom).offset(- kMargin * 3 / 4);
    }];
    
    [self.fullLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLabel.mas_centerY);
        make.right.equalTo(self.timeLabel.mas_right);
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(MyCouponModel *)model
{
    _model = model;
    self.priceLabel.text = model.cCostmax;
    self.fullLabel.text  = [NSString stringWithFormat:String(@"订单满%@元使用"),model.cCostmin];
    self.timeLabel.text = [NSString stringWithFormat:String(@"使用期限：%@-%@"),[NSString dateStringWithSec:model.cBegintime.integerValue],[NSString dateStringWithSec:model.cEndtime.integerValue]];
}
- (void)setUsedState:(NSString *)usedState
{
    _usedState = usedState;
    self.usedLabel.text = usedState;
}
@end
