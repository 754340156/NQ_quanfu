//
//  MyOrderRefundApplyModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface MyOrderRefundApplyModel : BaseModel
/**  订单编号 */
@property(nonatomic,copy) NSString * orderNumber;
/**  下单时间 */
@property(nonatomic,copy) NSString * orderTime;
/**  商品名 */
@property(nonatomic,copy) NSString * title;
/**  商品图片 */
@property(nonatomic,copy) NSString * goodImage;
/**  商品数量 */
@property(nonatomic,copy) NSString * number;
@end
