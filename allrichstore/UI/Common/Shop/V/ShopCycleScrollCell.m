//
//  ShopCycleScrollCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopCycleScrollCell.h"

@interface ShopCycleScrollCell ()

@property (nonatomic, strong) UIView *bottomView;

@end

@implementation ShopCycleScrollCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.backgroundColor = kWhiteColor;
    
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, self.height - 50) imageURLStringsGroup:ImageUrlArray_Banner];
    _cycleScrollView.titlesGroup = @[@"banner1", @"banner2", @"banner3", @"banner4"];
    _cycleScrollView.pageDotImage = Image_CyclePageDotImage;
    _cycleScrollView.currentPageDotImage = Image_CycleCurrentPageDotImage;
    [self.contentView addSubview:_cycleScrollView];
}

//布局子视图
- (void)layoutViews
{
    
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
//给活动赋值
- (void)setActivityArray:(NSArray *)activityArray
{
    _activityArray = activityArray;
    [_bottomView removeFromSuperview];
    _bottomView = nil;
    
    self.bottomView = [UIView new];
    _bottomView.backgroundColor = kWhiteColor;
    _bottomView.frame = CGRectMake(0, _cycleScrollView.bottom, self.contentView.width, 50);
    [self.contentView addSubview:_bottomView];
    
    UILabel *leftLabel = [UILabel new];
    leftLabel.text = String(@"店铺优惠活动");
    leftLabel.textColor = QF_BlackColor;
    leftLabel.font = Font(16);
    leftLabel.frame = CGRectMake(Adapted(10), 0, [leftLabel getWidth], _bottomView.height);
    [_bottomView addSubview:leftLabel];
    
    UIScrollView *rightScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(leftLabel.right + Adapted(16), 0, _bottomView.width - leftLabel.right - Adapted(16) - Adapted(10), _bottomView.height)];
    
    //rightScrollView.showsHorizontalScrollIndicator = NO;
    //多个活动 使用横向的scrollView排列
    CGFloat offx = 0;
    CGFloat levelSpace = Adapted(10);
    for (int i = 0; i < _activityArray.count; i++)
    {
        UILabel *activityLabel = [UILabel new];
        activityLabel.text = _activityArray[i];
        activityLabel.textColor = kLightGrayColor_D;
        activityLabel.font = Font(15);
        activityLabel.frame = CGRectMake(offx, 0, [activityLabel getWidth], rightScrollView.height);
        [rightScrollView addSubview:activityLabel];
        
        offx = activityLabel.right + levelSpace;
    }
    
    [_bottomView addSubview:rightScrollView];
    
    if (offx != 0)
    {
        offx -= 10;
    }
    
    rightScrollView.contentSize  = CGSizeMake(offx, rightScrollView.height);
    
    if (rightScrollView.width > offx)
    {
        rightScrollView.frame = CGRectMake(_bottomView.width  - offx - Adapted(10), 0, offx, _bottomView.height);
    }
}

@end
