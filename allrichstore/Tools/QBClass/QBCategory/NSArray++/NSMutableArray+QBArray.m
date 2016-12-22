//
//  NSMutableArray+QBArray.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "NSMutableArray+QBArray.h"

@implementation NSMutableArray (QBArray)

#pragma mark - 插入操作
//插入一个字符串在最前面（如果已存在相同字符串，把原有字符串调整在最前面）
- (void)insetFirstEachString:(NSString *)string
{
    for (id obj in self)
    {
        if ([obj isKindOfClass:[NSString class]])
        {
            if ([obj isEqualToString:string])
            {
                [self removeObject:obj];
                break;
            }
        }
    }
    
    [self insertObject:string atIndex:0];
}

@end
