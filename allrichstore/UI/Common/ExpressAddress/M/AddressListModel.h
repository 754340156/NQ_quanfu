//
//  AddressListModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

@interface AddressListModel : BaseModel<NSCopying>

//收货人姓名
@property (nonatomic, copy) NSString *name;
//收货人电话
@property (nonatomic, copy) NSString *tel;
//省市区拼接的地址
@property (nonatomic, copy) NSString *addressPCD;
//完整地址
@property (nonatomic, copy) NSString *addressText;
//收货地址一级
@property (nonatomic, copy) NSString *addressProvince;
//收货地址二级
@property (nonatomic, copy) NSString *addressCity;
//收货地址三级
@property (nonatomic, copy) NSString *addressDistrict;
//详细地址
@property (nonatomic, copy) NSString *addressDetail;
//是否是默认地址
@property (nonatomic, assign) BOOL isDefault;

@end
