//
//  QBShowMessage.m
//  RQBClass
//
//  Created by apple on 15/1/12.
//  Copyright © 2015年 任强宾. All rights reserved.
//


#import "QBShowMessage.h"

#define kBackGroudAlpha 0.6

#define kBackGroudColor [UIColor colorWithWhite:0.0 alpha:kBackGroudAlpha]

#define CornerRadius  8

#define kTime 1.2

//字号大小
#define kFontSize 13

//单行高度
#define kLineHeight 30

//默认高度比例
#define kTopScale 3.8 / 5.0

@implementation QBShowMessage

//在窗口展示消息信息(默认样式)
+ (void)showMessage:(NSString *)message
{
    //把原来在窗口展示消息信息 移除
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIView *view in window.subviews)
    {
        if (view.tag == 1001 || view.tag == 1002)
        {
            [view removeFromSuperview];
        }
    }
    //在窗口添加新的展示消息信息
    CGFloat height = (kScreenW - kFontSize * (message.length + 2)) >= (kFontSize * 4) ? kLineHeight : kLineHeight * 2;
    CGFloat leftMargin = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? (kScreenW - kFontSize * (message.length + 2)) / 2 : (kFontSize * 2);
    CGFloat width = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? kFontSize * (message.length + 2) : (kScreenW - (kFontSize * 4));
    
    CGFloat heightLabel = height;
    CGFloat leftMarginLabel = leftMargin + kFontSize;
    CGFloat widthLabel = width - (kFontSize * 2);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(leftMargin, kScreenH * kTopScale - height / 2.0, width, height)];
    //	//加阴影
    //	view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    //	view.layer.shadowOffset = CGSizeMake(0, 3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    //	view.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    //	view.layer.shadowRadius = 2;//阴影半径，默认3
    view.layer.cornerRadius = CornerRadius;
    view.layer.masksToBounds = YES;
    view.tag = 1001;
    view.backgroundColor = kBackGroudColor;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftMarginLabel, view.top, widthLabel, heightLabel)];
    label.layer.cornerRadius = CornerRadius;
    label.layer.masksToBounds = YES;
    label.tag = 1002;
    label.font = [UIFont systemFontOfSize:kFontSize];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:label];
    
    view.alpha = 0;
    label.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0.8;
        label.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kTime animations:^{
            view.alpha = 0.81;
            label.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha = 0.3;
                label.alpha = 0.5;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                [label removeFromSuperview];
            }];
        }];
    }];
}

//在窗口展示消息信息(默认样式)(自定义时间)
+ (void)showMessage:(NSString *)message
               time:(CGFloat)time
{
    //把原来在窗口展示消息信息 移除
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIView *view in window.subviews)
    {
        if (view.tag == 1001 || view.tag == 1002)
        {
            [view removeFromSuperview];
        }
    }
    
    //在窗口添加新的展示消息信息
    CGFloat height = (kScreenW - kFontSize * (message.length + 2)) >= (kFontSize * 4) ? kLineHeight : kLineHeight * 2;
    CGFloat leftMargin = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? (kScreenW - kFontSize * (message.length + 2)) / 2 : (kFontSize * 2);
    CGFloat width = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? kFontSize * (message.length + 2) : (kScreenW - (kFontSize * 4));
    
    CGFloat heightLabel = height;
    CGFloat leftMarginLabel = leftMargin + kFontSize;
    CGFloat widthLabel = width - (kFontSize * 2);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(leftMargin, kScreenH * kTopScale - height / 2.0, width, height)];
    //	//加阴影
    //	view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    //	view.layer.shadowOffset = CGSizeMake(0, 3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    //	view.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    //	view.layer.shadowRadius = 2;//阴影半径，默认3
    view.layer.cornerRadius = CornerRadius;
    view.layer.masksToBounds = YES;
    view.tag = 1001;
    view.backgroundColor = kBackGroudColor;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftMarginLabel, view.top, widthLabel, heightLabel)];
    
    label.layer.cornerRadius = CornerRadius;
    label.layer.masksToBounds = YES;
    label.tag = 1002;
    label.font = [UIFont systemFontOfSize:kFontSize];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:label];
    
    view.alpha = 0;
    label.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0.8;
        label.alpha = 0.9;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kTime animations:^{
            view.alpha = 0.81;
            label.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha = 0.3;
                label.alpha = 0.5;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                [label removeFromSuperview];
            }];
        }];
    }];
}

