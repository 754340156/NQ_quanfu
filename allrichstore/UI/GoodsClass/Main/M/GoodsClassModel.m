//
//  GoodsClassModel.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/30.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsClassModel.h"

//分类model
@implementation GoodsClassModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.cName forKey:@"cName"];
    [aCoder encodeObject:self.cImgUrl forKey:@"cImgUrl"];
    [aCoder encodeObject:[NSNumber numberWithLong:self.id] forKey:@"id"];
    [aCoder encodeObject:[NSNumber numberWithLong:self.cPid] forKey:@"cPid"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.cName = [aDecoder decodeObjectForKey:@"cName"];
        self.cImgUrl = [aDecoder decodeObjectForKey:@"cImgUrl"];
        
        NSNumber *id = [aDecoder decodeObjectForKey:@"id"];
        self.id = id.longValue;
        NSNumber *cPid = [aDecoder decodeObjectForKey:@"cPid"];
        self.cPid = cPid.longValue;
    }
    return self;
}

#pragma mark - <TabMenuModelAble>
- (NSString *)qbTitle
{
    return self.cName;
}

@end
