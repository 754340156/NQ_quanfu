//
//  ProfessionModel.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/12.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ProfessionModel.h"     //职业model

@implementation ProfessionModel

+ (NSDictionary *)objectClassInArray {
    return @{@"list" : [ProfessionModel class]};
}

#pragma mark - <QBPickerViewAble>
- (NSString *)pickerTitle
{
    return _in_name;
}

- (NSArray *)subArray
{
    return _list;
}

#pragma mark - <NSCoding>
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.ID forKey:@"id"];
    [aCoder encodeObject:self.in_name forKey:@"in_name"];
    [aCoder encodeInt64:self.in_id forKey:@"in_id"];
    [aCoder encodeObject:self.list forKey:@"list"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.ID = [aDecoder decodeObjectForKey:@"id"];
        self.in_name = [aDecoder decodeObjectForKey:@"in_name"];
        self.in_id = [aDecoder decodeInt64ForKey:@"in_id"];
        self.list = [aDecoder decodeObjectForKey:@"list"];
    }
    return self;
}

@end
