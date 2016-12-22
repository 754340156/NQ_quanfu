//
//  UIScrollView+qbExtension.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/27.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (qbExtension)

@property (nonatomic, assign) UIEdgeInsets insets;

//设置刷新头
- (void)setRefreshHeader:(id)header;
//设置刷新尾
- (void)setRefreshFooter:(id)footer;

@end
