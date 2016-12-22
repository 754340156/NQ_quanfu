//
//  SecondCommentCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SecondCommentCell.h"
#import "SecondCommentModel.h"

@interface SecondCommentCell ()
/**  icon */
@property(nonatomic,strong) UIImageView * iconImageV;
/**  content */
@property(nonatomic,strong) UILabel * contentL;
/**  回复 */
@property(nonatomic,strong) UIButton * replyButton;
@end

@implementation SecondCommentCell
#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.iconImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageV];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    [self.contentView addSubview:self.titleLabel];
    
    [self.timeLabel sizeToFit];
    self.timeLabel.font = Font_Min;
    self.timeLabel.textColor = QF_GrayColor;
    [self.contentView addSubview:self.timeLabel];
    
    self.contentL = [[UILabel alloc] init];
    self.contentL.font = Font_Mid;
    self.contentL.textColor = QF_BlackColor;
    self.contentL.numberOfLines = 0;
    [self.contentView addSubview:self.contentL];
    
    self.replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.replyButton setTitleColor:QF_GrayColor forState:UIControlStateNormal];
    [self.replyButton addTarget:self action:@selector(replyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.replyButton setTitle:@"回复" forState:UIControlStateNormal];
    self.replyButton.layer.borderColor = QF_GrayColor.CGColor;
    self.replyButton.layer.masksToBounds = YES;
    self.replyButton.layer.borderWidth = 0.5;
    self.replyButton.layer.cornerRadius = Adapted(5);
    self.replyButton.titleLabel.font = Font_Mid;
    [self.contentView addSubview:self.replyButton];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(GD_EvaluativeIconH), Adapted(GD_EvaluativeIconH)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageV.mas_centerY);
        make.left.equalTo(self.iconImageV.mas_right).offset(Adapted(kMargin));
    }];
    
    [self.contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_left);
        make.top.equalTo(self.iconImageV.mas_bottom).offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_left);
        make.top.equalTo(self.contentL.mas_bottom).offset(Adapted(kMargin));
        make.bottom.offset(Adapted(-kMargin));
    }];
    
    [self.replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(Adapted(-kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(60), Adapted(25)));
    }];
}

#pragma mark - custom method

#pragma mark - handle action
- (void)replyAction
{
    
}
#pragma mark - setter model
- (void)setModel:(SecondCommentModel *)model
{
    _model = model;
    self.iconImageV.image = ImageStr(model.icon);
    self.titleLabel.text = model.title;
    self.timeLabel.text = model.time;
    self.contentL.text = model.content;
}
@end
