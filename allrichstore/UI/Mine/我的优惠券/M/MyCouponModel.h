//
//  MyCouponModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface MyCouponModel : BaseModel
/**  优惠卷价值金额 */
@property(nonatomic,copy) NSString * cCostmax;
/**  优惠卷满额要求数 */
@property(nonatomic,copy) NSString * cCostmin;
/**  活动开始时间 */
@property(nonatomic,copy) NSString * cBegintime;
/**  结束时间 */
@property(nonatomic,copy) NSString * cEndtime;
/**  优惠券照片 */
@property(nonatomic,copy) NSString * cImage;
@end
