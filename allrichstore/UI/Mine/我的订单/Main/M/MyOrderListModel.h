//
//  MyOrderListModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>
#define kCell_CellHeight 120.0f
#define kHeaderH 60.0f
@class MyOrderList_GoodsModel;
@interface MyOrderListModel : BaseModel
/**  店铺名 */
@property(nonatomic,copy) NSString * shopName;
/**  店铺头像 */
@property(nonatomic,copy) NSString * shopIcon;
/**  商品状态 */
@property(nonatomic,copy) NSString * goodsStatus;
/**  footerButton数组如果不填就没有footer */
@property(nonatomic,strong) NSArray <NSString *>* buttonArray;
/**  商品数组 */
@property(nonatomic,strong) NSArray <MyOrderList_GoodsModel*>* goods;
/*************************  计算属性  ********************************/
/**  共几件商品 */
@property(nonatomic,assign) NSInteger  goodsCount;
/**  总计的价格 */
@property(nonatomic,assign) CGFloat  totalPrice;
/** cellheight */
@property(nonatomic,assign) CGFloat  cellHeight;
@end
@interface MyOrderList_GoodsModel : BaseModel
/**  商品头像 */
@property(nonatomic,copy) NSString * icon;
/**  商品名 */
@property(nonatomic,copy) NSString * title;
/**  副标题1 */
@property(nonatomic,copy) NSString * subTitle1;
/**  副标题2 */
@property(nonatomic,copy) NSString * subTitle2;
/**  价格 */
@property(nonatomic,copy) NSString * price;
/**  数量 */
@property(nonatomic,copy) NSString * count;
/**  cellheight */
@property(nonatomic,assign) CGFloat  cellHeight;

@end
