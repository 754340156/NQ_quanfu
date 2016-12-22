//
//  QBJugleManger.h
//  RQBClass
//
//  Created by apple on 15/1/12.
//  Copyright © 2015年 任强宾. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
	本类用于判断
 */

@interface QBJugleManger : NSObject

//判断输入框中得文本是否为手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

//判断字符串是否为邮箱
+ (BOOL)isEmailAddress:(NSString *)address;

//判断字符串是否为身份证号
+ (BOOL)isPersonIDCardNumber:(NSString *)personID;

//判断字符串是否是只能精确到小数点后两位, 且不超过999999.99
+ (BOOL)isFloatPrice:(NSString *)priceStr;

//判断字符串是否与数组中的第几个元素相等，不相等返回999
+ (NSInteger )string:(NSString *)string haveEqualByArray:(NSArray *)array;

//判断手机是否处于静音模式
+ (BOOL)silenced;

#pragma mark - 系统权限
//检测相册权限
+ (BOOL)checkPhotoLibraryAuthorizationStatus;

//检测拍照权限
+ (BOOL)checkCameraAuthorizationStatus;

//检测麦克风权限，仅支持iOS7.0以上系统
+ (BOOL)checkMicAuthorizationStatus;

@end
