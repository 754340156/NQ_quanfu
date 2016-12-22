//
//  GoodsHaveBtnStyleTableCell.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/4.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GoodsModel.h"  //商品model

@interface GoodsHaveBtnStyleTableCell : BaseTableViewCell

//价格
@property (nonatomic, strong) UILabel *priceLabel;
//评价个数
@property (nonatomic, strong) UILabel *evaluatNumLabel;
//好评率
@property (nonatomic, strong) UILabel *praiseRateLabel;
//加入购物车的按钮
@property (nonatomic, strong) UIButton *addToCartBtn;
//商品的model
@property (nonatomic, strong) GoodsModel *model;

@end
