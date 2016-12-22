//
//  QBShowAlert.h
//  YunSuLive
//
//  Created by 任强宾 on 16/7/7.
//  Copyright © 2016年 22. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBShowAlert : NSObject

//展示一个AlertController
+ (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style actions:(NSArray *)actions atViewController:(UIViewController *)viewController;

@end
