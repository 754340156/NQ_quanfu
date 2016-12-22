//
//  ShopCycleScrollCell.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface ShopCycleScrollCell : BaseCollectionViewCell

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray *activityArray;

@end
