//
//  CreateOrderSwitchCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CreateOrderSwitchCell.h"
#import "CreateOrderModel.h"
@interface CreateOrderSwitchCell ()
/**  开关 */
@property(nonatomic,strong) UISwitch * integralSwitch;
@end

@implementation CreateOrderSwitchCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.text = @"可用50积分抵5元";
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.integralSwitch = [[UISwitch alloc] init];
    [self.integralSwitch addTarget:self action:@selector(integralAction:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.integralSwitch];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.integralSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.integralSwitch.mas_left).offset(Adapted(-kMargin));
    }];
}

#pragma mark - custom method

#pragma mark - handle action
- (void)integralAction:(UISwitch *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CreateOrderSwitchCellDelegate_clickSwitchWithIsSelected:)]) {
        [self.delegate CreateOrderSwitchCellDelegate_clickSwitchWithIsSelected:sender.on];
    }
}
#pragma mark - setter model
- (void)setModel:(CreateOrderModel *)model
{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:String(@"可用%@积分抵%ld元"),model.integral,model.integral.integerValue / 10];
}

@end
