//
//  CreateOrderScrollView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CreateOrderModel;

@protocol CreateOrderScrollViewdelegate <NSObject>
/**  点击头部选择收货地址 */
- (void)CreateOrderScrollViewdelegate_clickHeaderView;
/**  点击服务选项 */
- (void)CreateOrderScrollViewdelegate_clickServiceCellWithIndexPath:(NSIndexPath *)indexPath;
/**  点击开关 */
- (void)CreateOrderScrollViewdelegate_clickSwitchWithIsSelected:(BOOL)isSelected;

@end

@interface CreateOrderScrollView : UIScrollView
/**  model */
@property(nonatomic,strong) CreateOrderModel * model;
/**  代理*/
@property (nonatomic,weak) id <CreateOrderScrollViewdelegate> CO_delegate;
@end
