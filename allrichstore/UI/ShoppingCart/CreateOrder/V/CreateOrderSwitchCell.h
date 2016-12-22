//
//  CreateOrderSwitchCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol CreateOrderSwitchCellDelegate <NSObject>

/**  点击switch */
- (void)CreateOrderSwitchCellDelegate_clickSwitchWithIsSelected:(BOOL)isSelected;

@end

@class CreateOrderModel;
@interface CreateOrderSwitchCell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) CreateOrderModel * model;
/**  代理*/
@property (nonatomic,weak) id <CreateOrderSwitchCellDelegate> delegate;
@end
