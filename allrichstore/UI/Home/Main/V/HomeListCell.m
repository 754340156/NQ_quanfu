//
//  HomeListCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/31.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "HomeListCell.h"

#define kImage_Title_Space 6.0
#define kTitle_Content_Space 1.0

#define kMargin_Top     Adapted(12)   //上间距
#define kMargin_Bottom  Adapted(8)   //下间距

#define kSpace_Label_ImgView   Adapted(8)   //图片和文字的垂直距离


#define kLabelFont      AdaptedFont(16) //label字体
#define kLabelHeight    [UILabel getHeightWithFont:kLabelFont]  //label高度

#define kImgView_W_H    (self.height - kLabelHeight - kMargin_Bottom - kMargin_Top - kSpace_Label_ImgView)

@implementation HomeListCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.backgroundColor = kWhiteColor;
    [self addSubview:self.imgView];
    
    [self addSubview:self.titleLabel];
    _titleLabel.font = kLabelFont;
    _titleLabel.textColor = QF_BlackColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleOutside];
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H];
}

//布局子视图
- (void)layoutViews
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(kMargin_Top);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(kLabelHeight);
        
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).offset(kSpace_Label_ImgView);
        make.centerX.offset(0);
        make.size.offset(kImgView_W_H);
        
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(ActivitySubModel *)model
{
    _model = model;
    _titleLabel.text = model.c_name;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.c_img_url] placeholderImage:Image_PlaceHolder_Cell_1 options:SDWebImageRetryFailed];
}

@end
