//
//  NSArray+QBArray.h
//  PRJ_CreditRecruit
//
//  Created by apple on 16/4/21.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (QBArray)

//包含某个字符串
- (BOOL)isHaveString:(NSString *)string;
//将model数组转换成其属性的数组
- (NSArray *)valueArrayWithKey:(NSString *)key;

@end
