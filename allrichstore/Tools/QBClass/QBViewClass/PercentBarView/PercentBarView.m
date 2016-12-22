//
//  PercentBarView.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/6.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "PercentBarView.h"  //比例条视图

#pragma mark - 默认配置
//默认背景颜色
#define kBgColor    [UIColor colorWithWhite:0.9 alpha:1.0]

//百分条背景色(默认)
#define kFrontBarColor   [UIColor redColor]
//百分条的圆角比(默认)
#define kFrontBarCornerPercent (1 / 6.0)

//百分比的字体颜色
#define kPercentTextColor   [UIColor whiteColor]


@interface PercentBarView ()

@property (nonatomic, copy) PercentAction actionBlock;
@property (nonatomic, strong) UIView *frontBarView;

@end

@implementation PercentBarView

/**
 @param frame frame
 @param style 布局类型
 @param configure 初始配置
 @param action 事件触发
 */
- (instancetype)initWithFrame:(CGRect)frame
                        style:(PercentBarStyle)style
                    configure:(PercentBarConfigure)configure
                       action:(PercentAction)action
{
    self = [self initWithFrame:frame];
    if (self)
    {
        //默认配置
        self.backgroundColor = kBgColor;
        self.frontBarColor = kFrontBarColor;
        self.frontBarCornerPercent = kFrontBarCornerPercent;
        self.style = style;
        self.currentPercent = 0.0f;
        //外部配置
        configure(self);
        
        if (style == PercentBarStyleHorizontal) {
            self.layer.cornerRadius = self.frame.size.height * 1 / 6.0;
        } else {
            self.layer.cornerRadius = self.frame.size.width * 1 / 6.0;
        }
        [self createViews]; //创建子视图
        [self layoutViews]; //布局子视图
        self.actionBlock = action;
        
    }
    return self;
}

/**
 @param frame frame
 @param configure 初始配置
 @param action 事件触发
 */
- (instancetype)initWithFrame:(CGRect)frame
                    configure:(PercentBarConfigure)configure
                       action:(PercentAction)action
{
    return [self initWithFrame:frame style:PercentBarStyleHorizontal configure:configure action:action];
}


#pragma mark - override super
//创建子视图
- (void)createViews
{
    //百分条上添加百分比label
    [self.frontBarView addSubview:self.percentLabel];
    //添加百分条
    [self addSubview:self.frontBarView];
    
    
}

//布局子视图
- (void)layoutViews
{
    if (_style == PercentBarStyleHorizontal)
    {
        _frontBarView.frame = CGRectMake(0, 0, self.frame.size.width * self.currentPercent, self.frame.size.height);
        _percentLabel.frame = _frontBarView.bounds;
        _frontBarView.layer.cornerRadius = _frontBarView.frame.size.height * _frontBarCornerPercent;
    }
    else
    {
        CGFloat barHeight = self.frame.size.height * self.currentPercent;
        _frontBarView.frame = CGRectMake(0, self.frame.size.height - barHeight, self.frame.size.width, barHeight);
        _percentLabel.frame = _frontBarView.bounds;
        _frontBarView.layer.cornerRadius = _frontBarView.frame.size.width * _frontBarCornerPercent;
    }
}

#pragma mark - lazy
//百分条
- (UIView *)frontBarView
{
    if (!_frontBarView)
    {
        self.frontBarView = [UIView new];
        _frontBarView.backgroundColor = _frontBarColor;
    }
    return _frontBarView;
}

//百分比label
- (UILabel *)percentLabel
{
    if (!_percentLabel)
    {
        self.percentLabel = [UILabel new];
        _percentLabel.textColor = kPercentTextColor;
        _percentLabel.font = [UIFont systemFontOfSize:13];
        _percentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _percentLabel;
}

#pragma mark - handle action

#pragma mark - setter
//当前百分比
- (void)setCurrentPercent:(CGFloat)currentPercent
{
    if (_currentPercent == currentPercent)
    {
        return;
    }
    if (_currentPercent < 0 || _currentPercent > 1.0)
    {
        return;
    }
    
    
    _currentPercent = currentPercent;
    self.percentLabel.text = [NSString stringWithFormat:@"%.0f%%",_currentPercent * 100.0f];
    
    [self layoutViews]; //更新视图
}

@end
