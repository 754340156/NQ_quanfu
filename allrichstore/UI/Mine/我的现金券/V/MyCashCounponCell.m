//
//  MyCashCounponCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/7.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCashCounponCell.h"
#import "MyCashCounponModel.h"
@interface MyCashCounponCell ()
/**   */
@property(nonatomic,strong)  UILabel* integralLabel;
@end

@implementation MyCashCounponCell

#pragma mark - override super
//创建子视图 55
- (void)createViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    self.titleLabel.font = Font_Mid;
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel sizeToFit];
    self.timeLabel.textColor = QF_GrayColor;
    self.timeLabel.font = Font_Min;
    
    self.integralLabel = [[UILabel alloc] init];
    self.integralLabel.textColor = QF_BlackColor;
    self.integralLabel.font = Font_Mid;
    [self.integralLabel sizeToFit];
    [self.contentView addSubview:self.integralLabel];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(kMargin);
        make.height.offset(20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.bottom.offset(-kMargin);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
    [self.integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(MyCashCounponModel *)model
{
    _model = model;
    self.titleLabel.text = model.o_goodname;
    self.timeLabel.text = [NSString dateStringWithSec:model.cpr_ceatetime.integerValue];
    self.integralLabel.text = [NSString stringWithFormat:@"%@%@",model.isIncome ? @"+":@"-",model.cpr_cash];
}


@end
