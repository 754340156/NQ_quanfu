//
//  ChooseModel.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ChooseModel.h"

@implementation ChooseModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"property" : @"ChooseModelProperty",
             @"goodimage":@"ChooseModelImage"
             };
}
@end


@implementation ChooseModelProperty

+ (NSDictionary *)objectClassInArray{
    return @{
             @"code" : @"ChooseModelPropertyDetail"
             };
}

- (NSArray *)buttonsArray
{
    __block NSMutableArray *array = [NSMutableArray array];
    [self.code enumerateObjectsUsingBlock:^(ChooseModelPropertyDetail * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:obj.gpv_propertyvalue];
    }];
    return  array;
}
@end

@implementation ChooseModelImage



@end
@implementation ChooseModelPropertyDetail



@end

