//
//  NSMutableArray+QBArray.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QBArray)

//插入一个字符串在最前面（如果已存在相同字符串，把原有字符串调整在最前面）
- (void)insetFirstEachString:(NSString *)string;

@end
