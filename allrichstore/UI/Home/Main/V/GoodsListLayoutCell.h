//
//  GoodsListLayoutCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseCollectionViewCell.h"
@class GoodsModel;
@interface GoodsListLayoutCell : BaseCollectionViewCell
/**  model */
@property(nonatomic,strong) GoodsModel * model;
@end
