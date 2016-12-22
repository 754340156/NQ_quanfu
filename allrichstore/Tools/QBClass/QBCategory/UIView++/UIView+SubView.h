//
//  UIView+SubView.h
//  LiveTest
//
//  Created by 任强宾 on 16/8/16.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>

//线的默认颜色
#define kLine_Color_Default [UIColor colorWithWhite:0.9 alpha:1.0]

@interface UIView (SubView)

@property (nonatomic, strong) UIImageView *errorView;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, strong) UIView *toastView;

#pragma mark - 加载视图
- (void)showLoadingView;    //展示加载视图
- (void)dismissLoadingView; //让加载视图消失

#pragma mark - 错误视图
- (void)showErrorViewWithImage:(UIImage *)image;  //展示错误视图
- (void)dismissErrorView;   //让错误视图消失

#pragma mark - 吐丝视图
- (void)showToastMsg:(NSString *)msg;   //展示吐丝
- (void)showToastMsg:(NSString *)msg time:(CGFloat)time;
- (void)showToastMsg:(NSString *)msg completion:(void(^)())completion;
- (void)showToastMsg:(NSString *)msg time:(CGFloat)time completion:(void(^)())completion;

- (void)dismissToast;   //让吐丝消息
#pragma mark - 毛玻璃视图
//插入毛玻璃视图 在视图底部
- (void)showEffectViewWithStyle:(UIBlurEffectStyle)style
                          alpha:(CGFloat)alpha;
//移除毛玻璃视图
- (void)dismissEffectView;

#pragma mark - 添加线
#pragma mark - -添加顶线-
//布局方式
typedef NS_ENUM(NSInteger, LineLayoutStyle)
{
    LineLayoutStyleInside = 0,  //内侧
    LineLayoutStyleMiddle,      //中间
    LineLayoutStyleOutside      //外侧
};

- (void)addTopLine;
- (void)addTopLineWithColor:(UIColor *)color;
- (void)addTopLineWithHeight:(CGFloat)height;
- (void)addTopLineWithColor:(UIColor *)color height:(CGFloat)height;
- (void)addTopLineWithStyle:(LineLayoutStyle)style;
- (void)addTopLineWithColor:(UIColor *)color style:(LineLayoutStyle)style;
- (void)addTopLineWithHeight:(CGFloat)height style:(LineLayoutStyle)style;
- (void)addTopLineWithColor:(UIColor *)color height:(CGFloat)height style:(LineLayoutStyle)style;

#pragma mark - -添加左线-
- (void)addLeftLine;
- (void)addLeftLineWithColor:(UIColor *)color;
- (void)addLeftLineWithWidth:(CGFloat)width;
- (void)addLeftLineWithColor:(UIColor *)color width:(CGFloat)width;
- (void)addLeftLineWithStyle:(LineLayoutStyle)style;
- (void)addLeftLineWithColor:(UIColor *)color style:(LineLayoutStyle)style;
- (void)addLeftLineWithWidth:(CGFloat)width style:(LineLayoutStyle)style;
- (void)addLeftLineWithColor:(UIColor *)color width:(CGFloat)width style:(LineLayoutStyle)style;
- (void)addLeftLineWithColor:(UIColor *)color width:(CGFloat)width margin:(CGFloat)margin style:(LineLayoutStyle)style;

#pragma mark - -添加底线-
- (void)addBottomLine;
- (void)addBottomLineWithColor:(UIColor *)color;
- (void)addBottomLineWithHeight:(CGFloat)height;
- (void)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height;
- (void)addBottomLineWithStyle:(LineLayoutStyle)style;
- (void)addBottomLineWithColor:(UIColor *)color style:(LineLayoutStyle)style;
- (void)addBottomLineWithHeight:(CGFloat)height style:(LineLayoutStyle)style;
- (void)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height style:(LineLayoutStyle)style;

#pragma mark - -添加右线-
- (void)addRightLine;
- (void)addRightLineWithColor:(UIColor *)color;
- (void)addRightLineWithWidth:(CGFloat)width;
- (void)addRightLineWithColor:(UIColor *)color width:(CGFloat)width;
- (void)addRightLineWithStyle:(LineLayoutStyle)style;
- (void)addRightLineWithColor:(UIColor *)color style:(LineLayoutStyle)style;
- (void)addRightLineWithWidth:(CGFloat)width style:(LineLayoutStyle)style;
- (void)addRightLineWithColor:(UIColor *)color width:(CGFloat)width style:(LineLayoutStyle)style;

@end
