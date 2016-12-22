//
//  SysytemMsgCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SysytemMsgCell.h"

//上下边距
#define kMargin_vertical        Adapted(12)
//左右边距
#define kMargin_level           Adapted(12)

//标题和内容的垂直间距
#define kSpace_title_content    Adapted(10)


//标题的字体
#define kFont_Title         AdaptedFont(15)
//内容的字体
#define kFont_Content       AdaptedFont(13)

@implementation SysytemMsgCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.bottomMargin = 0.0;
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    
    _titleLabel.font = kFont_Title;
    _contentLabel.font = kFont_Content;
}

//布局子视图
- (void)layoutViews
{
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(kMargin_level);
        make.top.offset(kMargin_vertical);
        make.bottom.offset(-kMargin_vertical);
        make.width.equalTo(_imgView.mas_height);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_imgView);
        make.left.equalTo(_imgView.mas_right).offset(kMargin_level);
        make.right.equalTo(_timeLabel.mas_left).offset(-kMargin_level);
        make.height.offset([_titleLabel getHeight]);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(kSpace_title_content);
        make.right.offset(-kMargin_level);
        make.height.offset([_contentLabel getHeight]);
        make.bottom.offset(-kMargin_vertical);
        
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-kMargin_level);
        make.centerY.equalTo(_titleLabel);
        make.width.offset(Adapted(80));
        make.height.offset([_timeLabel getHeight]);
        
    }];
}

//cell的高度
+ (CGFloat)cellHeight
{
    return kMargin_vertical * 2.0 + kSpace_title_content + [UILabel getHeightWithFont:kFont_Title] + [UILabel getHeightWithFont:kFont_Content];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imgView.layer.cornerRadius = _imgView.height / 2.0;
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model


@end
