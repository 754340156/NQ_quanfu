//
//  QBGet.m
//  RQBClass
//
//  Created by apple on 15/1/12.
//  Copyright © 2015年 任强宾. All rights reserved.
//

#import "QBGet.h"

@implementation QBGet

//获取当前系统: 版本号
+ (double)getCurrentIOS
{
    
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}

//获取数据里面的字符串, 按顺序拼接后返回
+ (NSString *)getMergeStringByStringArray:(NSArray *)array
{
    NSMutableString *muString = [NSMutableString string];
    for (NSString *tempStr in array)
    {
        if ([tempStr isEqualToString:[array lastObject]])
        {
            [muString appendString:tempStr];
        }
        else
        {
            [muString appendString:[NSString stringWithFormat:@"%@ ", tempStr]];
        }
    }
    return [NSString stringWithString:muString];
}

//获取一个字符串的所有字串, 返回字串数组
+ (NSArray *)getSubStringsArrayByString:(NSString *)string
{
    NSMutableArray *muArray = [NSMutableArray array];
    muArray = [NSMutableArray arrayWithArray:[string componentsSeparatedByString:@" "]];
    if (muArray.count == 1)
    {
        [muArray removeObject:[muArray lastObject]];
    }
    return [NSArray arrayWithArray:muArray];
}

//出除一个数组的子数组相同的字符串元素
+ (NSArray *)getNotRepeatSubArrayByArray:(NSArray *)array
                          notRepeatArray:(NSArray *)notRepeatArray
{
    NSMutableArray *muArray = [NSMutableArray array];
    for (NSString *tempString in array)
    {
        BOOL repeat = NO;
        for (NSString *tempStr in notRepeatArray)
        {
            if ([tempString isEqualToString:tempStr])
            {
                repeat = YES;
            }
        }
        if (!repeat)
        {
            [muArray addObject:tempString];
        }
    }
    return [NSArray arrayWithArray:muArray];
}

//通过日期 获取生肖
+ (NSString *)getPropertyByDate:(NSDate *)date{
    //计算
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy"];
    
    NSString *theYear = [dateFormat stringFromDate:date];
    
    int yearInt = [theYear intValue];
    switch ((yearInt - 1900) % 12)
    {
        case 0:
            return @"鼠";
            break;
        case 1:
            return @"牛";
            break;
        case 2:
            return @"虎";
            break;
        case 3:
            return @"兔";
            break;
        case 4:
            return @"龙";
            break;
        case 5:
            return @"蛇";
            break;
        case 6:
            return @"马";
            break;
        case 7:
            return @"羊";
            break;
        case 8:
            return @"猴";
            break;
        case 9:
            return @"鸡";
            break;
        case 10:
            return @"狗";
            break;
        case 11:
            return @"猪";
            break;
        default:
            return @"";
            break;
    }
}

//获取CGFloat基本数据类型的字符串
+ (NSString *)getStringByFloatCutDecimal:(CGFloat)floatNum
{
    NSString *floatString = [NSString stringWithFormat:@"%f", floatNum];
    NSInteger interger = [floatString integerValue];
    return [NSString stringWithFormat:@"%ld", (long)interger];
}

//将CGFloat基本数据类型 --> 转换为的NSInteger
+ (NSInteger)getIntegerByFloatCutDecimal:(CGFloat)floatNum
{
    NSString *floatString = [NSString stringWithFormat:@"%f", floatNum];
    return [floatString integerValue];
}

//将CGFloat基本数据类型 --> 转换为的去小数点的CGFloat
+ (CGFloat)getIntFloatByFloatCutDecimal:(CGFloat)floatNum
{
    NSString *floatString = [NSString stringWithFormat:@"%f", floatNum];
    return [@([floatString integerValue]) floatValue];
}

//获取一个小数的整数(4舍5入)
+ (NSInteger)getIntegerByDoubel:(CGFloat)floatNum
{
    NSNumber *number = @(floatNum);
    if ((floatNum - [number integerValue]) >= 0.5)
    {
        return [number integerValue] + 1;
    }
    else
    {
        return [number integerValue];
    }
}

//获取一个小数的(4舍5入)后去与整数相等的小数
+ (CGFloat)getIntFloatByFloat:(CGFloat)floatNum
{
    NSNumber *number = @(floatNum);
    NSInteger integer = [number integerValue];
    if ((floatNum - integer) >= 0.5)
    {
        return [@(integer + 1) floatValue];
    }
    else
    {
        return [@(integer) floatValue];
    }
}

@end
