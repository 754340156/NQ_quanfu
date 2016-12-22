//
//  MyOrderRefundSearchModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface MyOrderRefundSearchModel : BaseModel
/**  服务单号 */
@property(nonatomic,copy) NSString * serviceNumber;
/**  服务状态 */
@property(nonatomic,copy) NSString * serviceStatus;
/**  商品名 */
@property(nonatomic,copy) NSString * title;
/**  商品图片 */
@property(nonatomic,copy) NSString * goodImage;
/**  申请时间 */
@property(nonatomic,copy) NSString * applyTime;

@end
