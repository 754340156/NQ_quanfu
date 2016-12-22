//
//  CreateOrderCashCouponCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/12/5.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol CreateOrderCashCouponCellDelegate <NSObject>

- (void)CreateOrderCashCouponCellDelegate_clickSureWithNumber:(NSString *)number;

@end

@interface CreateOrderCashCouponCell : BaseTableViewCell
/**  代理*/
@property (nonatomic,weak) id <CreateOrderCashCouponCellDelegate> delegate;
@end
