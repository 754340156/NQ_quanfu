//
//  MyCollection_GoodsCell.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseTableViewCell.h"
@class MyCollection_GoodsModel;
@protocol MyCollection_GoodsCellDelegate <NSObject>

- (void)MyCollection_GoodsCellDelegate_clickIntoCartBtn;

@end

@interface MyCollection_GoodsCell : BaseTableViewCell
/**  代理*/
@property (nonatomic,weak) id <MyCollection_GoodsCellDelegate> delegate;
/**  model */
@property(nonatomic,strong) MyCollection_GoodsModel * model;
@end
