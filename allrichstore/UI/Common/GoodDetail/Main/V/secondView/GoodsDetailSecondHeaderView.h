//
//  GoodsDetailSecondHeaderView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsDetailSecondHeaderViewDelegate <NSObject>

- (void)GoodsDetailSecondHeaderViewDelegate_clickIndex:(NSInteger)index;

@end


@interface GoodsDetailSecondHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray;
/**  代理*/
@property (nonatomic,weak) id <GoodsDetailSecondHeaderViewDelegate> delegate;
/**  点击一下按钮 */
- (void)GoodsDetailSecondHeaderViewClickWithIndex:(NSInteger)index;
@end
