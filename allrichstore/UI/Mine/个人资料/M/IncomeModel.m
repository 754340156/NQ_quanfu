//
//  IncomeModel.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/12.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "IncomeModel.h"

@implementation IncomeModel

#pragma mark - <QBPickerViewAble>
- (NSString *)pickerTitle
{
    return _m_income;
}

#pragma mark - <NSCoding>
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.m_income forKey:@"m_income"];
    [aCoder encodeInt64:self.m_id forKey:@"m_id"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.m_income = [aDecoder decodeObjectForKey:@"m_income"];
        self.m_id = [aDecoder decodeInt64ForKey:@"m_id"];
    }
    
    return self;
}

@end
