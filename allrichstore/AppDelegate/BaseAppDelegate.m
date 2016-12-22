//
//  BaseAppDelegate.m
//  CommonLibrary
//
//  Created by Alexi on 3/6/14.
//  Copyright (c) 2014 CommonLibrary. All rights reserved.
//

#import "BaseAppDelegate.h"
#import <objc/runtime.h>

#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialSinaSSOHandler.h"

#import <CoreLocation/CoreLocation.h>

@interface BaseAppDelegate ()

@end

@implementation BaseAppDelegate

+ (instancetype)sharedAppDelegate
{
    return (BaseAppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NetWork startWorkReachability]; //开启网络监听
    [self configAppearance];         //配置app的通用外观
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    [self configureSingle];         //配置单例
    [self configAppLaunch];         //模块入口
    [self configureBoardManager];   //配置键盘管理
    [self configureUMSocial];       //配置友盟分享
    //[self configJpushWithLaunchOptions:launchOptions];
    
    //    BOOL isAutoLogin = [IMAPlatform isAutoLogin];
    //    if (isAutoLogin)
    //    {
    //        _loginParam = [IMALoginParam loadFromLocal];
    //        //配置SDK用于登录
    //        [IMAPlatform configWith:_loginParam.config];
    //        [self loginIMSDK];
    //        [self enterMainUI];
    //    }
    //    else
    {
        // 进入登录界面
        [self enterLoginUI];
    }
    
    [_window makeKeyAndVisible];
    
    //引导页面加载
    [self setupGuidePage];
    
    //启动广告（记得放最后，才可以盖在页面上面）
    [self setupAdveriseView];
    
    return YES;
}

// 配置App中的控件的默认属性
- (void)configAppearance
{
    //[[UINavigationBar appearance] setBarTintColor:MainCol];
    
    [[UINavigationBar appearance] setTintColor:Color_NaviBar_Tint];

    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = kWhiteColor;
    shadow.shadowOffset = CGSizeMake(0, 0);
    
//    UIFont *font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    
    UIFont *font = [UIFont boldSystemFontOfSize:18.0];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:Color_NaviBar_Tint,
                                                           NSShadowAttributeName:shadow,
                                                           NSFontAttributeName:font
                                                           }];
//    [[UIScrollView appearance] setBackgroundColor:[UIColor clearColor]];
    [[UITableViewCell appearance] setBackgroundColor:[UIColor whiteColor]];
//    [[UILabel appearance] setBackgroundColor:kClearColor];
    [[UILabel appearance] setTextColor:kMainTextColor];
    
    [[UIButton appearance] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //    [[UITableViewCell appearance] setBackgroundColor:kClearColor];
    //
    //    [[UITableViewCell appearance] setTintColor:kNavBarThemeColor];
    
    //设置搜索框取消按钮的样式
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], [UINavigationBar class], nil]
     
     setTitleTextAttributes:
     
     @{
       NSForegroundColorAttributeName:Color_NaviBar_Tint,
       //       NSShadowAttributeName:shadow,
       NSFontAttributeName:[UIFont systemFontOfSize:17]
       }
     
     forState:UIControlStateNormal];
}

//配置单例
- (void)configureSingle
{
    
}

#pragma mark - 友盟
//配置友盟分享
- (void)configureUMSocial
{
    //友盟分享
    [UMSocialData setAppKey:UmengAppKey];
    //打开调试log的开关
//    [UMSocialData openLog:YES];
    //微信和朋友圈分享
    [UMSocialWechatHandler setWXAppId:WeiChatShareAPPID appSecret:WeiChatShareAPPKEY url:AppShareURL];
    //QQ和QQ空间分享
    [UMSocialQQHandler setSupportWebView:YES];//设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setQQWithAppId:QQShareAPPID appKey:QQShareAPPKEY url:AppShareURL];//设置分享到QQ空间的应用Id，和分享url 链接
    //
    // 打开新浪微博的SSO开关
    // 将在新浪微博注册的应用appkey、redirectURL替换下面参数，并在info.plist的URL Scheme中相应添加wb+appkey，如"wb3921700954"，详情请参考官方文档。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:SinaShare
                                              secret:SinaSecret
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    //[UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToSina, UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
}


#pragma mark -

- (void)configAppLaunch
{
    // 作App配置
#if kSupportNetReachablity
    [[NetworkUtility sharedNetworkUtility] startCheckWifi];
#endif
}

#pragma mark 启动广告
- (void)setupAdveriseView
{
    // TODO 请求广告接口 获取广告图片
    
    //现在了一些固定的图片url代替
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    
    [AdvertiseHelper showAdvertiserView:imageArray];
}

#pragma mark 引导页
- (void)setupGuidePage
{
    //如果是第一次打开APP，加载引导页面
    [Tools firstOpenAppBlock:^{
        NSArray *images = @[@"introductoryPage1",@"introductoryPage2",@"introductoryPage3",@"introductoryPage4"];
        [GuidePagesHelper showGuidePagesView:images];
    }];
}

#pragma mark 键盘收回管理
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.keyboardDistanceFromTextField=60;
    manager.enableAutoToolbar = NO;
}

- (void)enterLoginUI
{
    // 未提过前面的过渡界面，暂时先这样处理
    // 进入登录界面
}

- (BOOL)needRedirectConsole
{
    return NO;
}


- (void)enterMainUI
{
    
}

//- (void)applicationWillResignActive:(UIApplication *)application
//{
//    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//}
//
//- (void)applicationWillTerminate:(UIApplication *)application
//{
//
//}

// 获取当前活动的navigationcontroller
- (UINavigationController *)navigationViewController
{
    UIWindow *window = self.window;
    
    if ([window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)window.rootViewController;
    }
    else if ([window.rootViewController isKindOfClass:[UITabBarController class]])
    {
        UIViewController *selectVc = [((UITabBarController *)window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)selectVc;
        }
    }
    return nil;
}

- (UIViewController *)topViewController
{
    UINavigationController *nav = [self navigationViewController];
    return nav.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController
{
    @autoreleasepool
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [[self navigationViewController] pushViewController:viewController animated:NO];
    }
}

- (void)pushViewController:(UIViewController *)viewController withBackTitle:(NSString *)title
{
    @autoreleasepool
    {
        viewController.hidesBottomBarWhenPushed = YES;
        [[self navigationViewController] pushViewController:viewController withBackTitle:title animated:NO];
    }
}

- (UIViewController *)popViewController
{
    return [[self navigationViewController] popViewControllerAnimated:NO];
}
- (NSArray *)popToRootViewController
{
    return [[self navigationViewController] popToRootViewControllerAnimated:NO];
}

- (NSArray *)popToViewController:(UIViewController *)viewController
{
    return [[self navigationViewController] popToViewController:viewController animated:NO];
}

- (void)presentViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)())completion
{
    UIViewController *top = [self topViewController];
    
    if (vc.navigationController == nil)
    {
        NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:vc];
        [top presentViewController:nav animated:animated completion:completion];
    }
    else
    {
        [top presentViewController:vc animated:animated completion:completion];
    }
}

- (void)dismissViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)())completion
{
    if (vc.navigationController != [BaseAppDelegate sharedAppDelegate].navigationViewController)
    {
        [vc dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self popViewController];
    }
}

@end
