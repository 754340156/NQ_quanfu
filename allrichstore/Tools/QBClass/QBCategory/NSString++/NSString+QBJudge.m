//
//  NSString+QBJudge.m
//  PRJ_CreditRecruit
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import "NSString+QBJudge.h"

@implementation NSString (QBJudge)

#pragma mark - 是否是正确的手机号格式？
- (BOOL)isMobileNumber
{
    //  NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    //    NSString *regex = @"^((13[0-9])|(15[012356789])|(14[678])|(17[678])|(18[0-9])|(147)[0-9])\\d{8}$";
    NSString *regex = @"^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9])|(14[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch)
    {
        return NO;
    }
    return YES;
}

#pragma mark - 是否是正确的电话号码（手机+固话)？
- (BOOL)isTelNumber
{
    //手机号码
    NSString *regex = @"^((13[0-9])|(15[0-9])|(17[0-9])|(18[0-9])|(14[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    //固定电话
    NSString *telRegex = @"^(\\(\\d{3,4}\\)|\\d{3,4}-|\\s)?\\d{7,14}$";
    NSPredicate *telPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    
    //是否是手机号码
    BOOL isPhoneNum = [pred evaluateWithObject:self];
    //是否是固话
    BOOL isTelNum = [telPred evaluateWithObject:self];
    if (isPhoneNum || isTelNum)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - 是否是正确的邮箱格式?
- (BOOL)isEmailAddress
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark - 是否是正确的身份证号格式?
- (BOOL)isPersonIDCardNumber
{
    NSString *chatString;
    chatString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([chatString length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:chatString]) {
        return NO;
    }
    int summary = ([chatString substringWithRange:NSMakeRange(0,1)].intValue + [chatString substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([chatString substringWithRange:NSMakeRange(1,1)].intValue + [chatString substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([chatString substringWithRange:NSMakeRange(2,1)].intValue + [chatString substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([chatString substringWithRange:NSMakeRange(3,1)].intValue + [chatString substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([chatString substringWithRange:NSMakeRange(4,1)].intValue + [chatString substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([chatString substringWithRange:NSMakeRange(5,1)].intValue + [chatString substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([chatString substringWithRange:NSMakeRange(6,1)].intValue + [chatString substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [chatString substringWithRange:NSMakeRange(7,1)].intValue *1 + [chatString substringWithRange:NSMakeRange(8,1)].intValue *6
    + [chatString substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[chatString substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

#pragma mark - 是否是用户密码6-18位数字和字母组合?
- (BOOL)isPassword
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma mark - 是否是正则匹配用户姓名,20位的中文或英文？
- (BOOL)isUserName
{
    //    NSString *pattern = @"^[A-Za-z0-9]{6,20}+$";
    NSString *pattern = @"^([\u4e00-\u9fa5]+|([a-zA-Z]+\s?)+)$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

#pragma mark - 是否是正确的昵称格式？
- (BOOL)isNickName
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma mark - 是否是正确的URL字符串？
- (BOOL)isURL
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma mark - 是否是正确格式的银行卡号？
- (BOOL)isBankNumber
{
    NSString *bankNum = @"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNum];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma mark - 是否是只有字母和数字组成的字符串？
- (BOOL)isLetterNumberString
{
    NSString *matchString = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",matchString];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma mark - 是否包含中文？
- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

@end
