//
//  UIView+Shadow.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (void)setShadow
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //阴影的透明度
    self.layer.shadowOpacity = 0.8f;
    //阴影的圆角
    self.layer.shadowRadius = 2.f;
    
    self.layer.shadowOffset = CGSizeMake(2, 2);
}

- (void)setShadowWithColor:(UIColor *)shadowColor
{
    self.layer.shadowColor = shadowColor.CGColor;
    //阴影的透明度
    self.layer.shadowOpacity = 0.8f;
    //阴影的圆角
    self.layer.shadowRadius = 2.f;
    
    self.layer.shadowOffset = CGSizeMake(2, 2);
}

- (void)setShadowWithOffset:(CGSize)size
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //阴影的透明度
    self.layer.shadowOpacity = 0.8f;
    //阴影的圆角
    self.layer.shadowRadius = 2.f;
    self.layer.shadowOffset = size;
}

- (void)setShadowWithColor:(UIColor *)shadowColor offset:(CGSize)size
{
    self.layer.shadowColor = shadowColor.CGColor;
    //阴影的透明度
    self.layer.shadowOpacity = 0.8f;
    //阴影的圆角
    self.layer.shadowRadius = 2.f;
    self.layer.shadowOffset = size;
}

@end
