//
//  NetWork.h
//  LiveTest
//
//  Created by 任强宾 on 16/8/16.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface NetWork : NSObject

/**
 *  @param url           请求地址字符串
 *  @param parameters    请求参数
 *  @param success       请求成功的代码块
 *  @param fail          请求失败的代码块
 */

//单纯请求
+ (AFHTTPSessionManager *)POST_:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary*dic))success fail:(void(^)(NSError*error))fail;

//耦合视图层的请求
+ (AFHTTPSessionManager *)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(NSDictionary*dic))success fail:(void(^)(NSError*error))fail sendView:(UIView *)sendView animSuperView:(UIView *)animSuperView animated:(BOOL)animated;

//启动网络监听（一般在程序启动的时候调用）
+ (void)startWorkReachability;

@end
