//
//  ThreeClassCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class  ThreeClassModel;
@interface ThreeClassCell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) ThreeClassModel * model;
/**  block */
@property (nonatomic,copy) void(^clickSelected)(BOOL isSelected);
@end
