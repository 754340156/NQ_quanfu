//
//  ShopHomeModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/19.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"
#import "GoodsModel.h"

@class ShopCoupon;
@interface ShopHomeModel : BaseModel

@property (nonatomic, copy) NSString *collectstate;
@property (nonatomic, copy) NSString *shopid;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *activityname;
@property (nonatomic, strong) NSArray<GoodsModel *> *shopactivity;
@property (nonatomic, strong) NSArray<ShopCoupon *> *shopcoupon;

@end

@interface ShopCoupon : BaseModel

@property (nonatomic, copy) NSString *c_shopid;
@property (nonatomic, copy) NSString *c_status;
@property (nonatomic, copy) NSString *c_endtime;
@property (nonatomic, copy) NSString *c_type;
@property (nonatomic, copy) NSString *c_image;
@property (nonatomic, copy) NSString *c_costmin;
@property (nonatomic, copy) NSString *c_costmax;

@end
