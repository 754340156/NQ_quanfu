//
//  UIAlertController+Block.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/14.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlertTitleAble <NSObject>

- (NSString *)alertTitle;

@end

@interface UIAlertController (Block)

+ (UIAlertController *)qb_showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void (^)(UIAlertController *alertController, NSInteger buttonIndex))block vc:(UIViewController *)vc;

+ (UIAlertController *)qb_showSheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitles:(NSArray *)otherTitles handler:(void (^)(UIAlertController *alertController, NSInteger buttonIndex))block vc:(UIViewController *)vc;

@end
