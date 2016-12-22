//
//  GoodsOneListFirstStyleCell.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "GoodsModel.h"  //商品model

@interface GoodsOneListFirstStyleCell : BaseCollectionViewCell

//价格
@property (nonatomic, strong) UILabel *priceLabel;
//地址
@property (nonatomic, strong) UILabel *addressLabel;
//好评率
@property (nonatomic, strong) UILabel *praiseRateLabel;
//付款人数
@property (nonatomic, strong) UILabel *payCountLabel;

//商品的model
@property (nonatomic, strong) GoodsModel *model;

@end
