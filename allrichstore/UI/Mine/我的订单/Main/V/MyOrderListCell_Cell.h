//
//  MyOrderListCell_Cell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MyOrderList_GoodsModel;
@interface MyOrderListCell_Cell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) MyOrderList_GoodsModel * model;
@end
