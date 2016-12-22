//
//  NSDateFormatter+QBGet.m
//  PRJ_CreditRecruit
//
//  Created by apple on 15/6/29.
//  Copyright © 2015年 河南维创盈通科技有限公司. All rights reserved.
//

#import "NSDateFormatter+QBGet.h"

@implementation NSDateFormatter (Category)

+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
