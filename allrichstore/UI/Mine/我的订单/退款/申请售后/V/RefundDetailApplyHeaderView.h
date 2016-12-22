//
//  RefundDetailApplyHeaderView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHeaderHeight 120.0f
@class RefundDetailApplyModel;
@protocol RefundDetailApplyHeaderViewDelegate <NSObject>

- (void)RefundDetailApplyHeaderViewDelegate_clickContactSellerBtn;

@end


@interface RefundDetailApplyHeaderView : UIView
/**  代理*/
@property (nonatomic,weak) id <RefundDetailApplyHeaderViewDelegate> delegate;
/**  model */
@property(nonatomic,strong) RefundDetailApplyModel * model;
@end
