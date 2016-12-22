//
//  CreateOrderModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"
/*****************  headerView ***********************/
#define kLabelH 20.0f

#define kAddressW 286.0f
#define kAddressFont Font_Mid
/*****************  服务相关 ***********************/
#define kServiceH 45.0f
#define kAmountCellH 90.0f
@class MyOrderListModel,CreateOrderGoodsPrices,CreateOrderServiceModel;
@interface CreateOrderModel : BaseModel
/**  收货人 */
@property(nonatomic,copy) NSString * name;
/**  收货人电话 */
@property(nonatomic,copy) NSString * phone;
/**  收货人地址 */
@property(nonatomic,copy) NSString * address;
/**  中间商品的数组 */
@property(nonatomic,strong) NSArray <MyOrderListModel *>* listGoods;
/**  配送方式等服务信息 */
@property(nonatomic,strong) NSArray <CreateOrderServiceModel*>* servicesArray;
/**  买家留言 */
@property(nonatomic,copy) NSString * buyerMessage;
/**  可用积分 */
@property(nonatomic,strong) NSString * integral;
/**  商品金额相关 */
@property(nonatomic,strong) CreateOrderGoodsPrices * prices;
/********************   计算属性  ************************/
/**  收货地址的高度 */
@property(nonatomic,assign) CGFloat addressH;
/**  headerViewH */
@property(nonatomic,assign) CGFloat headerViewH;
/**  section1高度 */
@property(nonatomic,assign) CGFloat section1H;
/**  section2高度 */
@property(nonatomic,assign) CGFloat section2H;
/**  整体tableView的高度 */
@property(nonatomic,assign) CGFloat tableViewH;
@end


@interface CreateOrderServiceModel : BaseModel
/**  服务的title（配送方式/发票信息/优惠券/现金券） */
@property(nonatomic,copy) NSString * title;
/**  服务的数组 */
@property(nonatomic,strong) NSArray <NSString *>* serviceArray ;
@end


@interface CreateOrderGoodsPrices : BaseModel
/**  商品金额 */
@property(nonatomic,copy) NSString * goodPrice;
/**  运费 */
@property(nonatomic,copy) NSString * freight;
/**  优惠 */
@property(nonatomic,copy) NSString * preference;
@end
