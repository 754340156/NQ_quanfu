//
//  GoodsFilterVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SlideWindowVC.h"
#import "GoodsFilterView.h" //商品筛选view
#import "GoodsFilterModel.h"//筛选 model

@interface GoodsFilterVC : SlideWindowVC

- (instancetype)initWithSlideType:(SlideType)slideType model:(id<GoodsFilterAble>)model completeBlock:(CompleteBlock)completeBlock;

@end
