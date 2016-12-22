//
//  AddressModel.h
//  MeiYiQuan
//
//  Created by 任强宾 on 16/9/28.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Province, City, Region;

typedef  void(^AdressBlock)(Province *province, City *city, Region *region);

@interface AddressModel : NSObject

@property (nonatomic, strong) NSArray<Province *> *provinces;

//绑定默认值 省名 市名 区名
+ (void)getAddressFromProvinceName:(NSString *)provinceName cityName:(NSString *)cityName regionName:(NSString *)regionName block:(AdressBlock)block;

//绑定默认值 省码 市码 区码
+ (void)getAddressFromProvinceCode:(NSString *)provinceCode cityCode:(NSString *)cityCode regionCode:(NSString *)regionCode block:(AdressBlock)block;

@end

@interface Province : NSObject

@property (nonatomic, strong) NSArray<City *> *citys;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;

@end

@interface City : NSObject

@property (nonatomic, strong) NSArray<Region *> *regions;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;

@end

@interface Region : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;

@end

