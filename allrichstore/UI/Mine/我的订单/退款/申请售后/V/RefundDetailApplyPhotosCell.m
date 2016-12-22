//
//  RefundDetailApplyPhotosCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/5.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RefundDetailApplyPhotosCell.h"

@interface RefundDetailApplyPhotosCell ()

@end

@implementation RefundDetailApplyPhotosCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = Image(@"shangchuan");
    [self.contentView addSubview:self.imageView];
}

//布局子视图
- (void)layoutViews
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

#pragma mark - custom method

#pragma mark - handle action
#pragma mark - setter model


@end
