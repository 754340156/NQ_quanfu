//
//  CreateOrderModel.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CreateOrderModel.h"
#import "MyOrderListModel.h"
@implementation CreateOrderModel
- (CGFloat)addressH
{
    return [UILabel getHeightWithFont:kAddressFont Width:kAddressW text:self.address];
}
- (CGFloat)headerViewH
{
    return Adapted(kMargin) * 3 + Adapted(kLabelH) + self.addressH;
}
- (CGFloat)section1H
{
    CGFloat height = 0.0f;
    for (MyOrderListModel *model in self.listGoods) {
        height += model.cellHeight;
    }
    return height;
}
- (CGFloat)section2H
{
    CGFloat height = 0.0f;
    height  = Adapted(kServiceH) * (self.servicesArray.count + 2) + Adapted(kAmountCellH);
    return height;
}
- (CGFloat)tableViewH
{
    return  self.section1H + self.section2H;
}
+ (NSDictionary *)objectClassInArray{
    return @{
             @"listGoods" : @"MyOrderListModel",
             @"servicesArray":@"CreateOrderServiceModel"
             };
}
@end
@implementation CreateOrderServiceModel



@end
@implementation CreateOrderGoodsPrices



@end
