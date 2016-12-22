//
//  AddressCell.m
//  LiveTest
//
//  Created by 任强宾 on 16/8/25.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "AddressCell.h"

#define LeftMargin  Adapted(12)
#define RightMargin Adapted(12)
//#define ImgView_W_H 20.0

@implementation AddressCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.bottomMargin = 0;
    self.boottomLineColor = QFColor_LightGrayBg;
    [self.contentView addSubview:self.titleLabel];
    _titleLabel.font = Font(16);
}

//布局子视图
- (void)layoutViews
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(LeftMargin);
        make.right.offset(-RightMargin);
        make.top.offset(0);
        make.bottom.offset(0);
        
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model



@end
