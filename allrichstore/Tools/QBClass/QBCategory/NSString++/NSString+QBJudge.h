//
//  NSString+QBJudge.h
//  PRJ_CreditRecruit
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QBJudge)

#pragma mark - 是否是正确的手机号格式？
- (BOOL)isMobileNumber;

#pragma mark - 是否是正确的电话号码（手机+固话)？
- (BOOL)isTelNumber;

#pragma mark - 是否是正确的邮箱格式?
- (BOOL)isEmailAddress;

#pragma mark - 是否是正确的身份证号格式?
- (BOOL)isPersonIDCardNumber;

#pragma mark - 是否是用户密码6-18位数字和字母组合?
- (BOOL)isPassword;

#pragma mark - 是否是正则匹配用户姓名,20位的中文或英文？
- (BOOL)isUserName;

#pragma mark - 是否是正确的昵称格式？
- (BOOL)isNickName;

#pragma mark - 是否是正确的URL字符串？
- (BOOL)isURL;

#pragma mark - 是否是正确格式的银行卡号？
- (BOOL)isBankNumber;

#pragma mark - 是否是只有字母和数字组成的字符串？
- (BOOL)isLetterNumberString;

#pragma mark - 是否包含中文？
- (BOOL)isChinese;

@end
