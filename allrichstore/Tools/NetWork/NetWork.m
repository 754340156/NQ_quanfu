//
//  NetWork.m
//  LiveTest
//
//  Created by 任强宾 on 16/8/16.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "NetWork.h"

//加载视图样式（0：MBProgress样式，1：ActivityIndicatorView样式）
#define LoadingStyle_isAIV      1

//网络请求超时时间
#define NetworkTimeoutInterval  10.0

#define ErrorCode_emptyUrl      1000    //请求地址为空
#define ErrorCode_netError      1001    //网络请求错误


#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#define LogSuccess(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

#define LogError(frmt, ...)   NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

static AFNetworkReachabilityStatus  networkReachabilityStatus;

@implementation NetWork

/**
 *  @param url           请求地址字符串
 *  @param parameters    请求参数
 *  @param success       请求成功的代码块
 *  @param fail          请求失败的代码块
 */

//单纯请求
+ (AFHTTPSessionManager *)POST_:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary*dic))success fail:(void(^)(NSError*error))fail
{
    if (!url || !url.length)
    {
        NSError *error = [NSError errorWithDomain:@"暂不能访问" code:ErrorCode_emptyUrl userInfo:nil];;
        fail(error);
        return nil;
    }
    
    if (networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
    {
        NSError *err = [NSError errorWithDomain:@"无网络" code:ErrorCode_netError userInfo:nil];
        fail(err);
        return nil;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = NetworkTimeoutInterval;
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    NSMutableDictionary *parametersDic =  [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([ReadForLocation(kUserToken) length] != 0)
    {
        [parametersDic setObject:ReadForLocation(kUserToken) forKey:@"token"];
    }
    [parametersDic setObject:@(2) forKey:@"deviceType"];
    
    [manager POST:url parameters:parametersDic progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        LogSuccess(@"\nURL: %@\n\nparams:%@\n\n\njsonString:%@\n\n", url, parametersDic, responseString);  //打印出请求到的字符串
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(dictionary);
        
    } failure:^(NSURLSessionDataTask * task, NSError *error)
    {
        LogError(@"%@",error);  //打印出错误信息
        fail(error);
    }];
    
    return manager;
}

//耦合视图层的请求
+ (AFHTTPSessionManager *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary*dic))success fail:(void(^)(NSError*error))fail sendView:(UIView *)sendView animSuperView:(UIView *)animSuperView animated:(BOOL)animated
{
    if (!url || !url.length)
    {
        NSError *error = [NSError errorWithDomain:@"暂不能访问" code:ErrorCode_emptyUrl userInfo:nil];;
        fail(error);
        return nil;
    }
    
    UIWindow *window = [BaseAppDelegate sharedAppDelegate].window;
    
    animSuperView = animSuperView ? animSuperView : window;
    
    if (networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable)
    {
        NSError *err = [NSError errorWithDomain:@"无网络" code:ErrorCode_netError userInfo:nil];
        fail(err);
        return nil;
    }
    
    //关闭事件发送者的响应事件
    sendView.userInteractionEnabled = NO;
    
    if (animated)
    {
#if LoadingStyle_isAIV
        [animSuperView showLoadingView];
#else
        hud  = [MBProgressHUD showHUDAddedTo:animSuperView ? animSuperView : [[UIApplication sharedApplication] keyWindow] animated:animated];
#endif
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = NetworkTimeoutInterval;
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if ([ReadForLocation(kUserToken) length] != 0)
    {
        [parametersDic setObject:ReadForLocation(kUserToken) forKey:@"token"];
    }
    [parametersDic setObject:@(2) forKey:@"deviceType"];
    
    [manager POST:url parameters:parametersDic progress:nil success:^(NSURLSessionDataTask * task, id responseObject)
     {
         sendView.userInteractionEnabled = YES;
#if LoadingStyle_isAIV
         [animSuperView dismissLoadingView];
#else
         [hud hide:YES];
#endif
         NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         //打印出请求到的字符串
         LogSuccess(@"\nURL: %@\n\nparams:%@\n\n\njsonString:%@\n\n",url,parametersDic,responseString);
         
         int num = [dictionary[@"code"] intValue];
         if (num == 12)
         {
             [window showToastMsg:@"您的账号在另一台手机上登录，请重新登录！" time:2.0];
             return;
         }
         
         success(dictionary);
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
#if LoadingStyle_isAIV
         [animSuperView dismissLoadingView];
#else
         [hud hide:YES];
#endif

         [animSuperView showToastMsg:@"连接失败"];
         LogError(@"%@",error); //打印出错误信息
         fail(error);
         sendView.userInteractionEnabled = YES;
     }];
    return manager;
}

//启动网络监听（一般在程序启动的时候调用）
+ (void)startWorkReachability
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    networkReachabilityStatus = AFNetworkReachabilityStatusUnknown;
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        networkReachabilityStatus = status;
    }];
    // 3.开始监控
    [mgr startMonitoring];
}

@end
