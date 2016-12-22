//
//  MyCoupon_Cell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class MyCouponModel;
@interface MyCoupon_Cell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) MyCouponModel * model;
/**  使用状态 */
@property(nonatomic,copy) NSString * usedState;
@end
