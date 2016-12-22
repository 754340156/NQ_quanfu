//
//  ManageClassCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class ManageClassCell,ManageClassModel;
@protocol ManageClassCellDelegate <NSObject>
/**  删除 */
- (void)ManageClassCellDelegate_clickDeleteWithCell:(ManageClassCell *)cell;
@end

@interface ManageClassCell : BaseTableViewCell
/**  代理*/
@property (nonatomic,weak) id <ManageClassCellDelegate> delegate;
/**  model */
@property(nonatomic,strong) ManageClassModel * model;
@end
