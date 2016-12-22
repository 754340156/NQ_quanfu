//
//  GoodsFilterModel.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsFilterModel.h"

@implementation GoodsFilterModel


#pragma mark - <GoodsFilterAble>
//最小价格
- (void)setPriceMin:(CGFloat)priceMin
{
    _minPrice = priceMin;
}

- (CGFloat)priceMin
{
    return _minPrice;
}

//最大价格
- (void)setPriceMax:(CGFloat)priceMax
{
    _maxPrice = priceMax;
}

- (CGFloat)priceMax
{
    return _maxPrice;
}

//属性数组
- (void)setPropertyArray:(NSArray<id<GoodsPropertyAble>> *)propertyArray
{
    _properArray = propertyArray;
}

- (NSArray<id<GoodsPropertyAble>> *)propertyArray
{
    return _properArray;
}

@end

@implementation GoodsPropertyModel

#pragma mark - <GoodsPropertyAble>
//是否展开
- (void)setIsOpened:(BOOL)isOpened
{
    _isOpen = isOpened;
}

- (BOOL)isOpened
{
    return _isOpen;
}

//属性名称
- (void)setPropertyName:(NSString *)propertyName
{
    _properName = propertyName;
}

- (NSString *)propertyName
{
    return _properName;
}

//标签数组
- (void)setTagsArray:(NSArray *)tagsArray
{
    _tagArray = tagsArray;
}

- (NSArray *)tagsArray
{
    return _tagArray;
}

//选中的标签的数组
- (void)setSeletedTagsArray:(NSMutableArray *)seletedTagsArray
{
    _selectedTagArray = seletedTagsArray;
}

- (NSMutableArray *)seletedTagsArray
{
    return _selectedTagArray;
}

@end
