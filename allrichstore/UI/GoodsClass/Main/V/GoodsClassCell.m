//
//  GoodsClassCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/24.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsClassCell.h"  //分类菜单的cell
#import "GoodsClassVC.h"    //分类菜单VC

//水平边距
#define kMargin_level   3

//cell的宽度
#define kCell_Width     kCollectionCell_Width
//title的高度
#define kLabel_Height   Adapted(30)

//title距离底部的边距
#define kMargin_Label_Bottom   Adapted(8)

//图片宽高比
#define kImageSacle_W_H 1.0

//imageView的高度
#define kImage_Height   ((kCell_Width - 2 * kMargin_level) / kImageSacle_W_H)

@implementation GoodsClassCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.imgView];
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
        
        make.left.and.top.offset(kMargin_level);
        make.right.offset(-kMargin_level);
        make.height.offset(kImage_Height);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(kMargin_level);
        make.right.offset(-kMargin_level);
        make.top.equalTo(_imgView.mas_bottom).offset(0);
        make.bottom.offset(-kMargin_Label_Bottom);
        
    }];
}

//返回本类的行高
+ (CGFloat)cellHeight
{
    return kLabel_Height + kCollectionCell_Width + kMargin_Label_Bottom;
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(GoodsClassModel *)model
{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.cImgUrl] placeholderImage:Image_PlaceHolder_GoodsClass];
    _titleLabel.text = model.cName;
}

@end
