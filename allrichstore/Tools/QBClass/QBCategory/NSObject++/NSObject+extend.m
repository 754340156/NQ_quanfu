//
//  NSObject+extend.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/18.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "NSObject+extend.h"

@implementation NSObject (extend)

- (NSString *)className
{
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

+ (NSString *)className
{
    return NSStringFromClass(self);
}

@end
