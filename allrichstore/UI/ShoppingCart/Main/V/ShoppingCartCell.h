//
//  ShoppingCartCell_Cell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShoppingCartCell.h"
@class ShoppingCartListModel;

@interface ShoppingCartCell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) ShoppingCartListModel * model;
/**  数量 */
@property(nonatomic,strong) UILabel * numberLabel;
/**  数量增加 */
@property(nonatomic,copy) void(^countAddBlock)(UIButton *sender);
/**  数量减少 */
@property(nonatomic,copy) void(^countReduceBlock)(UIButton *sender) ;
/**  选中 */
@property(nonatomic,copy) void (^selectedBlock)();
@end
