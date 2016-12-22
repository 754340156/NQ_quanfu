//
//  SearchMatchCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SearchMatchCell.h"

@implementation SearchMatchCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    [self.contentView addSubview:self.titleLabel];
    _titleLabel.textColor = kGrayColor_D;
    _titleLabel.font = Font(16);
    self.bottomLeftMargin = Adapted(12);
}

//布局子视图
- (void)layoutViews
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(Adapted(12));
        make.right.offset(-Adapted(12));
        make.top.offset(0);
        make.bottom.offset(0);
        
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model

@end
