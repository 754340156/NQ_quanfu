//
//  MyCollection_GoodsModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface MyCollection_GoodsModel : BaseModel
/**  大图 */
@property(nonatomic,copy) NSString * g_imgurl;
/**  title */
@property(nonatomic,copy) NSString * g_name;
/**  付款人数 */
@property(nonatomic,copy) NSString * g_salenumber;
/**  单品运费 */
@property(nonatomic,copy) NSString * g_freight;
/**  好评率 */
@property(nonatomic,copy) NSString * g_famerate;
/**  地址 */
@property(nonatomic,copy) NSString * g_site;
/**  价格 */
@property(nonatomic,copy) NSString * g_price;
/**  商品id */
@property(nonatomic,copy) NSString * goodid;
@end
