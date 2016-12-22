//
//  MyCoupon_UnusedVC.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"

@interface MyCoupon_UnusedVC : BaseVC
/**  请求完成修改titleView数组 */
@property(nonatomic,copy) void(^NetworkFinishBlock)(NSInteger count);
@end
