//
//  MyOrderRefundApplyCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderRefundApplyCell.h"
#import "MyOrderRefundApplyModel.h"
#define kButtonSize CGSizeMake(Adapted(60), Adapted(25))
#define kLabelH 45.0f

#define kImageViewSize CGSizeMake(Adapted(130), Adapted(100))
@interface MyOrderRefundApplyCell ()
/**  订单编号 */
@property(nonatomic,strong) UILabel * orderNumLabel;
/**  下单时间 */
@property(nonatomic,strong) UILabel * orderTimeL;
/**  商品图片 */
@property(nonatomic,strong) UIImageView * goodImageV;
/**  商品数量 */
@property(nonatomic,strong) UILabel * numberLabel;
/**  申请售后 */
@property(nonatomic,strong) UIButton * applyButton;
@end

@implementation MyOrderRefundApplyCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.orderNumLabel = [[UILabel alloc] init];
    self.orderNumLabel.textColor = QF_BlackColor;
    self.orderNumLabel.font = Font_Max;
    [self.contentView addSubview:self.orderNumLabel];
    [self.orderNumLabel addTopLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self.orderNumLabel addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    
    self.orderTimeL = [[UILabel alloc] init];
    self.orderTimeL.textColor = QF_BlackColor;
    self.orderTimeL.font = Font_Max;
    [self.contentView addSubview:self.orderTimeL];
    [self.orderTimeL addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    
    self.goodImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.goodImageV];
    
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.font = Font_Min;
    self.numberLabel.textColor = QF_GrayColor;
    [self.numberLabel sizeToFit];
    [self.contentView addSubview:self.numberLabel];
    
    self.applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.applyButton.titleLabel.font = Font_Min;
    [self.applyButton setTitle:String(@"申请售后") forState:UIControlStateNormal];
    self.applyButton.layer.cornerRadius = 5.0f;
    self.applyButton.layer.masksToBounds = YES;
    self.applyButton.layer.borderColor = QF_GrayColor.CGColor;
    self.applyButton.layer.borderWidth = 0.5f;
    [self.applyButton addTarget:self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.applyButton setTitleColor:QF_GrayColor forState:UIControlStateNormal];
    [self.contentView addSubview:self.applyButton];

}
//布局子视图
- (void)layoutViews
{
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.orderTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.orderNumLabel.mas_bottom);
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.goodImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.top.equalTo(self.orderTimeL.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(kImageViewSize);
        make.bottom.offset(Adapted(-kMargin));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodImageV.mas_top);
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.goodImageV.mas_bottom);
        make.left.equalTo(self.titleLabel.mas_left);
    }];
    
    [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.goodImageV.mas_bottom);
        make.right.equalTo(self.titleLabel.mas_right);
        make.size.mas_offset(kButtonSize);
    }];
}

#pragma mark - custom method

#pragma mark - handle action
- (void)applyAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyOrderRefundApplyCellDelegate_clickApply)]) {
        [self.delegate MyOrderRefundApplyCellDelegate_clickApply];
    }
}
#pragma mark - setter model
- (void)setModel:(MyOrderRefundApplyModel *)model
{
    _model = model;
    self.orderNumLabel.text = [NSString stringWithFormat:@"%@：%@",String(@"  订单编号"),model.orderNumber];
    self.orderTimeL.text = [NSString stringWithFormat:@"%@：%@",String(@"  下单时间"),model.orderTime];
    self.titleLabel.text = model.title;
    self.goodImageV.image = ImageStr(model.goodImage);
    self.numberLabel.text = [NSString stringWithFormat:@"x%@",model.number];
}

@end
