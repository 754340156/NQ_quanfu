//
//  SDCycleScrollView+Extend.h
//  allrichstore
//
//  Created by 任强宾 on 16/12/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <SDCycleScrollView/SDCycleScrollView.h>

@protocol SDCycleModelAble <NSObject>

- (NSString *)cycleImgUrl;
- (NSString *)cycleTitle;
- (NSString *)cycleJumpUrl;

@end

@interface SDCycleScrollView (Extend)<SDCycleScrollViewDelegate>

/**
 传入model数组的初始化方式
 @param frame frame
 @param array 对象数组
 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame  modelArray:(NSArray<id<SDCycleModelAble>> *)array;

@property (nonatomic, strong) NSArray *modelArray;

@end
