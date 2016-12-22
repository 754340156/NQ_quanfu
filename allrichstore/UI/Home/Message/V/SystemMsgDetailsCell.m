//
//  SystemMsgDetailsCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SystemMsgDetailsCell.h"

@implementation SystemMsgDetailsCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];

    _titleLabel.font = Font_SizeOf(16.0);
    _timeLabel.font = Font_SizeOf(13.0);
}

//布局子视图
- (void)layoutViews
{
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.top.offset(10.0);
        make.height.offset(40.0);
        make.width.equalTo(_imgView.mas_height);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_imgView.mas_right).offset(12.0);
        make.height.offset(18);
        make.centerY.equalTo(_imgView.mas_centerY);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_imgView.mas_centerY).offset(0);
        make.right.offset(-10);
        make.width.offset(200);
        make.height.offset(16);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_imgView.mas_left);
        make.top.equalTo(_imgView.mas_bottom).offset(10);
        make.right.offset(-10);
        make.bottom.offset(-10);
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model


@end
