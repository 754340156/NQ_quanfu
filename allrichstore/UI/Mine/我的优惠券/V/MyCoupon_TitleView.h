//
//  MyCoupon_TitleView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCoupon_TitleViewDelegate <NSObject>

- (void)MyCoupon_TitleViewDelegate_clickIndex:(NSInteger)index;

@end


@interface MyCoupon_TitleView : UIView

- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray;
/**  代理*/
@property (nonatomic,weak) id <MyCoupon_TitleViewDelegate> delegate;
/**  点击一下按钮 */
- (void)MyCoupon_TitleViewClickWithIndex:(NSInteger)index;

/**  设置指定index的title */
- (void)UpdateTitleWithIndex:(NSInteger )index Title:(NSString *)title;
@end