//在窗口中心展示消息信息(默认样式)(自定义时间)
+ (void)showMessageAtCenter:(NSString *)message
                       time:(CGFloat)time
{
    //把原来在窗口展示消息信息 移除
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIView *view in window.subviews)
    {
        if (view.tag == 1001 || view.tag == 1002)
        {
            [view removeFromSuperview];
        }
    }
    
    //在窗口添加新的展示消息信息
    CGFloat height = (kScreenW - kFontSize * (message.length + 2)) >= (kFontSize * 4) ? kLineHeight : kLineHeight * 2;
    CGFloat leftMargin = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? (kScreenW - kFontSize * (message.length + 2)) / 2 : (kFontSize * 2);
    CGFloat width = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? kFontSize * (message.length + 2) : (kScreenW - (kFontSize * 4));
    
    CGFloat heightLabel = height;
    CGFloat leftMarginLabel = leftMargin + kFontSize;
    CGFloat widthLabel = width - (kFontSize * 2);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(leftMargin, kScreenH * kTopScale - height / 2.0, width, height)];
    view.center = window.center;
    //	//加阴影
    //	view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    //	view.layer.shadowOffset = CGSizeMake(0, 3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    //	view.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    //	view.layer.shadowRadius = 2;//阴影半径，默认3
    view.layer.cornerRadius = CornerRadius;
    view.layer.masksToBounds = YES;
    view.tag = 1001;
    view.backgroundColor = kBackGroudColor;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftMarginLabel, view.top, widthLabel, heightLabel)];
    
    label.layer.cornerRadius = CornerRadius;
    label.layer.masksToBounds = YES;
    label.tag = 1002;
    label.font = [UIFont systemFontOfSize:kFontSize];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:label];
    
    view.alpha = 0;
    label.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0.8;
        label.alpha = 0.9;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kTime animations:^{
            view.alpha = 0.81;
            label.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha = 0.3;
                label.alpha = 0.5;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                [label removeFromSuperview];
            }];
        }];
    }];
}

//在窗口展示消息信息(默认样式) 自定义高度
+ (void)showMessage:(NSString *)message
              atTop:(CGFloat)top
{
    //把原来在窗口展示消息信息 移除
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIView *view in window.subviews)
    {
        if (view.tag == 1001 || view.tag == 1002)
        {
            [view removeFromSuperview];
        }
    }
    
    //在窗口添加新的展示消息信息
    CGFloat height = (kScreenW - kFontSize * (message.length + 2)) >= (kFontSize * 4) ? kLineHeight : kLineHeight * 2;
    CGFloat leftMargin = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? (kScreenW - kFontSize * (message.length + 2)) / 2 : (kFontSize * 2);
    CGFloat width = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? kFontSize * (message.length + 2) : (kScreenW - (kFontSize * 4));
    
    CGFloat heightLabel = height;
    CGFloat leftMarginLabel = leftMargin + kFontSize;
    CGFloat widthLabel = width - (kFontSize * 2);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(leftMargin, top, width, height)];
    //	//加阴影
    //	view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    //	view.layer.shadowOffset = CGSizeMake(0, 3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    //	view.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    //	view.layer.shadowRadius = 2;//阴影半径，默认3
    view.layer.cornerRadius = CornerRadius;
    view.layer.masksToBounds = YES;
    view.tag = 1001;
    view.backgroundColor = kBackGroudColor;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftMarginLabel, top, widthLabel, heightLabel)];
    
    label.layer.cornerRadius = CornerRadius;
    label.layer.masksToBounds = YES;
    label.tag = 1002;
    label.font = [UIFont systemFontOfSize:kFontSize];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:label];
    
    view.alpha = 0;
    label.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0.8;
        label.alpha = 0.9;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kTime animations:^{
            view.alpha = 0.81;
            label.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha = 0.3;
                label.alpha = 0.5;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                [label removeFromSuperview];
            }];
        }];
    }];
}

