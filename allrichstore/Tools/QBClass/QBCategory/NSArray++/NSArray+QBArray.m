//
//  NSArray+QBArray.m
//  PRJ_CreditRecruit
//
//  Created by apple on 16/4/21.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import "NSArray+QBArray.h"

@implementation NSArray (QBArray)

#pragma mark - 判断
//包含某个字符串
- (BOOL)isHaveString:(NSString *)string
{
    for (id obj in self)
    {
        if ([obj isKindOfClass:[NSString class]])
        {
            if ([obj isEqualToString:string])
            {
                return YES;
            }
        }
    }
    return NO;
}

//将model数组转换成其属性的数组
- (NSArray *)valueArrayWithKey:(NSString *)key
{
    NSMutableArray *muArray = [NSMutableArray array];
    for (int i = 0; i < self.count; i++)
    {
        NSObject *obj = self[i];
        id value = [obj valueForKeyPath:key];
        [muArray addObject:value];
    }
    return  muArray;
}

@end
