//
//  OrderPaySuccessView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderPaySuccessViewDelegate <NSObject>
/**  立即评价 */
- (void)OrderPaySuccessViewDelegate_clickCommentButton;
/**  订单详情 */
- (void)OrderPaySuccessViewDelegate_cliclOrderDetailBtn;
@end

@interface OrderPaySuccessView : UIView
/**  代理*/
@property (nonatomic,weak) id <OrderPaySuccessViewDelegate> delegate;
@end
