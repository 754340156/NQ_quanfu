//
//  Mine_SubfieldCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/7.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Mine_SubfieldCell.h"
#define kblackLineH 30.0f
@interface Mine_SubfieldCell ()
/**  <#注释#> */
@property(nonatomic,strong) NSArray * listArray;
@end

@implementation Mine_SubfieldCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    CGFloat width = (kScreenW  - (self.listArray.count - 1) * ListCell_Line_W_H) / self.listArray.count;
    for (NSInteger i = 0; i < self.listArray.count; i++) {
        
        if (i) {
            UIView *backLine = [[UIView alloc] initWithFrame:CGRectMake(width * i + ListCell_Line_W_H * (i - 1) ,10 , ListCell_Line_W_H, kblackLineH)];
            backLine.backgroundColor = Home_ListCell_Line_Color;
            [self.contentView addSubview:backLine];
        }
        
        UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectedBtn setTitle:self.listArray[i] forState:UIControlStateNormal];
        [selectedBtn setTitleColor:QF_BlackColor forState:UIControlStateNormal];
        selectedBtn.titleLabel.font = Font_Mid;
        selectedBtn.frame = CGRectMake((width + ListCell_Line_W_H) * i, 0, width, 50);
        [selectedBtn addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:selectedBtn];
        

    }
    [self addTopLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    
}

#pragma mark - custom method

#pragma mark - handle action
- (void)selectedButtonAction:(UIButton *)sender
{
    __block NSInteger index = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(Mine_SubfieldCellDelegate_clickButtonWithIndex:Button:)]) {
        [self.listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([(NSString *)obj isEqualToString:sender.titleLabel.text]) {
                index = idx;
            }
        }];
        [self.delegate Mine_SubfieldCellDelegate_clickButtonWithIndex:index Button:sender];
    }
}
#pragma mark - setter model
- (NSArray *)listArray
{
    if (!_listArray) {
        _listArray = @[String(@"待付款") ,String(@"待发货"),String(@"待收货"),String(@"待评价"),String(@"退款售后")];
    }
    return _listArray;
}

@end
