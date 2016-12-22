//
//  UserModel.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/7.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

#pragma mark - <NSCoding>
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if (self.ID) {
        [aCoder encodeObject:self.ID forKey:@"ID"];
    }
    if (self.uRealname) {
        [aCoder encodeObject:self.uRealname forKey:@"uRealname"];
    }
    if (self.uNickname) {
        [aCoder encodeObject:self.uNickname forKey:@"uNickname"];
    }
    if (self.uSername) {
        [aCoder encodeObject:self.uSername forKey:@"uSername"];
    }
    if (self.uPassword) {
        [aCoder encodeObject:self.uPassword forKey:@"uPassword"];
    }
    if (self.uSex) {
        [aCoder encodeObject:self.uSex forKey:@"uSex"];
    }
    if (self.uHeadimage) {
        [aCoder encodeObject:self.uHeadimage forKey:@"uHeadimage"];
    }
    if (self.uIdcard) {
        [aCoder encodeObject:self.uIdcard forKey:@"uIdcard"];
    }
    if (self.uPhone) {
        [aCoder encodeObject:self.uPhone forKey:@"uPhone"];
    }
    if (self.uEmail) {
        [aCoder encodeObject:self.uEmail forKey:@"uEmail"];
    }
    if (self.uExperience) {
        [aCoder encodeObject:self.uExperience forKey:@"uExperience"];
    }
    if (self.uLevelId) {
        [aCoder encodeObject:self.uLevelId forKey:@"uLevelId"];
    }
    if (self.uIntegral) {
        [aCoder encodeObject:self.uIntegral forKey:@"uIntegral"];
    }
    if (self.uQq) {
        [aCoder encodeObject:self.uQq forKey:@"uQq"];
    }
    if (self.uWechat) {
        [aCoder encodeObject:self.uWechat forKey:@"uWechat"];
    }
    if (self.uAge) {
        [aCoder encodeObject:self.uAge forKey:@"uAge"];
    }
    if (self.uMarriage) {
        [aCoder encodeObject:self.uMarriage forKey:@"uMarriage"];
    }
    if (self.uBirthday) {
        [aCoder encodeObject:self.uBirthday forKey:@"uBirthday"];
    }
    if (self.uMoney) {
        [aCoder encodeObject:self.uMoney forKey:@"uMoney"];
    }
    if (self.uMonthpay) {
        [aCoder encodeObject:self.uMonthpay forKey:@"uMonthpay"];
    }
    if (self.uEducation) {
        [aCoder encodeObject:self.uEducation forKey:@"uEducation"];
    }
    if (self.uProfession) {
        [aCoder encodeObject:self.uProfession forKey:@"uProfession"];
    }
    if (self.uAddressId) {
        [aCoder encodeObject:self.uAddressId forKey:@"uAddressId"];
    }
    if (self.uStatus) {
        [aCoder encodeObject:self.uStatus forKey:@"uStatus"];
    }
    if (self.uCreatetime) {
        [aCoder encodeObject:self.uCreatetime forKey:@"uCreatetime"];
    }
    if (self.uHxid) {
        [aCoder encodeObject:self.uHxid forKey:@"uHxid"];
    }
    if (self.uJgid) {
        [aCoder encodeObject:self.uJgid forKey:@"uJgid"];
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.ID = [aDecoder decodeObjectForKey:@"ID"] ;
        self.uRealname = [aDecoder decodeObjectForKey:@"uRealname"];
        self.uNickname = [aDecoder decodeObjectForKey:@"uNickname"];
        self.uSername = [aDecoder decodeObjectForKey:@"uSername"];
        self.uPassword = [aDecoder decodeObjectForKey:@"uPassword"];
        self.uSex = [aDecoder decodeObjectForKey:@"uSex"];
        self.uHeadimage = [aDecoder decodeObjectForKey:@"uHeadimage"];
        self.uIdcard = [aDecoder decodeObjectForKey:@"uIdcard"];
        self.uPhone = [aDecoder decodeObjectForKey:@"uPhone"];
        self.uEmail = [aDecoder decodeObjectForKey:@"uEmail"];
        self.uExperience = [aDecoder decodeObjectForKey:@"uExperience"];
        self.uLevelId = [aDecoder decodeObjectForKey:@"uLevelId"];
        self.uIntegral = [aDecoder decodeObjectForKey:@"uIntegral"];
        self.uQq = [aDecoder decodeObjectForKey:@"uQq"];
        self.uWechat = [aDecoder decodeObjectForKey:@"uWechat"];
        self.uAge = [aDecoder decodeObjectForKey:@"uAge"];
        self.uMarriage = [aDecoder decodeObjectForKey:@"uMarriage"];
        self.uBirthday = [aDecoder decodeObjectForKey:@"uBirthday"];
        self.uMoney = [aDecoder decodeObjectForKey:@"uMoney"];
        self.uMonthpay = [aDecoder decodeObjectForKey:@"uMonthpay"];
        self.uEducation = [aDecoder decodeObjectForKey:@"uEducation"];
        self.uProfession = [aDecoder decodeObjectForKey:@"uProfession"];
        self.uAddressId = [aDecoder decodeObjectForKey:@"uAddressId"];
//        self.u_coupon_id = [aDecoder decodeObjectForKey:@"u_coupon_id"];
        self.uStatus = [aDecoder decodeObjectForKey:@"uStatus"];
        self.uCreatetime = [aDecoder decodeObjectForKey:@"uCreatetime"];
        self.uHxid = [aDecoder decodeObjectForKey:@"uHxid"];
        self.uJgid = [aDecoder decodeObjectForKey:@"uJgid"];

    }
    return self;
}

#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone
{
    UserModel *model = [[[self class] allocWithZone:zone] init];
    model.ID = self.ID;
    model.uRealname = self.uRealname;
    model.uNickname = self.uNickname;
    model.uSername = self.uSername;
    model.uPassword = self.uPassword;
    model.uSex = self.uSex;
    model.uHeadimage = self.uHeadimage;
    model.uIdcard = self.uIdcard;
    model.uEmail = self.uEmail;
    model.uExperience = self.uExperience;
    model.uLevelId = self.uLevelId;
    model.uIntegral = self.uIntegral;
    model.uQq = self.uQq;
    model.uWechat = self.uWechat;
    model.uAge = self.uAge;
    model.uMarriage = self.uMarriage;
    model.uBirthday = self.uBirthday;
    model.uMoney = self.uMoney;
    model.uMonthpay = self.uMonthpay;
    model.uEducation = self.uEducation;
    model.uProfession = self.uProfession;
    model.uAddressId = self.uAddressId;
    model.uStatus = self.uStatus;
    model.uHxid = self.uHxid;
    model.uJgid = self.uJgid;
    return model;
}

@end
