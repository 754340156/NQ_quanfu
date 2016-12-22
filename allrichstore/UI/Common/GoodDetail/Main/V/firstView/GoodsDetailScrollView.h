//
//  GoodsDetailScrollView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailModel,GoodsDetailEvaluativeView;

@protocol GoodsDetailScrollViewDelegate <NSObject>

/**  点击评论整体 */
- (void)GoodsDetailScrollViewDelegate_clickEvaluativeWithEvaluativeView:(GoodsDetailEvaluativeView *)evaluativeView;
@end

@interface GoodsDetailScrollView : UIScrollView
/**  model */
@property(nonatomic,strong) GoodsDetailModel * model;
/**  代理*/
@property (nonatomic,weak) id <GoodsDetailScrollViewDelegate> GD_delegate;

@end
