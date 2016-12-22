

//
//  MyOrderListCell_Cell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderListCell_Cell.h"
#import "MyOrderListModel.h"

#define kImageVSize CGSizeMake(Adapted(130), Adapted(110))
@interface MyOrderListCell_Cell ()
/**  商品图 */
@property(nonatomic,strong) UIImageView * goodImageV;
/**  二级标题1 */
@property(nonatomic,strong) UILabel * subTitleL1;
/**  二级标题2 */
@property(nonatomic,strong) UILabel * subTitleL2;
/**  价格 */
@property(nonatomic,strong) UILabel * priceLabel;
/**  商品数量 */
@property(nonatomic,strong) UILabel * countLabel;
@end


@implementation MyOrderListCell_Cell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.goodImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.goodImageV];
    
    self.titleLabel.font = Font_Mid;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.subTitleL1 = [[UILabel alloc] init];
    self.subTitleL1.font = Font_Min;
    self.subTitleL1.textColor = QF_GrayColor;
    [self.subTitleL1 sizeToFit];
    [self.contentView addSubview:self.subTitleL1];
    
    self.subTitleL2 = [[UILabel alloc] init];
    self.subTitleL2.font = Font_Min;
    self.subTitleL2.textColor = QF_GrayColor;
    [self.subTitleL2 sizeToFit];
    [self.contentView addSubview:self.subTitleL2];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = Font_Mid;
    self.priceLabel.textColor = QF_RedColor;
    [self.priceLabel sizeToFit];
    [self.contentView addSubview:self.priceLabel];
    
    self.countLabel = [[UILabel alloc] init];
    self.countLabel.font = Font_Min;
    self.countLabel.textColor = QF_GrayColor;
    [self.countLabel sizeToFit];
    self.countLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.countLabel];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    
    [self.goodImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(kImageVSize);
        make.left.offset(Adapted(kMargin));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodImageV.mas_top);
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.subTitleL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Adapted(kMargin));
    }];
    
    [self.subTitleL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subTitleL1.mas_right).offset(Adapted(kMargin));
        make.top.equalTo(self.subTitleL1.mas_top);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.bottom.equalTo(self.goodImageV.mas_bottom);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(Adapted(-kMargin));
        make.bottom.equalTo(self.goodImageV.mas_bottom);
    }];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(MyOrderList_GoodsModel *)model
{
    _model = model;
    self.goodImageV.image = ImageStr(model.icon);
    self.titleLabel.text = model.title;
    self.subTitleL1.text = model.subTitle1;
    self.subTitleL2.text = model.subTitle2;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.countLabel.text = [NSString stringWithFormat:@"x%@",model.count];
}

@end