//在窗口展示消息信息(默认样式)(自定义高度, 时间)
+ (void)showMessage:(NSString *)message
              atTop:(CGFloat)top
               time:(CGFloat)time
{
    //把原来在窗口展示消息信息 移除
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIView *view in window.subviews)
    {
        if (view.tag == 1001 || view.tag == 1002)
        {
            [view removeFromSuperview];
        }
    }
    
    //在窗口添加新的展示消息信息
    CGFloat height = (kScreenW - kFontSize * (message.length + 2)) >= (kFontSize * 4) ? kLineHeight : kLineHeight * 2;
    CGFloat leftMargin = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? (kScreenW - kFontSize * (message.length + 2)) / 2 : (kFontSize * 2);
    CGFloat width = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? kFontSize * (message.length + 2) : (kScreenW - (kFontSize * 4));
    
    CGFloat heightLabel = height;
    CGFloat leftMarginLabel = leftMargin + kFontSize;
    CGFloat widthLabel = width - (kFontSize * 2);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(leftMargin, top, width, height)];
    //	//加阴影
    //	view.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    //	view.layer.shadowOffset = CGSizeMake(0, 3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    //	view.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    //	view.layer.shadowRadius = 2;//阴影半径，默认3
    view.layer.cornerRadius = CornerRadius;
    view.layer.masksToBounds = YES;
    view.tag = 1001;
    view.backgroundColor = kBackGroudColor;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftMarginLabel, top, widthLabel, heightLabel)];
    
    label.layer.cornerRadius = CornerRadius;
    label.layer.masksToBounds = YES;
    label.tag = 1002;
    label.font = [UIFont systemFontOfSize:kFontSize];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    [[[UIApplication sharedApplication] keyWindow] addSubview:label];
    
    view.alpha = 0;
    label.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0.8;
        label.alpha = 0.9;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kTime animations:^{
            view.alpha = 0.81;
            label.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha = 0.3;
                label.alpha = 0.5;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                [label removeFromSuperview];
            }];
        }];
    }];
}


//隐藏显示的消息(在切换界面的时候需要调用)(避免新的页面残留上一个页面的提醒消息)
//与showMessage相对应
+ (void)hiddenMessage
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIView *view in window.subviews)
    {
        
        if (view.tag == 1001 || view.tag == 1002)
        {
            [view removeFromSuperview];
        }
    }
}



