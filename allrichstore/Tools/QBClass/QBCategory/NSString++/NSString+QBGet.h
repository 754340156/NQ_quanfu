//
//  NSString+QBGet.h
//  PRJ_CreditRecruit
//
//  Created by apple on 15/2/28.
//  Copyright © 2015年 河南维创盈通科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QBGet)

//如果字符串长度大于min, 截取min长度的字符串
- (NSString *)getSubStringNotLongThanLength:(NSInteger)length;

//去除一个字符串的某个字串
- (NSString *)removeString:(NSString *)string;

//将一个字符串后N位,转换为某个字符串
- (NSString *)getStringCoverLastLength:(NSInteger)length
                             newString:(NSString *)newString;

//将一个字符串按照某个格式进行空格
- (NSString *)getStringLikeFormatString:(NSString *)formatString;

//将一个字符串在固定的N个位置插入某个字符
- (NSString *)insetedSubString:(NSString *)subString
           atIndexArray:(NSArray *)indexArray;

//时间字符串（格式yyyy-MM-dd）转时间截(秒)
- (NSTimeInterval)convertToTimeSec;

//时间字符串（格式yyyy-MM-dd）转时间截(毫秒)
- (NSTimeInterval)convertToTimeMillSec;

//将对象转成json字符串
+ (NSString *)jsonStringWithObject:(id)obj;

//商品价格格式化
+ (NSString *)stringWithPrice:(CGFloat)price;

//拼接model数组中的字符串
+ (NSString *)stringWithModelArray:(NSArray *)array
                          modelKey:(NSString *)key
                          spaceStr:(NSString *)spaceStr;

//时间截（秒）字符串->格式化字符串
+ (NSString *)dateStringWithSec:(NSInteger)sec;

//时间截（毫秒）字符串->格式化字符串
+ (NSString *)dateStringWithMillSec:(NSInteger)millSec;

#pragma mark -
/**  时间戳转时间(转成xxxx-xx-xx) */
+ (NSString *)StringDateWithDate:(NSString *)date;

/**  去字符串后四位（手机尾号） */
+ (NSString *)StringEndFourWithStr:(NSString *)str;

/**  把字典转成字符串形式 */
+ (NSString *)StringDicWithDic:(NSDictionary *)dic;

/**  数字过万处理 */
+ (NSString *)StringBreakWanHandleWithString:(NSString *)string;
@end
