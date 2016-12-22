
//
//  MyOrderRefundHomeVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderRefundHomeVC.h"
#import "MyCollectionTitleView.h"
#import "MyOrderRefundApplyVC.h"
#import "MyOrderRefundSearchVC.h"
@interface MyOrderRefundHomeVC ()<MyCollectionTitleViewDelegate>
/**  titleView */
@property(nonatomic,strong) MyCollectionTitleView * titleView;
@end

@implementation MyOrderRefundHomeVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    self.titleView =  [[MyCollectionTitleView alloc] initWithTitleArray:@[String(@"申请售后"),String(@"进度查询")] Frame:CGRectMake(0, 0, Adapted(200), 44)];
    [self.titleView MyCollectionTitleViewClickWithIndex:0];
    self.titleView.delegate = self;
    self.navigationItem.titleView = self.titleView;
    
    self.scrollView.frame = kCommentRect;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * 2, 0);
    [self.view addSubview: self.scrollView];
    
    //配置子控制器
    MyOrderRefundApplyVC * applyVC = [[MyOrderRefundApplyVC alloc] init];
    applyVC.view.frame = CGRectMake(0, 0, kScreenW, kScreenH - TopBarHeight);
    [self.scrollView addSubview:applyVC.view];
    [self addChildViewController:applyVC];
    
    MyOrderRefundSearchVC * searchVC = [[MyOrderRefundSearchVC alloc] init];
    searchVC.view.frame = CGRectMake(kScreenW, 0, kScreenW, applyVC.view.height);
    [self.scrollView addSubview:searchVC.view];
    [self addChildViewController:searchVC];
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
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.titleView MyCollectionTitleViewClickWithIndex:scrollView.contentOffset.x / kScreenW];
    
}
#pragma mark - MyCollectionTitleViewDelegate
- (void)MyCollectionTitleViewDelegate_clickIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index * kScreenW, 0)  animated:YES];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
