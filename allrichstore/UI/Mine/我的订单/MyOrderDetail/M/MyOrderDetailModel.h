//
//  MyOrderDetailModel.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseModel.h"

/*****************  headerView ***********************/
#define kBackViewH 60.0f
#define kLabelH 20.0f

#define kAddressW 286.0f
#define kAddressFont Font_Mid
/*****************  发票相关 ***********************/
#define kInvoiceRiseFont Font_Min
#define kInvoiceRiseW 60.0f
#define kPriceCellHeight 44.0f
@class MyOrderListModel,MyOrderDetailPriceModel;
@interface MyOrderDetailModel : BaseModel
/**  交易状态 */
@property(nonatomic,copy) NSString * status;
/**  订单编号 */
@property(nonatomic,copy) NSString * number;
/**  收货人 */
@property(nonatomic,copy) NSString * name;
/**  收货人电话 */
@property(nonatomic,copy) NSString * phone;
/**  收货人地址 */
@property(nonatomic,copy) NSString * address;
/**  中间商品的数组 */
@property(nonatomic,strong) NSArray <MyOrderListModel *>* listGoods;
/**  发票信息 */
@property(nonatomic,copy) NSString* invoiceType;
/**  发票抬头 */
@property(nonatomic,copy) NSString * invoiceRise;
/**  发票内容 */
@property(nonatomic,copy) NSString * invoiceContent;
/**  运费 */
@property(nonatomic,copy) NSString * freight;
/**  下单时间 */
@property(nonatomic,copy) NSString * time;
/**  priceCellArray */
@property(nonatomic,strong) NSArray <MyOrderDetailPriceModel *>* priceCellArray;
/********************   计算属性  ************************/
/**  商品总价格 */
@property(nonatomic,assign) CGFloat  price;
/**  实付款 */
@property(nonatomic,assign) CGFloat  factPrice;
/**  收货地址的高度 */
@property(nonatomic,assign) CGFloat addressH;
/**  headerViewH */
@property(nonatomic,assign) CGFloat headerViewH;
/**  商品Height */
@property(nonatomic,assign) CGFloat listGoodsH;
/**  发票抬头高度 */
@property(nonatomic,assign) CGFloat invoiceRiseH;
/**  发票内容高度 */
@property(nonatomic,assign) CGFloat invoiceContentH;
/**  发票信息cell高度 */
@property(nonatomic,assign) CGFloat invoiceCellH;

/**  发票tableViewH */
@property(nonatomic,assign) CGFloat invoiceTableViewH;

@end

@interface MyOrderDetailPriceModel : BaseModel
/**  title */
@property(nonatomic,copy) NSString * title;
/**  subTitle */
@property(nonatomic,copy) NSString * subTitle;
/**  是否显示为红色 */
@property(nonatomic,assign) BOOL isRed;

@end
