//
//  ShopsApplyCalendarVC.h
//  allrichstore
//
//  Created by zhaozhe on 16/12/6.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"

@interface ShopsApplyCalendarVC : BaseVC
/**  返回的日期 */
@property(nonatomic,copy) void(^dateBlock)(NSDate * selectedDate);
@end
