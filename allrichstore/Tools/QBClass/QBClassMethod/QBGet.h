//
//  QBGet.h
//  RQBClass
//
//  Created by apple on 15/1/12.
//  Copyright © 2015年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBGet : NSObject

//获取当前系统: 版本号
+ (double)getCurrentIOS;

//获取数据里面的字符串, 按顺序拼接后返回
+ (NSString *)getMergeStringByStringArray:(NSArray *)array;

//获取一个字符串的所有子串, 返回字串数组
+ (NSArray *)getSubStringsArrayByString:(NSString *)string;

//出除一个数组的子数组相同的字符串元素
+ (NSArray *)getNotRepeatSubArrayByArray:(NSArray *)array
                          notRepeatArray:(NSArray *)notRepeatArray;

//通过日期 获取生肖 
+ (NSString *)getPropertyByDate:(NSDate *)date;

//将CGFloat基本数据类型 --> 转换为的字符串(去小数点)
+ (NSString *)getStringByFloatCutDecimal:(CGFloat)floatNum;

//将CGFloat基本数据类型 --> 转换为的NSInteger
+ (NSInteger)getIntegerByFloatCutDecimal:(CGFloat)floatNum;

//将CGFloat基本数据类型 --> 转换为的去小数点的CGFloat
+ (CGFloat)getIntFloatByFloatCutDecimal:(CGFloat)floatNum;

//获取一个小数的整数(4舍5入)
+ (NSInteger)getIntegerByDoubel:(CGFloat)floatNum;

//获取一个小数的(4舍5入)后去与整数相等的小数
+ (CGFloat)getIntFloatByFloat:(CGFloat)floatNum;



@end
