//
//  GD_ActiveCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GD_ActiveCell.h"
#import "GoodsDetailModel.h"
@interface GD_ActiveCell ()
/**  活动的标签 */
@property(nonatomic,strong) UILabel * topicLabel;
/**  右侧图标 */
@property(nonatomic,strong) UIButton * moreButton;
@end


@implementation GD_ActiveCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.topicLabel = [[UILabel alloc] init];
    [self.topicLabel sizeToFit];
    self.topicLabel.textColor = QF_BlackColor;
    self.topicLabel.font = Font_Mid;
    [self.contentView addSubview:self.topicLabel];
    
    self.titleLabel.textColor = QF_GrayColor;
    self.titleLabel.font = Font_Min;
    [self.contentView addSubview:self.titleLabel];
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreButton setImage:Image(@"gengduo") forState:UIControlStateNormal];
    [self.moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.moreButton];
    
    [self.contentView addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}
//布局子视图
- (void)layoutViews
{
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.offset(Adapted(10));
        make.height.offset(Adapted(20));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.topicLabel.mas_right).offset(Adapted(10));
        make.height.offset(Adapted(20));
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.offset(Adapted(-10));
        make.size.mas_offset(CGSizeMake(Adapted(30), Adapted(30)));
    }];
}

#pragma mark - custom method

#pragma mark - handle action
- (void)moreAction:(UIButton *)sender
{
    
}
#pragma mark - setter model
- (void)setModel:(GoodsDetailActiveModel *)model
{
    _model = model;
    self.topicLabel.text = @"活动";
    self.titleLabel.text = [NSString stringWithFormat:@"满%@减%@",model.c_costmin,model.c_costmax];
}

@end
