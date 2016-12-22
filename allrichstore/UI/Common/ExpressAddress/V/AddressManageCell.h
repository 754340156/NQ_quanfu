//
//  AddressManageCell.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AddressListModel.h"    //我的收货地址model

@class AddressManageCell;
@protocol AddressManageCellDelgate <NSObject>

- (void)addressManageCell:(AddressManageCell *)addressManageCell didseletedBtn:(UIButton *)btn actionType:(ActionType)actionType;
@end

@interface AddressManageCell : BaseTableViewCell

@property (nonatomic, strong) AddressListModel *model;
@property (nonatomic, assign) id<AddressManageCellDelgate> delegate;

@end
