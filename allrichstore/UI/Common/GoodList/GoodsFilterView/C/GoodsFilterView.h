//
//  GoodsFilterView.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

//商品属性列表的协议
@protocol GoodsPropertyAble <NSObject>

//是否全部展开
@property (nonatomic, assign) BOOL isOpened;
//属性的名称
@property (nonatomic, strong)   NSString *propertyName;
//商品数组
@property (nonatomic, strong) NSArray *tagsArray;
//选中的标签
@property (nonatomic, strong) NSMutableArray *seletedTagsArray;

@end

//商品筛选的协议
@protocol GoodsFilterAble <NSObject>

@property (nonatomic, assign) CGFloat priceMin; //最小价格
@property (nonatomic, assign) CGFloat priceMax; //最大价格
@property (nonatomic, strong) NSArray<id<GoodsPropertyAble>> *propertyArray;   //属性数组

@end


typedef void (^CompleteBlock)(id<GoodsFilterAble> resultObject);

@class GoodsFilterModel;
@interface GoodsFilterView : UIView

- (instancetype)initWithFrame:(CGRect)frame completeBlock:(CompleteBlock)completeBlock;
- (instancetype)initWithFrame:(CGRect)frame model:(id<GoodsFilterAble>)model completeBlock:(CompleteBlock)completeBlock;
@property (nonatomic, strong) id<GoodsFilterAble> model;

@end

@class TagCellButton;
@interface TagCell : UICollectionViewCell

@property (nonatomic, strong) TagCellButton *tagBtn;

@end


@interface TagCellButton : UIButton


@end


