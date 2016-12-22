//
//  AddressListVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"

@interface AddressListVC : BaseVC

//把选中的地址model通过block返回
- (instancetype)initWithBlock:(ObjectBlock)addressBlock;

@end
