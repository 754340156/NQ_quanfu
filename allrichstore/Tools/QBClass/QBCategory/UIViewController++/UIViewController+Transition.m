//
//  UIViewController+Transition.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "UIViewController+Transition.h"

@implementation UIViewController (Transition)

#pragma mark - present / dismiss
- (void)presentVC:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion
{
    [self presentViewController:vc animated:animated completion:completion];
}

- (void)dismissVCAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self dismissViewControllerAnimated:animated completion:completion];
}

@end
