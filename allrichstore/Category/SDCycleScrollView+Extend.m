//
//  SDCycleScrollView+Extend.m
//  allrichstore
//
//  Created by 任强宾 on 16/12/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SDCycleScrollView+Extend.h"

//占位图
#define kPlaceholderImage   Image_PlaceHolder_Banner
//背景颜色
#define kBackgroudColor     Color_BaseVCViewBg

static void *modelArrayKey   = &modelArrayKey;
@implementation SDCycleScrollView (Extend)

/**
 传入model数组的初始化方式
 @param frame frame
 @param array 对象数组
 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame  modelArray:(NSArray<id<SDCycleModelAble>> *)array
{
    SDCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.backgroundColor = kBackgroudColor;
    cycleScrollView.delegate = cycleScrollView;
    cycleScrollView.placeholderImage = kPlaceholderImage;
    cycleScrollView.modelArray = array;
    return cycleScrollView;
}

#pragma mark - setter getter
- (void)setModelArray:(NSArray *)modelArray
{
    objc_setAssociatedObject(self, &modelArrayKey, modelArray, OBJC_ASSOCIATION_RETAIN);
    NSMutableArray *urlArray = [NSMutableArray array];
    for (int i = 0; i < modelArray.count; i++)
    {
        id<SDCycleModelAble> obj = modelArray[i];
        NSString *imgUrl = [obj cycleImgUrl];
        [urlArray addObject:imgUrl];
    }
    self.imageURLStringsGroup = urlArray;
}

- (NSArray *)modelArray
{
    return objc_getAssociatedObject(self, &modelArrayKey);
}

#pragma mark - <SDCycleScrollViewDelegate>
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    id<SDCycleModelAble> obj = self.modelArray[index];
    UIViewController *currentVC = [self currentVC];
    BaseVC *webVC = [BaseVC new];
    webVC.title = [obj cycleTitle];
    webVC.webViewUrl = [obj cycleJumpUrl];
    [currentVC.navigationController pushVC:webVC animated:YES];
}

@end
