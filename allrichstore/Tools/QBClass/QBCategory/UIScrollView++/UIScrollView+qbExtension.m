//
//  UIScrollView+qbExtension.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/27.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "UIScrollView+qbExtension.h"

static void *scrollViewInset = &scrollViewInset;

@implementation UIScrollView (qbExtension)

#pragma mark - setter getter
- (void)setInsets:(UIEdgeInsets)insets
{
    NSValue *value = [NSValue value:&insets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &scrollViewInset, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.contentInset = insets;
    self.scrollIndicatorInsets = insets;
    self.contentOffset = CGPointMake(-insets.left, -insets.top);
}

- (UIEdgeInsets)insets
{
    NSValue *value = objc_getAssociatedObject(self, &scrollViewInset);
    if(value)
    {
        UIEdgeInsets aInsets;
        [value getValue:&aInsets];
        return aInsets;
    }
    else
    {
        return UIEdgeInsetsZero;
    }
}

//设置刷新头
- (void)setRefreshHeader:(id)header
{
    [self setMj_header:header];
}

//设置刷新尾
- (void)setRefreshFooter:(id)footer
{
    [self setMj_footer:footer];
}

@end
