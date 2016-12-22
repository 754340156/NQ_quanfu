//
//  ShoppingCartModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"
#define kCellHeight 120.0f
#define kHeaderH 45.0f
typedef NS_ENUM(NSInteger, HeadClickState) {
    HeadClickStateNormal,
    HeadClickStateSelected
};
typedef NS_ENUM(NSInteger, CellClickState) {
    CellClickStateNormal,
    CellClickStateSelected
};
@class ShoppingCartListModel;
@interface ShoppingCartModel : BaseModel
/**  店铺名 */
@property(nonatomic,copy) NSString * shopName;
/**  头部选中状态 */
@property (nonatomic,assign) BOOL isHeadSelected;
/**  商品数组 */
@property(nonatomic,strong) NSArray <ShoppingCartListModel*>* goods;
- (void)resetHeadClickState;
- (void)resetCellClickState;
- (void)resetAllState:(BOOL)state;
@end
@interface ShoppingCartListModel : BaseModel
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
/**  当前数量 */
@property(nonatomic,copy) NSString * count;
/**  库存 */
@property(nonatomic,copy) NSString * inventory;
/** cell 选中状态 */
@property (nonatomic, assign) BOOL isCellSelected;
@end
