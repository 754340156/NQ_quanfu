//
//  MyCollectionTitleView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  MyCollectionTitleViewDelegate<NSObject>

- (void)MyCollectionTitleViewDelegate_clickIndex:(NSInteger)index;

@end

@interface MyCollectionTitleView : UIView
/**  代理*/
@property (nonatomic,weak) id <MyCollectionTitleViewDelegate> delegate;
/**  点击一下按钮 */
- (void)MyCollectionTitleViewClickWithIndex:(NSInteger)index;
/**  初始化方法 */
- (instancetype)initWithTitleArray:(NSArray *)array Frame:(CGRect)frame;
@end
