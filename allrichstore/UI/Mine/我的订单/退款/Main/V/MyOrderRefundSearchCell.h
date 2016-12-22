//
//  MyOrderRefundSearchCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class MyOrderRefundSearchModel;
@protocol MyOrderRefundSearchCellDelegate <NSObject>
/**  取消申请 */
- (void)MyOrderRefundSearchCellDelegate_clickCancelApply;
/**  进度查询 */
- (void)MyOrderRefundSearchCellDelegate_clickProgressSearch;

@end

@interface MyOrderRefundSearchCell : BaseTableViewCell
/**  代理*/
@property (nonatomic,weak) id <MyOrderRefundSearchCellDelegate> delegate;
/**  model */
@property(nonatomic,strong) MyOrderRefundSearchModel * model;
@end
