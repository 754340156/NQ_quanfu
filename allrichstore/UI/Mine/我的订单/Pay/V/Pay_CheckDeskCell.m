//
//  Pay_CheckDeskCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Pay_CheckDeskCell.h"
#import "Pay_CheckDeskModel.h"
@interface Pay_CheckDeskCell ()
/**  icon */
@property(nonatomic,strong) UIImageView * iconImageV;
/**  选中的按钮 */
@property(nonatomic,strong) UIButton * selectedBtn;
@end


@implementation Pay_CheckDeskCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.iconImageV = [[UIImageView alloc] init];
    self.iconImageV.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.iconImageV];
    
    self.titleLabel.font = Font(14);
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectedBtn setImage:Image(@"xuanze_weixuan") forState:UIControlStateNormal];
    [self.selectedBtn setImage:Image(@"xuanze_yixuan") forState:UIControlStateSelected];
    [self.selectedBtn addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectedBtn];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.size.mas_offset(CGSizeMake(30, 30));
        make.centerY.offset(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_right).offset(kMargin);
        make.centerY.offset(0);
    }];
    
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
}

#pragma mark - custom method

#pragma mark - handle action
- (void)selectedAction:(UIButton *)sender
{
    if (self.clickSelectedBtnBlock) {
        self.clickSelectedBtnBlock();
    }
}
#pragma mark - setter model
- (void)setModel:(Pay_CheckDeskModel *)model
{
    _model = model;
    self.selectedBtn.selected = model.isSelected;
    self.iconImageV.image = Image(model.icon);
    self.titleLabel.text = model.title;
    
}
@end
