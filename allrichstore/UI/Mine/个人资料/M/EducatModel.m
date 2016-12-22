//
//  EducatModel.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/12.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "EducatModel.h" //教育程度model

@implementation EducatModel

#pragma mark - <QBPickerViewAble>
- (NSString *)pickerTitle
{
    return _e_name;
}

#pragma mark - <NSCoding>
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.e_name forKey:@"e_name"];
    [aCoder encodeInt64:self.e_id forKey:@"e_id"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.e_name = [aDecoder decodeObjectForKey:@"e_name"];
        self.e_id = [aDecoder decodeInt64ForKey:@"e_id"];
    }
    
    return self;
}

@end
