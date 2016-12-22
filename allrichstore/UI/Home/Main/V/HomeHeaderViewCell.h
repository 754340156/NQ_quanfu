//
//  HomeHeaderViewCell.h
//  allrichstore
//
//  Created by 任强宾 on 16/10/31.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeHeaderViewCell;

@protocol HomeHeaderViewCellDelegate <NSObject>

- (void)homeHeaderViewCell:(HomeHeaderViewCell *)cell didSelectedIndex:(NSInteger)index;

@end

@interface HomeHeaderViewCell : BaseCollectionViewCell

@property (nonatomic, assign) id<HomeHeaderViewCellDelegate> delegate;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) SDCycleScrollView *bottomCycleScrollView;

@property (nonatomic, strong) NSArray *collectionlistArray;

+ (CGFloat)cellHeight;

@end
