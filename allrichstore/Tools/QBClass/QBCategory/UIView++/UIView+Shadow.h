//
//  UIView+Shadow.h
//  allrichstore
//
//  Created by 任强宾 on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shadow)

- (void)setShadow;

- (void)setShadowWithColor:(UIColor *)shadowColor;

- (void)setShadowWithOffset:(CGSize)size;

- (void)setShadowWithColor:(UIColor *)shadowColor offset:(CGSize)size;

@end
