//
//  Authentication_SuccessCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Authentication_SuccessCell.h"
#define kLabelH 25.0f
@interface Authentication_SuccessCell ()
/**  subTitle */
@property(nonatomic,strong) UILabel * subTitleL;
@end

@implementation Authentication_SuccessCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    [self.titleLabel sizeToFit];
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    [self.contentView addSubview:self.titleLabel];
    
    self.subTitleL = [[UILabel alloc] init];
    [self.subTitleL sizeToFit];
    self.subTitleL.font = Font_Mid;
    self.subTitleL.textColor = QF_BlackColor;
    [self.contentView addSubview:self.subTitleL];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.height.offset(kLabelH);
    }];
    
    [self.subTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.height.offset(kLabelH);
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}
- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    self.subTitleL.text = subTitle;
}
@end
