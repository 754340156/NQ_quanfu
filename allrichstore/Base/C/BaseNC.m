//
//  BaseNC.m
//  LiveTest
//
//  Created by 任强宾 on 16/9/16.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "BaseNC.h"

//@class LiveVC;

@interface BaseNC ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNC

//初始化带返回按钮的
- (instancetype)initWithBackBtnStyleRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        rootViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:Image_NaviBar_Left_Back style:UIBarButtonItemStylePlain target:rootViewController action:@selector(handleDismiss)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    // 获取系统自带滑动手势的target对象
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
    */
    
    self.navigationBar.backgroundColor =Color_CustomEffectViewbg;
    
//     [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.98]] forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.translucent = YES;
//    self.navigationBar.barStyle = UIBlurEffectStyleExtraLight;
    //self.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.90]]];
}

/*
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    
    BOOL isLeftMove = NO;
    
    if ([gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]])
    {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];//x区分左滑右滑 大于0是向右滑动
        if (translation.x < 0)
        {
            isLeftMove = YES;
        }
    }

    
    if (self.childViewControllers.count == 1 || isLeftMove) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    return YES;
}
*/

#pragma mark - handle action

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
