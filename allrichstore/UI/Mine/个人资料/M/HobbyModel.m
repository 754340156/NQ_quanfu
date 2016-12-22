//
//  HobbyModel.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "HobbyModel.h"  //爱好model

@implementation HobbyModel

+ (NSDictionary *)objectClassInArray {
    return @{@"list" : [HobbySubModel class]};
}

@end

@implementation HobbySubModel


@end
