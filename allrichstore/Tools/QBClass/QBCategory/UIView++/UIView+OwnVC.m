//
//  UIView+OwnVC.m
//  LiveTest
//
//  Created by 任强宾 on 16/9/20.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "UIView+OwnVC.h"

@implementation UIView (OwnVC)

- (UIViewController *)currentVC
{
    for (UIView *next = self; next; next = next.superview) {
        
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)nextResponder;
            
        }
    }
    return nil;
}

@end
