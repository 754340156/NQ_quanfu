//
//  CollectionViewChangeLayout.m
//  allrichstore
//
//  Created by zhaozhe on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CollectionViewChangeLayout.h"
#define GoodsListLayoutCellHeight Adapted(220.0f)
#define GoodsHorizontalLayoutCellHeight Adapted(120.0f)
@implementation CollectionViewChangeLayout
- (instancetype)initWithType:(ChangeLayoutType )type
{
    self = [super init];
    if (self) {
        [self setupWithType:type];
    }
    return self;
}
#pragma mark - setup
- (void)setupWithType:(ChangeLayoutType )type
{
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    if (type == ChangeLayoutList)
    {
        //列表布局
        self.itemSize = CGSizeMake(kScreenW / 2, GoodsListLayoutCellHeight);
    }else if (type == ChangeLayoutHorizontal)
    {
        //水平布局
        self.itemSize = CGSizeMake(kScreenW, GoodsHorizontalLayoutCellHeight);
    }
}
- (void)setType:(ChangeLayoutType)type
{
    _type = type;
    [self setupWithType:type];
}
@end
