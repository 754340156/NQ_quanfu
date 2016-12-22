//
//  AddressModel.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/9/28.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

+ (NSDictionary *)objectClassInArray{
    return @{@"provinces" : [Province class]};
}

//绑定默认值 省名 市名 区名
+ (void)getAddressFromProvinceName:(NSString *)provinceName cityName:(NSString *)cityName regionName:(NSString *)regionName block:(AdressBlock)block
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"address.json" ofType:nil];
    
    NSString *jsonString = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    
    AddressModel *addressModel = [AddressModel mj_objectWithKeyValues:jsonString];
    
    Province *province = addressModel.provinces[0];
    City *city = province.citys[0];
    Region *region = city.regions[0];
    
    //省份
    BOOL isHaveProvince = NO;
    for (int i = 0; i < addressModel.provinces.count; i++)
    {
        Province *currentProvince = addressModel.provinces[i];
        if ([provinceName isEqualToString:currentProvince.name])
        {
            province = currentProvince;
            isHaveProvince = YES;
            break;
        }
    }
    
    if (isHaveProvince)
    {
        // 市
        BOOL isHaveCity = NO;
        for (int j = 0; j < province.citys.count; j++)
        {
            City *currentCity = province.citys[j];
            if ([cityName isEqualToString:currentCity.name])
            {
                city = currentCity;
                isHaveCity = YES;
                break;
            }
        }
        
        if (isHaveCity)
        {
            // 区
            for (int k = 0; k < city.regions.count ; k++)
            {
                Region *currentRegion = city.regions[k];
                if ([regionName isEqualToString:currentRegion.name])
                {
                    region = currentRegion;
                    break;
                }
            }
        }
    }
    
    if (block)
    {
        block(province, city, region);
    }
}

//绑定默认值 省码 市码 区码
+ (void)getAddressFromProvinceCode:(NSString *)provinceCode cityCode:(NSString *)cityCode regionCode:(NSString *)regionCode block:(AdressBlock)block
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"address.json" ofType:nil];
    
    NSString *jsonString = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    
    AddressModel *addressModel = [AddressModel mj_objectWithKeyValues:jsonString];
    
    Province *province = addressModel.provinces[0];
    City *city = province.citys[0];
    Region *region = city.regions[0];
    
    //省份
    BOOL isHaveProvince = NO;
    for (int i = 0; i < addressModel.provinces.count; i++)
    {
        Province *currentProvince = addressModel.provinces[i];
        if ([provinceCode isEqualToString:currentProvince.code])
        {
            province = currentProvince;
            isHaveProvince = YES;
            break;
        }
    }
    
    if (isHaveProvince)
    {
        // 市
        BOOL isHaveCity = NO;
        for (int j = 0; j < province.citys.count; j++)
        {
            City *currentCity = province.citys[j];
            if ([cityCode isEqualToString:currentCity.code])
            {
                city = currentCity;
                isHaveCity = YES;
                break;
            }
        }
        
        if (isHaveCity)
        {
            // 区
            for (int k = 0; k < city.regions.count ; k++)
            {
                Region *currentRegion = city.regions[k];
                if ([regionCode isEqualToString:currentRegion.code])
                {
                    region = currentRegion;
                    break;
                }
            }
        }
    }
    
    if (block)
    {
        block(province, city, region);
    }
}

@end

@implementation Province

+ (NSDictionary *)objectClassInArray{
    return @{@"citys" : [City class]};
}

@end


@implementation City

+ (NSDictionary *)objectClassInArray{
    return @{@"regions" : [Region class]};
}

@end


@implementation Region

@end


