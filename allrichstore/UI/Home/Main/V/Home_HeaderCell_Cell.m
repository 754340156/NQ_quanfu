//
//  Home_HeaderCell_Cell.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/31.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "Home_HeaderCell_Cell.h"
#define ImageViewBackGroundColor [UIColor colorWithWhite:0.9 alpha:1.0]

#define LabelFont   [UIFont systemFontOfSize:14]
#define LabelTextColor [UIColor colorWithWhite:0.5 alpha:1.0]

#define kImageTopOffSet  -Adapted(12)   //上边距
#define kVerSpace         Adapted(8)   //图片和文字的垂直距离

#define kLabelFont      AdaptedFont(13) //label字体
#define kLabelHeight    [UILabel getHeightWithFont:kLabelFont]  //label高度

#define kLabelBottom    Adapted(8)

#define kImgView_W_H    (self.height - kLabelHeight - kLabelBottom - kVerSpace - Adapted(12))

//默认：按钮是关闭用户交互

@implementation Home_HeaderCell_Cell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.isHaveHighlightColor = YES;
    
    [self.contentView addSubview:self.imgView];
    
    [self.contentView addSubview:self.titleLabel];
    _titleLabel.font = kLabelFont;
    _titleLabel.textColor = QF_BlackColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addRightLineWithColor:Home_ListCell_Line_Color width:1.0];
}

//布局视图
- (void)layoutViews
{
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.offset(kLabelHeight);
        make.width.offset(self.width);
        make.bottom.offset(-kLabelBottom);
        make.centerX.offset(0);
        
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.offset(0);
        make.bottom.equalTo(_titleLabel.mas_top).offset(-kVerSpace);
        make.size.offset(kImgView_W_H);
        
    }];
    
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model


@end
