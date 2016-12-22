//
//  SendCommentShopCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SendCommentShopCell.h"
#import "SendCommentStarView.h"
#import "SendCommentModel.h"
@interface SendCommentShopCell ()
/**  星星1 */
@property(nonatomic,strong) SendCommentStarView * starView1;
/**  星星2 */
@property(nonatomic,strong) SendCommentStarView * starView2;
@end

@implementation SendCommentShopCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.starView1 = [SendCommentStarView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        if (self.clickStarBlock1) {
            self.clickStarBlock1(count);
        }
    }];
    self.starView1.spacing = 0.2;
    [self.contentView addSubview:self.starView1];
    
    self.starView2 = [SendCommentStarView evaluationViewWithChooseStarBlock:^(NSUInteger count) {
        if (self.clickStarBlock2) {
            self.clickStarBlock2(count);
        }
    }];
    self.starView2.spacing = 0.2;
    [self.contentView addSubview:self.starView2];
}

//布局子视图
- (void)layoutViews
{
    UILabel * titleLabel1 = [[UILabel alloc] init];
    titleLabel1.font = Font_Mid;
    titleLabel1.textColor = QF_BlackColor;
    titleLabel1.text = String(@"客服态度");
    [titleLabel1 sizeToFit];
    [self.contentView addSubview:titleLabel1];
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.top.offset(Adapted(kMargin));
        make.height.offset(Adapted(kStarViewH));
    }];
    
    UILabel * titleLabel2 = [[UILabel alloc] init];
    titleLabel2.font = Font_Mid;
    titleLabel2.textColor = QF_BlackColor;
    titleLabel2.text = String(@"物流速度");
    [titleLabel2 sizeToFit];
    [self.contentView addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.top.equalTo(titleLabel1.mas_bottom).offset(Adapted(kMargin));
        make.height.offset(Adapted(kStarViewH));
    }];
    
    [self.starView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.equalTo(titleLabel1.mas_right).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(130), Adapted(kStarViewH + 2* kMargin)));
    }];
    
    [self.starView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.starView1.mas_bottom).offset(Adapted(-kMargin));
        make.left.equalTo(titleLabel1.mas_right).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(130), Adapted(kStarViewH + 2* kMargin)));
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(SendCommentModel *)model
{
    _model = model;
}
@end
