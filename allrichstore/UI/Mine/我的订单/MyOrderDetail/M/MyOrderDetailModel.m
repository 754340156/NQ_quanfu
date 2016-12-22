//
//  MyOrderDetailModel.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderDetailModel.h"
#import "MyOrderListModel.h"

@implementation MyOrderDetailModel

- (CGFloat)addressH
{
    return [UILabel getHeightWithFont:kAddressFont Width:kAddressW text:self.address];
}
- (CGFloat)headerViewH
{
    return self.addressH + Adapted(kMargin) * 3 + Adapted(kLabelH) + Adapted(kBackViewH);
}
- (CGFloat)price
{
    CGFloat totalPirce = 0.00f;
    for (MyOrderListModel *model in self.listGoods) {
        totalPirce += model.totalPrice;
    }
    return totalPirce;
}
- (CGFloat)factPrice
{
    return self.price + self.freight.floatValue;
}
- (CGFloat)listGoodsH
{
    CGFloat height = 0.0f;
    for (MyOrderListModel *model in self.listGoods) {
        height += model.cellHeight;
    }
    return height;
}
- (CGFloat)invoiceRiseH
{
    CGFloat width = kScreenW - Adapted(kMargin) * 3 - Adapted(kInvoiceRiseW);
    return [UILabel getHeightWithFont:kInvoiceRiseFont Width:width text:self.invoiceRise];
}
- (CGFloat)invoiceContentH
{
    CGFloat width = kScreenW - Adapted(kMargin) * 3 - Adapted(kInvoiceRiseW);
    return [UILabel getHeightWithFont:kInvoiceRiseFont Width:width text:self.invoiceContent];
}
- (CGFloat)invoiceCellH
{
    return 4 * Adapted(kMargin) + Adapted(kLabelH) + self.invoiceContentH + self.invoiceRiseH;
}
- (CGFloat)invoiceTableViewH
{
    return  self.invoiceCellH + self.priceCellArray.count * Adapted(kPriceCellHeight);
}
- (NSArray <MyOrderDetailPriceModel *> *)priceCellArray
{
    NSArray * array = @[@{@"title":String(@"商品总额"),
                          @"subTitle":[NSString stringWithFormat:@"¥%.2f",self.price]},
                        @{@"title":String(@"+运费"),
                          @"subTitle":[NSString stringWithFormat:@"¥%@",self.freight]},
                        @{@"title":String(@"实付款"),
                          @"subTitle":[NSString stringWithFormat:@"¥%.2f",self.factPrice],
                          @"isRed":@"1"},
                        @{@"title":String(@"下单时间"),
                          @"subTitle":self.time}];
    return  [MyOrderDetailPriceModel mj_objectArrayWithKeyValuesArray:array];
}
+ (NSDictionary *)objectClassInArray{
    return @{
             @"listGoods" : @"MyOrderListModel",
             @"priceCellArray":@"MyOrderDetailPriceModel"
             };
}
@end
@implementation MyOrderDetailPriceModel


@end
