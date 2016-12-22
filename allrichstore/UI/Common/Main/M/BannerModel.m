//
//  BannerModel.m
//  LiveTest
//
//  Created by 任强宾 on 16/8/29.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "BannerModel.h"                 //banner列表的model
@implementation BannerModel

#pragma mark - <SDCycleModelAble>
//轮播图标题
- (NSString *)cycleTitle {
    return _bName;
}

//轮播图的展示图片url
- (NSString *)cycleImgUrl {
    return _bImgurl;
}

//轮播图跳转url
- (NSString *)cycleJumpUrl {
//    return _bUrl;
    return @"http://baidu.com";
}

#pragma mark - <NSCoding>
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.bImgurl forKey:@"bImgurl"];
    [aCoder encodeObject:self.bName forKey:@"bName"];
    [aCoder encodeObject:self.bUrl forKey:@"bUrl"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.bImgurl = [aDecoder decodeObjectForKey:@"bImgurl"];
        self.bName = [aDecoder decodeObjectForKey:@"bName"];
        self.bUrl = [aDecoder decodeObjectForKey:@"bUrl"];
    }
    
    return self;
}

@end
