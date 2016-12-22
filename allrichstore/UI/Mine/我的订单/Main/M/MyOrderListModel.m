//
//  MyOrderListModel.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderListModel.h"

@implementation MyOrderListModel

- (NSInteger)goodsCount
{
    NSInteger count = 0;
    for (MyOrderList_GoodsModel *model in self.goods) {
        count += model.count.integerValue;
    }
    return count;
}
- (CGFloat)totalPrice
{
    CGFloat price = 0.0f;
    for (MyOrderList_GoodsModel *model in self.goods) {
        price += model.count.integerValue * model.price.floatValue;
    }
    return price;
}
- (CGFloat)cellHeight
{
    return  Adapted(kHeaderH) + self.goods.count * Adapted(kCell_CellHeight) + Adapted(self.buttonArray.count ? 65.0f :45.0f);

}
- (NSArray <NSString *>*)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
+ (NSDictionary *)objectClassInArray{
    return @{
             @"goods" : @"MyOrderList_GoodsModel",
             @"buttonArray":@"NSString"
             };
}
@end
@implementation MyOrderList_GoodsModel
- (CGFloat)cellHeight
{
    return Adapted(kCell_CellHeight);
}


@end
