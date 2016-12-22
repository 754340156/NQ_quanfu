//
//  GoodsDetailHeaderView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailModel;
@protocol GoodsDetailHeaderViewDelegate <NSObject>
/** 点击轮播图 */
- (void)GoodsDetailHeaderViewDelegate_clickCycleScrollView:(SDCycleScrollView *)cycleScrollView index:(NSInteger )index;
@end


@interface GoodsDetailHeaderView : UIView
/**  代理*/
@property (nonatomic,weak) id <GoodsDetailHeaderViewDelegate> delegate;
/**  model */
@property(nonatomic,strong) GoodsDetailModel * model;
@end
