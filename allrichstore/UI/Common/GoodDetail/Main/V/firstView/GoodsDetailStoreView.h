//
//  GoodsDetailStoreView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailModel;

@protocol GoodsDetailStoreViewDelegate <NSObject>
///**  点击整体 */
//- (void)GoodsDetailStoreViewDelegate_clickView:(UIView *)storeView;
//
///**  点击进入按钮 */
//- (void)GoodsDetailStoreViewDelegate_clickIntoButton:(UIButton *)intoButton;
@end

@interface GoodsDetailStoreView : UIView
/**  model */
@property(nonatomic,strong) GoodsDetailModel * model;
/**  代理*/
//@property (nonatomic,weak) id <GoodsDetailStoreViewDelegate> delegate;
@end
