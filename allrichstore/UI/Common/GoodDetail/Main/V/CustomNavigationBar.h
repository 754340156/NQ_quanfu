//
//  CustomNavigationBar.h
//  allrichstore
//
//  Created by zhaozhe on 16/12/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomNavigationBarDelegate <NSObject>
/**  返回 */
- (void)CustomNavigationBar_back;
/**  分享 */
- (void)CustomNavigationBar_share;
/**  购物车 */
- (void)CustomNavigationBar_cart;
@end

@interface CustomNavigationBar : UIView
/**  代理*/
@property (nonatomic,weak) id <CustomNavigationBarDelegate> delegate;
/**  下面的线 */
@property(nonatomic,strong) UIView * lineView;
/**  设置隐藏状态下的图片 */
- (void)setHiddenStatusButtonImage;
/**  设置显示状态下的图片 */
- (void)setShowStatusButtonImageWithAlpha:(CGFloat)alpha;
@end
