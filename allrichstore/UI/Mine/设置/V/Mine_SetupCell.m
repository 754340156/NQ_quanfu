//
//  Mine_SetupCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Mine_SetupCell.h"
@interface Mine_SetupCell ()
/**  缓存大小 */
@property(nonatomic,strong) UILabel * cacheLabel;
/**  箭头图片 */
@property(nonatomic,strong) UIImageView * arrowImageV;
@end

@implementation Mine_SetupCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview: self.titleLabel];
    
    self.cacheLabel = [[UILabel alloc] init];
    [self.cacheLabel sizeToFit];
    self.cacheLabel.textColor = QF_GrayColor;
    self.cacheLabel.font = Font_Mid;
    [self.contentView addSubview:self.cacheLabel];
    
    self.arrowImageV = [[UIImageView alloc] init];
    self.arrowImageV.image = Image(@"youjiantou");
    self.arrowImageV.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.arrowImageV];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.cacheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.size.mas_offset(kArrowImageVSize);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    self.titleLabel.text = titleName;
}
- (void)setCacheSize:(NSString *)cacheSize
{
    _cacheSize = cacheSize;
    self.arrowImageV.hidden = YES;
    self.cacheLabel.text = cacheSize;
}

@end
