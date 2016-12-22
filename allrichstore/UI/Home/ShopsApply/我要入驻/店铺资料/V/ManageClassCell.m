//
//  ManageClassCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ManageClassCell.h"
#import "ManageClassModel.h"
@interface ManageClassCell ()
/**  序号 */
@property(nonatomic,strong) UILabel * numberLabel;
/**  一级分类 */
@property(nonatomic,strong) UILabel * firstClassL;
/**  二级分类 */
@property(nonatomic,strong) UILabel * secondClassL;
/**  三级分类 */
@property(nonatomic,strong) UILabel * threeClassL;
/**  操作 */
@property(nonatomic,strong) UIButton * deleteBtn;
@end

@implementation ManageClassCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    
    self.numberLabel = [[UILabel alloc] init];
    [self setLabelWithLabel:self.numberLabel];
    [self.contentView addSubview:self.numberLabel];
    
    self.firstClassL = [[UILabel alloc] init];
    [self setLabelWithLabel:self.firstClassL];
    [self.contentView addSubview:self.firstClassL];
    
    self.secondClassL = [[UILabel alloc] init];
    [self setLabelWithLabel:self.secondClassL];
    [self.contentView addSubview:self.secondClassL];
    
    self.threeClassL = [[UILabel alloc] init];
    [self setLabelWithLabel:self.threeClassL];
    [self.contentView addSubview:self.threeClassL];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.titleLabel.font = Font(14);
    [self.deleteBtn setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.deleteBtn];
}

//布局子视图
- (void)layoutViews
{
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.offset(Adapted(45));
    }];
    
    [self.firstClassL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLabel.mas_right);
        make.top.bottom.offset(0);
        make.width.offset(Adapted(75));
    }];
    
    [self.secondClassL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstClassL.mas_right);
        make.top.bottom.offset(0);
        make.width.offset(Adapted(75));
    }];
    
    [self.threeClassL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondClassL.mas_right);
        make.top.bottom.offset(0);
        make.width.offset(Adapted(135));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.threeClassL.mas_right);
        make.top.bottom.offset(0);
        make.right.offset(0);
    }];
}

#pragma mark - custom method
- (void)setLabelWithLabel:(UILabel *)label
{
    label.textColor = QF_BlackColor;
    label.font = Font(14);
    label.textAlignment = NSTextAlignmentCenter;
    [label addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
}
#pragma mark - handle action
- (void)deleteAction:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ManageClassCellDelegate_clickDeleteWithCell:)]) {
        [self.delegate ManageClassCellDelegate_clickDeleteWithCell:self];
    }
}
#pragma mark - setter model
- (void)setModel:(ManageClassModel *)model
{
    _model = model;
    self.numberLabel.text = model.index;
    self.firstClassL.text = model.firstClass;
    self.secondClassL.text = model.secondClass;
    self.threeClassL.text = model.threeClass;
    [self.deleteBtn setTitle:model.isTitle ? @"操作":@"删除" forState:UIControlStateNormal];
}

@end
