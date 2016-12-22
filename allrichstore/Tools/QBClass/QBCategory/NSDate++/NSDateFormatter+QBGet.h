//
//  NSDateFormatter+QBGet.h
//  PRJ_CreditRecruit
//
//  Created by apple on 15/6/29.
//  Copyright © 2015年 河南维创盈通科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (Category)

+ (id)dateFormatter;
+ (id)dateFormatterWithFormat:(NSString *)dateFormat;

+ (id)defaultDateFormatter;/*yyyy-MM-dd HH:mm:ss*/

@end
