//
//  AddressListCell.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AddressListModel.h"    //我的收货地址model

@interface AddressListCell : BaseTableViewCell

@property (nonatomic, strong) AddressListModel *model;

@end
