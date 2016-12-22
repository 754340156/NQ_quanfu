//
//  MyCouponVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCouponVC.h"
#import "MyCoupon_UsedVC.h"
#import "MyCoupon_UnusedVC.h"
#import "MyCoupon_OutDateVC.h"
#import "MyCoupon_TitleView.h"
#import "MyCouponModel.h"
#define kTitleViewH 45.0f
@interface MyCouponVC ()<MyCoupon_TitleViewDelegate>
/**  头部分段 */
@property(nonatomic,strong) MyCoupon_TitleView * titleView;
@end

@implementation MyCouponVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    //添加导航栏上面的分段
    self.titleView = [[MyCoupon_TitleView alloc] initWithFrame:CGRectMake(0, TopBarHeight, kScreenW, Adapted(kTitleViewH)) TitleArray:@[@"未使用 2",@"已过期 5",@"已使用 0"]];
#warning 国际化未配置
    [self.titleView addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleOutside];
    self.titleView.delegate = self;
    [self.view addSubview:self.titleView];
    
    self.scrollView.frame = CGRectMake(0, Adapted(kTitleViewH) + ListCell_Line_W_H + TopBarHeight, kScreenW, kScreenH - Adapted(kTitleViewH) - TopBarHeight - ListCell_Line_W_H);
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * 3, 0);
    [self.view addSubview: self.scrollView];
    
    //配置子控制器
    
    //未使用
    MyCoupon_UnusedVC * unusedVC = [[MyCoupon_UnusedVC alloc] init];
    unusedVC.NetworkFinishBlock = ^(NSInteger count)
    {
        [self.titleView UpdateTitleWithIndex:0 Title:[NSString stringWithFormat:@"未使用 %ld ",(long)count]];
    };
    unusedVC.view.frame = self.scrollView.bounds;;
    [self.scrollView addSubview:unusedVC.view];
    [self addChildViewController:unusedVC];
    
    //已过期
    MyCoupon_OutDateVC *outDateVC = [[MyCoupon_OutDateVC alloc] init];
    outDateVC.NetworkFinishBlock = ^(NSInteger count)
    {
        [self.titleView UpdateTitleWithIndex:1 Title:[NSString stringWithFormat:@"已过期 %ld ",(long)count]];
    };
    outDateVC.view.frame = CGRectMake(kScreenW, 0, kScreenW, self.scrollView.height);
    [self.scrollView addSubview:outDateVC.view];
    [self addChildViewController:outDateVC];

    //已使用
    MyCoupon_UsedVC * usedVC = [[MyCoupon_UsedVC alloc] init];
    usedVC.NetworkFinishBlock = ^(NSInteger count)
    {
        [self.titleView UpdateTitleWithIndex:2 Title:[NSString stringWithFormat:@"已使用 %ld ",(long)count]];
    };
    usedVC.view.frame = CGRectMake(kScreenW * 2, 0, kScreenW, self.scrollView.height);
    [self.scrollView addSubview:usedVC.view];
    [self addChildViewController:usedVC];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    
}

#pragma mark - custom method


#pragma mark - handle action
#pragma mark - MyCoupon_TitleViewDelegate
- (void)MyCoupon_TitleViewDelegate_clickIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index * kScreenW, 0)  animated:YES];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.titleView MyCoupon_TitleViewClickWithIndex:scrollView.contentOffset.x / kScreenW];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
