//
//  MyOrderRefundApplyCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class MyOrderRefundApplyModel;
@protocol MyOrderRefundApplyCellDelegate <NSObject>
/**  申请售后 */
- (void)MyOrderRefundApplyCellDelegate_clickApply;

@end

@interface MyOrderRefundApplyCell : BaseTableViewCell
/**  代理*/
@property (nonatomic,weak) id <MyOrderRefundApplyCellDelegate> delegate;
/**  model */
@property(nonatomic,strong) MyOrderRefundApplyModel * model;
@end
