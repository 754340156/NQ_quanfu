//
//  UIViewController+Transition.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Transition)

#pragma mark - present / dismiss
- (void)presentVC:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion;

- (void)dismissVCAnimated:(BOOL)animated completion:(void (^)(void))completion;

@end
