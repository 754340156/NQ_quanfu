//
//  ShoppingCartCell_HeaderView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShoppingCartModel;
@interface ShoppingCartHeaderView : UITableViewHeaderFooterView
/**  model */
@property(nonatomic,strong) ShoppingCartModel * model;
/**  点击头部选中按钮block */
@property(nonatomic,copy) void (^headerClickBlock)();
@end
