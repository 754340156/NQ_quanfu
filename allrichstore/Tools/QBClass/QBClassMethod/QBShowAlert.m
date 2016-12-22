//
//  QBShowAlert.m
//  YunSuLive
//
//  Created by 任强宾 on 16/7/7.
//  Copyright © 2016年 22. All rights reserved.
//

#import "QBShowAlert.h"

@implementation QBShowAlert

//展示一个AlertController
+ (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style actions:(NSArray *)actions atViewController:(UIViewController *)viewController
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for (UIAlertAction *action in actions)
    {
        [alertC addAction:action];
    }
    [viewController presentViewController:alertC animated:YES completion:nil];
}

@end
