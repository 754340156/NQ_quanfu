//
//  ChoiceGoodsVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/27.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ChoiceGoodsVC.h"
#import "GoodsModel.h"  //商品model

@implementation ChoiceGoodsVC

#pragma mark - SubClass Override
#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    NSDictionary *parameters = @{@"field":self.cField, @"lType":@"4", @"pageNum":@(_pageIndex), @"pageSize":@(PageSize_list)};
    WS(weakSelf)
    [self POST:API_GoodsList parameters:parameters success:^(NSDictionary *dic) {
        
        NSArray *array = dic[kResponse];
        [self.listArray addObjectsFromArray:[GoodsModel mj_objectArrayWithKeyValuesArray:array]];
        [weakSelf.collectionView reloadData];
        
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.view animated:animated];
}

@end
