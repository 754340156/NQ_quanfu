//
//  GoodsDetailSecondView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsDetailSecondView.h"
#import "GoodsDetailSecondHeaderView.h"

#define kHeaderViewH 45.0f
@interface GoodsDetailSecondView ()<GoodsDetailSecondHeaderViewDelegate,UIScrollViewDelegate>

/**  headerView */
@property(nonatomic,strong) GoodsDetailSecondHeaderView * headerView;

@end

@implementation GoodsDetailSecondView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.headerView = [[GoodsDetailSecondHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, Adapted(kHeaderViewH)) TitleArray:@[@"图文介绍",@"产品参数",@"售后包装",@"店铺推荐"]];
    self.headerView.delegate = self;
    [self addSubview:self.headerView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Adapted(kHeaderViewH), kScreenW, kScreenH - TopBarHeight - Adapted(kHeaderViewH) - Adapted(GD_BottomH))];
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * 4, 0);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview: self.scrollView];
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
}
- (void)setLayout
{
    
}
#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIView * subView= self.viewsArray[index];
    subView.frame = CGRectMake(scrollView.contentOffset.x, 0, kScreenW, kScreenH - TopBarHeight - Adapted(kHeaderViewH));
    [self.scrollView addSubview:subView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.headerView GoodsDetailSecondHeaderViewClickWithIndex:scrollView.contentOffset.x / kScreenW];
     [self scrollViewDidEndScrollingAnimation:self.scrollView];
}
#pragma mark - GoodsDetailSecondHeaderViewDelegate
- (void)GoodsDetailSecondHeaderViewDelegate_clickIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index * kScreenW, 0)  animated:YES];
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - lazy
- (NSMutableArray *)viewsArray
{
    if (!_viewsArray) {
        _viewsArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 4; i++) {
            GD_SecondTableView *tableView = [[GD_SecondTableView alloc] init];
            tableView.backgroundColor = kBlueColor;
            [_viewsArray addObject:tableView];
        }
    }
    return _viewsArray;
}
- (void)setSuperVC:(UIViewController<UITableViewDelegate> *)superVC
{
    _superVC = superVC;
    //设置下拉返回
    for (GD_SecondTableView *tableView in self.viewsArray) {
        tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:nil];
        tableView.delegate = superVC;
        MJRefreshStateHeader *header =  (MJRefreshStateHeader *) tableView.mj_header;
        header.lastUpdatedTimeLabel.hidden = YES;
        [header setTitle:String(@"下拉回到商品详情") forState:MJRefreshStateIdle];
        [header setTitle:String(@"释放回到商品详情") forState:MJRefreshStatePulling];
        [header setTitle:String(@"释放回到商品详情") forState:MJRefreshStateRefreshing];
    }
    
}
@end
