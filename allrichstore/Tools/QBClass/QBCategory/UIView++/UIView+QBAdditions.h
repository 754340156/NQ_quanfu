//
//  UIView+QBAdditions.h
//  RQBClass
//
//  Created by apple on 15/1/15.
//  Copyright © 2015年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QBAdditions)

@property CGFloat top;
@property CGFloat bottom;
@property CGFloat left;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

@property CGFloat height;
@property CGFloat width;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

@end
