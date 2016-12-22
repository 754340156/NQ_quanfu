//
//  GoodsFilterModel.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsFilterView.h"

@class GoodsPropertyModel;
@interface GoodsFilterModel : NSObject<GoodsFilterAble>

@property (nonatomic, assign) CGFloat minPrice;
@property (nonatomic, assign) CGFloat maxPrice;
@property (nonatomic, strong) NSArray <id<GoodsPropertyAble>> *properArray;

@end

@interface GoodsPropertyModel : NSObject<GoodsPropertyAble>

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy)   NSString *properName;
@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, strong) NSMutableArray *selectedTagArray;

@end


