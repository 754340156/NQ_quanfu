//
//  GoodClassTwoLevelModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/30.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"
#import "GoodsClassModel.h"

//二三级商品分类model
@interface GoodClassTwoLevelModel : BaseModel

@property (nonatomic, copy) NSString *cType;
@property (nonatomic, strong) NSString *cName;
@property (nonatomic, strong) NSArray<GoodsClassModel *> *thrid;

@end
