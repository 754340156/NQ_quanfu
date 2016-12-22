//
//  NSObject+extend.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/18.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <Foundation/Foundation.h>

/***************block定义***************/
//不带参数的block
typedef void(^EmptyBlock)();
//带一个NSString参数的block
typedef void(^StringBlock)(NSString *string);
//带一个NSArray参数的block
typedef void(^ArrayBlock)(NSArray *array);
//带一个id参数的block
typedef void(^ObjectBlock)(id object);

/***************通用枚举*****************/
//触发事件的类型
typedef NS_ENUM(NSUInteger, ActionType)
{
    ActionTypeDefault = 0,
    ActionTypeEdit,
    ActionTypeDelete,
    ActionTypeSelect
};

//级别的类型
typedef NS_ENUM(NSUInteger, LevelType)
{
    LevelTypeOne = 0,
    LevelTypeTwo,
    LevelTypeThree,
};

@interface NSObject (extend)

- (NSString *)className;

+ (NSString *)className;

@end
