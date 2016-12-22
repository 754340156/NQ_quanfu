//
//  QBShowMessage.h
//  RQBClass
//
//  Created by apple on 15/1/12.
//  Copyright © 2015年 任强宾. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface QBShowMessage : NSObject

//在窗口展示消息信息(默认样式)
+ (void)showMessage:(NSString *)message;

//在窗口展示消息信息(默认样式)(自定义时间)
+ (void)showMessage:(NSString *)message
               time:(CGFloat)time;

//在窗口中心展示消息信息(默认样式)(自定义时间)
+ (void)showMessageAtCenter:(NSString *)message
               time:(CGFloat)time;

//在窗口展示消息信息(默认样式)(自定义高度)
+ (void)showMessage:(NSString *)message
              atTop:(CGFloat)top;

//在窗口展示消息信息(默认样式)(自定义高度, 时间)
+ (void)showMessage:(NSString *)message
              atTop:(CGFloat)top
               time:(CGFloat)time;

//隐藏显示的消息(在切换界面的时候需要调用)(避免新的页面残留上一个页面的提醒消息)
+ (void)hiddenMessage;  //对所有showMessage都起作用

//展示信息(第二种类型)(自定义时间, 前景色, 背景色)
+ (void)showMessage:(NSString *)message
               time:(CGFloat)time
          backColor:(UIColor *)backColor
         frontColor:(UIColor *)frontColor;

//展示动画弹窗信息
+ (void)showPopWindowWithMessage1:(NSString *)message1
                         message2:(NSString *)message2
                         message3:(NSString *)message3
                             time:(CGFloat)time
                            frame:(CGRect)frame
                        backColor:(UIColor *)backColor
                       frontColor:(UIColor *)frontColor;


@end
