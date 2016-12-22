//
//  PercentBarView.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/6.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
/* 本类简介：（支持垂直或水平方向）展示百分比的视图*/

#pragma mark - 定义枚举
typedef NS_ENUM(NSInteger, PercentBarStyle)
{
    PercentBarStyleHorizontal = 0,  //水平方向风格
    PercentBarStyleVertical         //垂直方向风格
};

#pragma mark - 定义block
@class PercentBarView;
//定义：自定义配置block
typedef void(^PercentBarConfigure)(PercentBarView *percentBarView);
//定义：事件触发block
typedef void(^PercentAction)(CGFloat percent);


@interface PercentBarView : UIView

#pragma mark - 自定义初始化方法


/**
 @param frame frame
 @param style 布局类型
 @param configure 初始配置
 @param action 事件触发
 */
- (instancetype)initWithFrame:(CGRect)frame
                        style:(PercentBarStyle)style
                    configure:(PercentBarConfigure)configure
                       action:(PercentAction)action;

/**
 @param frame frame
 @param configure 初始配置
 @param action 事件触发
 */
- (instancetype)initWithFrame:(CGRect)frame
                    configure:(PercentBarConfigure)configure
                       action:(PercentAction)action;

//布局方向类型（水平或垂直）
@property (nonatomic, assign) PercentBarStyle style;
//百分条的背景颜色
@property (nonatomic, strong) UIColor *frontBarColor;
//百分条的圆角比
@property (nonatomic, assign) CGFloat frontBarCornerPercent;
//当前百分比
@property (nonatomic, assign) CGFloat currentPercent;


//百分比label
@property (nonatomic, strong) UILabel *percentLabel;

@end
