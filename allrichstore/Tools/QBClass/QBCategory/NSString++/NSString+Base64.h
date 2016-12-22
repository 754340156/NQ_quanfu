//
//  NSString+Base64.h
//  LiveTest
//
//  Created by 任强宾 on 16/8/1.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)

/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;

@end
