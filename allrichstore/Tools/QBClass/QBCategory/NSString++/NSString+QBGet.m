//
//  NSString+QBGet.m
//  PRJ_CreditRecruit
//
//  Created by apple on 15/2/28.
//  Copyright © 2015年 河南维创盈通科技有限公司. All rights reserved.
//

#import "NSString+QBGet.h"

@implementation NSString (QBGet)

//如果字符串长度大于min, 截取min长度的字符串
- (NSString *)getSubStringNotLongThanLength:(NSInteger)length
{
    if (self.length > length)
    {
        return [self substringToIndex:length];
    }
    return self;
}

//去除一个字符串的某个字串
- (NSString *)removeString:(NSString *)string
{
    return [self stringByReplacingOccurrencesOfString:string withString:@""];
}

//将一个字符串后N位,转换为某个字符串
- (NSString *)getStringCoverLastLength:(NSInteger)length
                             newString:(NSString *)newString
{
    if (self.length > length)
    {
        NSString *frontSubString = [self substringToIndex:self.length - length];
        return [NSString stringWithFormat:@"%@%@", frontSubString, newString];
    }
    return self;
}

//将一个字符串按照某个格式进行空格
- (NSString *)getStringLikeFormatString:(NSString *)formatString
{
    NSMutableString *newstring = [NSMutableString stringWithString:[self removeString:@" "]];
    
    for (int i = 0; i < formatString.length; i++)
    {
        if (newstring.length <= i)
        {
            break;
        }
        NSString *charString = [formatString substringWithRange:NSMakeRange(i, 1)];
        if ([charString isEqualToString:@" "])
        {
            NSString *newCharString = [newstring substringWithRange:NSMakeRange(i, 1)];
            if (![newCharString isEqualToString:@" "])
            {
                [newstring insertString:@" " atIndex:i];
            }
        }
    }
    return [NSString stringWithString:newstring];
}

//时间字符串（格式yyyy-MM-dd）转时间截(秒)
- (NSTimeInterval)convertToTimeSec
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self];
    return [date timeIntervalSince1970];
}

//时间字符串（格式yyyy-MM-dd）转时间截(毫秒)
- (NSTimeInterval)convertToTimeMillSec
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:self];
    return [date timeIntervalSince1970] * 1000;
}

//将对象转成json字符串
+ (NSString *)jsonStringWithObject:(id)obj
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

//商品价格格式化
+ (NSString *)stringWithPrice:(CGFloat)price
{
    //判断一下价格是否能取整
    if (floorf(price) == price) {
        return [NSString stringWithFormat:@"¥%.0f", price];
    } else if (floorf(price * 10) == (price * 10)) {
        return [NSString stringWithFormat:@"¥%.1f", price];
    } else {
        return [NSString stringWithFormat:@"¥%.2f", price];
    }
}

//拼接model数组中的字符串
+ (NSString *)stringWithModelArray:(NSArray *)array
                          modelKey:(NSString *)key
                          spaceStr:(NSString *)spaceStr
{
    NSMutableString *muString = [NSMutableString string];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        NSString *string = [obj valueForKeyPath:key];
        [muString appendString:string];
        if (idx != (array.count - 1)) {
            [muString appendString:spaceStr];
        }
        
    }];
    return muString;
}

//时间截字符串->格式化字符串
+ (NSString *)dateStringWithSec:(NSInteger)sec
{
    NSTimeInterval time = sec;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

//时间截（毫秒）字符串->格式化字符串
+ (NSString *)dateStringWithMillSec:(NSInteger)millSec
{
    NSTimeInterval time = millSec * 0.001;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

//将一个字符串在固定的N个位置插入某个字符
- (NSString *)insetedSubString:(NSString *)subString
                  atIndexArray:(NSArray *)indexArray
{
    NSMutableString *muString = [NSMutableString stringWithString:[self removeString:@" "]];
    for (NSNumber *number in indexArray)
    {
        NSInteger index = [number integerValue];
        if (muString.length <= index)
        {
            break;
        }
        if ([[muString substringWithRange:NSMakeRange(index, 1)] isEqualToString:subString])
        {
            continue;
        }
        [muString insertString:subString atIndex:index];
    }
    return [NSString stringWithString:muString];
}
//时间戳转时间
+ (NSString *)StringDateWithDate:(NSString *)date
{
    NSTimeInterval time = [date doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate: detaildate];
}
/**  去字符串后四位（手机尾号） */
+ (NSString *)StringEndFourWithStr:(NSString *)str
{
    return [str substringFromIndex:str.length - 4];
}

/**   */
+ (NSString *)StringDicWithDic:(NSDictionary *)dic;
{
    __block NSString * str1 = [NSString string];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * str= [NSString stringWithFormat:@"'%@':'%@'",key,obj];
        if ([NSString isEmpty:str1]) {
            str1 = [NSString stringWithFormat:@"%@",str];
        }else
        {
            str1 = [NSString stringWithFormat:@"%@,%@",str1,str];
        }
       
    }];
    return [NSString stringWithFormat:@"{%@}",str1];
}

/**  数字过万处理 */
+ (NSString *)StringBreakWanHandleWithString:(NSString *)string
{
    float str = [string floatValue];
    if (str > 10000.0) {
        return  [NSString stringWithFormat:@"%.1f万",str / 10000.0];
    }
    return [NSString stringWithFormat:@"%.0f",str];
}
@end
