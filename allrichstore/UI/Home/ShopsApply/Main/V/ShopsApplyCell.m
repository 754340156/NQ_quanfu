//
//  ShopsApplyCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopsApplyCell.h"
 
#define kImageVH 60.0f
@interface ShopsApplyCell ()
/**  iconimageV */
@property(nonatomic,strong) UIImageView * iconImageV;

@end

@implementation ShopsApplyCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.iconImageV  = [[UIImageView alloc] init];
    self.iconImageV.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.iconImageV];
    
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    [self addTopLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.offset(Adapted(kMargin * 2));
        make.size.mas_offset(CGSizeMake(Adapted(kImageVH), Adapted(kImageVH)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.offset(Adapted(-kMargin));
        make.width.offset(self.width);
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    self.iconImageV.image = Image(icon);
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}
@end
