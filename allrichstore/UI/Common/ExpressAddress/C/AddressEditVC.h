//
//  AddressEditVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"
#import "AddressListModel.h"

@interface AddressEditVC : BaseVC

//地址列表的地址model
@property (nonatomic, strong) AddressListModel *addressModel;
//地址列表的地址model的副本
@property (nonatomic, strong) AddressListModel *addressModelCopy;

@end
