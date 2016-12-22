//
//  GD_StoreCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/12/12.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GoodsDetailModel.h"

@class GD_StoreCellDelegate;

@protocol GD_StoreCellDelegate <NSObject>
/**  点击进入按钮 */
- (void)GD_StoreCellDelegate_clickIntoButton:(UIButton *)intoButton;
@end

@interface GD_StoreCell : BaseTableViewCell
/**  model */
@property(nonatomic,strong) GoodsDetailStoreModel * model;
/**  代理*/
@property (nonatomic,weak) id <GD_StoreCellDelegate> delegate;
@end
