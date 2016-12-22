//
//  ActivityListModel.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ActivityListModel.h"   //活动列表model

@implementation ActivityListModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"categroylist" : [ActivitySubModel class]};
}

@end

@implementation ActivitySubModel

@end
