//
//  CreateOrderAmountCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//商品金额cell

#import "BaseTableViewCell.h"
@class CreateOrderGoodsPrices;
@interface CreateOrderAmountCell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) CreateOrderGoodsPrices * model;
@end
