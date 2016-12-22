//
//  NSArray+qbSort.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (qbSort)

//排序（正序）
- (NSMutableArray *)sortASWithKey:(NSString *)key;
//排序（倒序）
- (NSMutableArray *)sortDesWithKey:(NSString *)key;

@end
