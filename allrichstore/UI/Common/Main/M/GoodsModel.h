//
//  GoodsModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/12.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsModel : BaseModel

//销量
@property (nonatomic, assign) long g_salenumber;
//付款人数
@property (nonatomic, assign) long g_paysum;
//商品id
@property (nonatomic, assign) long goodid;
//评论个数
@property (nonatomic, assign) long g_commentcount;
//商品名称
@property (nonatomic, copy) NSString *g_name;
//商品的图片地址
@property (nonatomic, copy) NSString *g_imgurl;
//地址
@property (nonatomic, copy) NSString *g_site;
//好评率
@property (nonatomic, copy) NSString *g_famerate;
//商品的价格
@property (nonatomic, assign) double g_price;

@end
