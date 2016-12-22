//
//  CreateOrderHeaderView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CreateOrderModel;

@protocol CreateOrderHeaderViewDelegate <NSObject>

- (void)CreateOrderHeaderViewDelegate_clickSelf;

@end

@interface CreateOrderHeaderView : UIView
/**  model */
@property(nonatomic,strong) CreateOrderModel * model;
/**  代理*/
@property (nonatomic,weak) id <CreateOrderHeaderViewDelegate> delegate;
@end
