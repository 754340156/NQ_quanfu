//
//  InvoiceInfoCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "InvoiceInfoCell.h"     //发票信息cell

#define kMargin_level   Adapted(10)

@implementation InvoiceInfoCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.titleLabel];
    _titleLabel.font = AdaptedFont(16);
    [_titleLabel addRightLine];
    [self.contentView addSubview:self.rightTF];
}

//布局子视图
- (void)layoutViews
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(kMargin_level);
        make.height.offset(Adapted(18));
        make.centerY.offset(0);
        make.width.offset([_titleLabel getWidthWithText:@"纳税人识别码"] + Adapted(20));
    }];
    
    [_rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-kMargin_level);
        make.left.equalTo(_titleLabel.mas_right).offset(Adapted(16));
        make.top.offset(0);
        make.bottom.offset(0);
    }];
}

- (UITextField *)rightTF
{
    if (!_rightTF)
    {
        self.rightTF = [UITextField new];
        _rightTF.textColor = kDarkGrayColor;
        _rightTF.font = AdaptedFont(16);
    }
    return _rightTF;
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model


@end
