//
//  Pay_CheckDeskCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class Pay_CheckDeskModel;

@interface Pay_CheckDeskCell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) Pay_CheckDeskModel * model;
/**  block */
@property(nonatomic,copy) void(^clickSelectedBtnBlock)();
@end
