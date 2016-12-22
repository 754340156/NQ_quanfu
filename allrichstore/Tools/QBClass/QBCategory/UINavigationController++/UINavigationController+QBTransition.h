//
//  UINavigationController+QBTransition.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (QBTransition)

//push
- (void)pushVC:(UIViewController *)vc  animated:(BOOL)animated;
////pop
//- (UIViewController *)popVCAnimated:(BOOL)animated;

@end
