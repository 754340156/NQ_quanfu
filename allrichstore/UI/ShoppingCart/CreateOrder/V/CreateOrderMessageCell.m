//
//  CreateOrderMessageCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CreateOrderMessageCell.h"

@interface CreateOrderMessageCell ()
/**  textField */
@property(nonatomic,strong) UITextField * textField;
@end

@implementation CreateOrderMessageCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.text = String(@"买家留言：");
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = String(@"快递可发中通、申通、韵达、圆通");
    self.textField.font = Font_Mid;
    self.textField.textColor = QF_BlackColor;
    [self.contentView addSubview:self.textField];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.offset(Adapted(kMargin));
        make.width.offset(Adapted(80));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(Adapted(kMargin));
        make.centerY.equalTo(self.mas_centerY);
        make.right.offset(Adapted(-kMargin));
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model

@end
