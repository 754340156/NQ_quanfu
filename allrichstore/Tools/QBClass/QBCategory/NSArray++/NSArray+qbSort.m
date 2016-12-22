//
//  NSArray+qbSort.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "NSArray+qbSort.h"  //排序扩展

@implementation NSArray (qbSort)

//排序（正序）
- (NSMutableArray *)sortASWithKey:(NSString *)key
{
    //正序冒泡算法
    NSMutableArray *sortArray;
    if ([self isKindOfClass:[NSMutableArray class]])
    {
        sortArray = (NSMutableArray *)self;
    }
    else
    {
        sortArray = [NSMutableArray arrayWithArray:self];
    }
    
    NSInteger count = sortArray.count;
    for (int i = 0; i < count; i++)
    {
        BOOL isHaveExchange = NO;
        for (int j = i; j < count - 1; j++)
        {
            id obj = sortArray[j];
            id value = [obj valueForKeyPath:key];
            float num = [value floatValue];
            
            id nextObj = sortArray[j+1];
            id nextValue = [nextObj valueForKeyPath:key];
            float nextNum = [nextValue floatValue];
            if (num > nextNum)
            {
                [sortArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                isHaveExchange = YES;
            }
        }
        if (!isHaveExchange)
        {
            break;
        }
    }
    return sortArray;
}

//排序（倒序）
- (NSMutableArray *)sortDesWithKey:(NSString *)key
{
    //倒序冒泡算法
    NSMutableArray *sortArray;
    if ([self isKindOfClass:[NSMutableArray class]])
    {
        sortArray = (NSMutableArray *)self;
    }
    else
    {
        sortArray = [NSMutableArray arrayWithArray:self];
    }
    
    NSInteger count = sortArray.count;
    for (int i = 0; i < count; i++)
    {
        BOOL isHaveExchange = NO;
        for (int j = i; j < count - 1; j++)
        {
            id obj = sortArray[j];
            id value = [obj valueForKeyPath:key];
            float num = [value floatValue];
            
            id nextObj = sortArray[j+1];
            id nextValue = [nextObj valueForKeyPath:key];
            float nextNum = [nextValue floatValue];
            if (num < nextNum)
            {
                [sortArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                isHaveExchange = YES;
            }
        }
        if (!isHaveExchange)
        {
            break;
        }
    }
    return sortArray;
}

@end
