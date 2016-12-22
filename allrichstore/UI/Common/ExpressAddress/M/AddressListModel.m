//
//  AddressListModel.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AddressListModel.h"    //我的收货地址model

@implementation AddressListModel

- (id)copyWithZone:(NSZone *)zone
{
    AddressListModel *model = [[[self class] allocWithZone:zone] init];
    model.name = self.name;
    model.tel = self.tel;
    model.addressProvince = self.addressProvince;
    model.addressCity = self.addressCity;
    model.addressDistrict = self.addressDistrict;
    model.addressDetail = self.addressDetail;
    model.isDefault = self.isDefault;
    return model;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.name = @"";
        self.tel = @"";
        self.addressProvince = @"";
        self.addressCity = @"";
        self.addressDistrict = @"";
        self.addressDetail = @"";
        self.isDefault = NO;
    }
    return self;
}

#pragma mark - getter
- (NSString *)addressPCD
{
    return [NSString stringWithFormat:@"%@%@%@", self.addressProvince, self.addressCity, self.addressDistrict];
}

//完整地址通过拼接省，市，区，详细地址得出
- (NSString *)addressText
{
    return [NSString stringWithFormat:@"%@%@%@%@", self.addressProvince, self.addressCity, self.addressDistrict, self.addressDetail];
}

@end
