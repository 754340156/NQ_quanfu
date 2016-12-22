//
//  MyOrderListCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class MyOrderListModel;

@protocol MyOrderListCellDelegate <NSObject>
/**  点击下面的按钮 */
- (void)MyOrderListCellDelegate_clickWithButton:(UIButton *)sender;
/**  点击cell */
- (void)MyOrderListCellDelegate_clickCellWithModel:(MyOrderListModel *)model;
@end

@interface MyOrderListCell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) MyOrderListModel * model;
/**  代理*/
@property (nonatomic,weak) id <MyOrderListCellDelegate> delegate;
@end