//展示信息(自定义:一条消息类型)(自定义时间, 前景色, 背景色)
+ (void)showMessage:(NSString *)message
               time:(CGFloat)time
          backColor:(UIColor *)backColor
         frontColor:(UIColor *)frontColor
{
    //把原来在窗口展示消息信息 移除
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIView *view in window.subviews)
    {
        if (view.tag == 1001 || view.tag == 1002)
        {
            [view removeFromSuperview];
        }
    }
    
    //在窗口添加新的展示消息信息
    CGFloat height = (kScreenW - kFontSize * (message.length + 2)) >= (kFontSize * 4) ? kLineHeight : kLineHeight * 2;
    CGFloat leftMargin = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? (kScreenW - kFontSize * (message.length + 2)) / 2 : (kFontSize * 2);
    CGFloat width = (kScreenW - kFontSize * (message.length + 2)) > (kFontSize * 4) ? kFontSize * (message.length + 2) : (kScreenW - (kFontSize * 4));
    
    CGFloat heightLabel = height;
    CGFloat leftMarginLabel = leftMargin + kFontSize;
    CGFloat widthLabel = width - (kFontSize * 2);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(leftMargin, kScreenH * kTopScale - height / 2.0, width, height)];
    
    //加阴影
    view.layer.shadowColor = kBackGroudColor.CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = CGSizeMake(0, 3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    view.layer.shadowRadius = 2;//阴影半径，默认3
    view.layer.cornerRadius = CornerRadius;
    //	view.layer.masksToBounds = YES;
    view.tag = 1001;
    view.backgroundColor = backColor;
    view.alpha = 0.9;
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftMarginLabel, view.top, widthLabel, heightLabel)];
    
    label.layer.cornerRadius = CornerRadius;
    label.layer.masksToBounds = YES;
    label.tag = 1002;
    label.font = [UIFont systemFontOfSize:kFontSize];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    label.numberOfLines = 0;
    label.textColor = frontColor;
    [[[UIApplication sharedApplication] keyWindow] addSubview:label];
    
    view.alpha = 0;
    label.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 0.9;
        label.alpha = 0.9;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kTime animations:^{
            view.alpha = 0.91;
            label.alpha = 0.91;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha = 0.3;
                label.alpha = 0.5;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                [label removeFromSuperview];
            }];
        }];
    }];
}


//展示信息(自定义:三条消息类型)(自定义时间, 前景色, 背景色)
+ (void)showPopWindowWithMessage1:(NSString *)message1
                         message2:(NSString *)message2
                         message3:(NSString *)message3
                             time:(CGFloat)time
                            frame:(CGRect)frame
                        backColor:(UIColor *)backColor
                       frontColor:(UIColor *)frontColor
{
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = kBackGroudColor;
    view.alpha = 0.2;
    [window addSubview:view];
    
    //创建底部透明视图 - 添加到window上
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    backView.backgroundColor = [UIColor clearColor];
    backView.layer.cornerRadius = CornerRadius;
    
    [window addSubview:backView];
    
    //创建中间的可变透明度的视图 - 添加到底部透明视图上
    UIView *midView = [[UIView alloc] initWithFrame:backView.bounds];
    midView.backgroundColor = backColor;
    midView.layer.cornerRadius = CornerRadius;
    midView.alpha = 1;
    [backView addSubview:midView];
    
    
    //创建展示消息的Label1 - 添加到底部透明视图上
    UILabel *textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, frame.size.width, 30)];
    textLabel1.textAlignment = NSTextAlignmentCenter;
    textLabel1.text = message1;
    textLabel1.textColor = kBackGroudColor;
    textLabel1.font = [UIFont systemFontOfSize:14];
    [backView addSubview:textLabel1];
    
    //创建展示消息的Label2 - 添加到底部透明视图上
    UILabel *textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height - 40) / 2.0, frame.size.width, 40)];
    textLabel2.textAlignment = NSTextAlignmentCenter;
    textLabel2.text = message2;
    textLabel2.textColor = [UIColor redColor];
    textLabel2.font = [UIFont systemFontOfSize:34];
    [backView addSubview:textLabel2];
    
    //创建展示消息的Label3 - 添加到底部透明视图上
    UILabel *textLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 45 , frame.size.width, 30)];
    textLabel3.textAlignment = NSTextAlignmentCenter;
    textLabel3.text = message3;
    textLabel3.textColor = kBackGroudColor;
    textLabel3.font = [UIFont systemFontOfSize:kFontSize];
    [backView addSubview:textLabel3];
    
    //    [UIView animateWithDuration:time animations:^{
    //
    //        midView.alpha = 1;
    //    } completion:^(BOOL finished) {
    //        ;
    //    }];
    
    [UIView animateWithDuration:time animations:^{
        midView.alpha = 0.98;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kTime animations:^{
            midView.alpha = 0.99;
        } completion:^(BOOL finished) {
            //弹窗从父视图上移除
            [view removeFromSuperview];
            [backView removeFromSuperview];
        }];
    }];
}

@end
