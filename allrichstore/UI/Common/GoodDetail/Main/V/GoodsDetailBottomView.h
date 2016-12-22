//
//  GoodsDetailBottomView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsDetailBottomViewDelegate <NSObject>
/**  点击客服 */
- (void)GoodsDetailBottomViewDelegate_clickService;
/**  点击店铺 */
- (void)GoodsDetailBottomViewDelegate_clickStore;
/**  点击收藏 */
- (void)GoodsDetailBottomViewDelegate_clickCollectionWithButton:(UIButton *)sender;
/**  点击加入购物车 */
- (void)GoodsDetailBottomViewDelegate_clickIntoCart;
/**  点击立即购买 */
- (void)GoodsDetailBottomViewDelegate_clickBuy;

@end

@interface GoodsDetailBottomView : UIView
/**  代理*/
@property (nonatomic,weak) id <GoodsDetailBottomViewDelegate> delegate;
/**  是否被收藏过 */
@property(nonatomic,assign) BOOL IsCollection;

@end
