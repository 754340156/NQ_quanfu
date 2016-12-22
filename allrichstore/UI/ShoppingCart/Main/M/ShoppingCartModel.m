//
//  ShoppingCartModel.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"goods" : @"ShoppingCartListModel"
             };
}
- (void)resetHeadClickState {
    if (self.goods.count == 0) {
        self.isHeadSelected = NO;
        return;
    }
    for (ShoppingCartListModel *model in self.goods) {
        if (model.isCellSelected == NO) {
            self.isHeadSelected = NO;
            return;
        }
    }
    self.isHeadSelected = 1;
}

- (void)resetCellClickState {
    for (ShoppingCartListModel *model in self.goods) {
        model.isCellSelected = self.isHeadSelected;
    }
}

- (void)resetAllState:(BOOL)state {
    self.isHeadSelected = state;
    for (ShoppingCartListModel *model in self.goods) {
        model.isCellSelected = state;
    }
}
@end
@implementation ShoppingCartListModel


@end
