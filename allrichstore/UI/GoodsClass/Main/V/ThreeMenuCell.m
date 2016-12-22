//
//  ThreeMenuCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ThreeMenuCell.h"
#import "GoodsClassVC.h"

//cell的宽度
#define kCell_Width     kCollectionCell_Width
//title的高度
#define kLabel_Height   Adapted(30)

//title距离底部的边距
#define kMargin_Label_Bottom   Adapted(8)

#define kImageSacle_W_H 1.0 //图片宽高比

//imageView的高度
#define kImage_Height   (kCell_Width / kImageSacle_W_H)

@implementation ThreeMenuCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.backgroundColor = kClearColor;
    
    [self addSubview:self.imgView];
    _imgView.backgroundColor = kWhiteColor;
    
    [self addSubview:self.titleLabel];
    _titleLabel.textColor = QF_BlackColor;
    _titleLabel.backgroundColor = kClearColor;
    _titleLabel.font = AdaptedFont(16);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
}

//布局子视图
- (void)layoutViews
{
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.and.top.offset(0);
        make.height.offset(kImage_Height);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.right.offset(0);
        make.top.equalTo(_imgView.mas_bottom).offset(0);
        make.bottom.offset(-kMargin_Label_Bottom);
        
    }];
}

//返回本类的行高
+ (CGFloat)cellHeight
{
    return kLabel_Height + kImage_Height + kMargin_Label_Bottom;
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model

@end
