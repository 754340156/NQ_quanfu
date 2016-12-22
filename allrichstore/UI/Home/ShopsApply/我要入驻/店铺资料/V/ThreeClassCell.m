//
//  ThreeClassCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ThreeClassCell.h"
#import "ThreeClassModel.h"
@interface ThreeClassCell ()
/**  button */
@property(nonatomic,strong) UIButton * chooseButton;
@end

@implementation ThreeClassCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    
    self.titleLabel.font = Font(14);
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseButton setImage:Image(@"xuanze_weixuan") forState:UIControlStateNormal];
    [self.chooseButton setImage:Image(@"xuanze_yixuan") forState:UIControlStateSelected];
    [self.chooseButton addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.chooseButton];
    
}

//布局子视图
- (void)layoutViews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(kMargin * 2);
    }];
    [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
}

#pragma mark - custom method

#pragma mark - handle action
- (void)chooseAction:(UIButton *)sender
{
    sender.selected = YES;
    if (self.clickSelected) {
        self.clickSelected(sender.selected);
    }
}
#pragma mark - setter model
- (void)setModel:(ThreeClassModel *)model
{
    _model = model;
    self.chooseButton.selected = model.isSelected;
    self.titleLabel.text = model.title;
}

@end
