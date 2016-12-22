//
//  UINavigationController+QBTransition.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "UINavigationController+QBTransition.h"

@implementation UINavigationController (QBTransition)

#pragma mark - custom method
//push
- (void)pushVC:(UIViewController *)vc  animated:(BOOL)animated
{
    vc.hidesBottomBarWhenPushed = YES;
    [self pushViewController:vc animated:animated];
}


//pop
//- (UIViewController *)popVCAnimated:(BOOL)animated
//{
//    return [self popViewControllerAnimated:animated];
//}

@end
