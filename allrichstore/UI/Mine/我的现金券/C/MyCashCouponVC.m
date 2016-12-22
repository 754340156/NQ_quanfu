//
//  MyCashCouponVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCashCouponVC.h"
#import "MyCashCouponIncomeVC.h" //收入
#import "MyCashCouponSpendingVC.h" //支出
#import "MyCashCounponTotalView.h"
#import "MyCoupon_TitleView.h"
#import "MyCashCounponModel.h"
#define kTitleViewH 45.0f
@interface MyCashCouponVC ()<MyCoupon_TitleViewDelegate>
/**  headerView */
@property(nonatomic,strong) MyCashCounponTotalView * headerView;
/**  titleView */
@property(nonatomic,strong) MyCoupon_TitleView * titleView;
/**  model */
@property(nonatomic,strong) MyCashCounponModel * model;
@end

@implementation MyCashCouponVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.view.backgroundColor = QFColor_CoodsClassMenuViewBg;
    
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
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, Adapted(kTitleViewH + kHeaderViewH + kMargin / 2 + ListCell_Line_W_H) + TopBarHeight , kScreenW, kScreenH - Adapted(kTitleViewH + kHeaderViewH + kMargin / 2) - TopBarHeight);
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * 2, 0);
    
    //配置子控制器
    //收入
    MyCashCouponIncomeVC * incomeVC = [[MyCashCouponIncomeVC alloc] init];
    incomeVC.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:incomeVC.view];
    [self addChildViewController:incomeVC];
    
    //支出
    MyCashCouponSpendingVC *spendingVC = [[MyCashCouponSpendingVC alloc] init];
    spendingVC.view.frame = CGRectMake(kScreenW, 0, kScreenW, self.scrollView.height);
    [self.scrollView addSubview:spendingVC.view];
    [self addChildViewController:spendingVC];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopBarHeight);
        make.right.left.offset(0);
        make.height.offset(Adapted(kHeaderViewH));
    }];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(Adapted(kMargin / 2));
        make.height.offset(Adapted(kTitleViewH));
        make.left.right.offset(0);
    }];
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
#pragma mark - lazy
- (MyCashCounponTotalView *)headerView
{
    if (!_headerView) {
        _headerView = [[MyCashCounponTotalView alloc] init];
        _headerView.total = [Single getUserModel].uMoney;
        _headerView.backgroundColor = kWhiteColor;
    }
    return _headerView;
}
- (MyCoupon_TitleView *)titleView
{
    if (!_titleView) {
        _titleView = [[MyCoupon_TitleView alloc] initWithFrame:CGRectMake(0, TopBarHeight, kScreenW, Adapted(kTitleViewH)) TitleArray:@[String(@"收入"),String(@"支出")]];
        _titleView.backgroundColor = kWhiteColor;
        [_titleView addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleOutside];
        _titleView.delegate = self;
    }
    return _titleView;
}
- (MyCashCounponModel *)model
{
    if (!_model) {
        NSDictionary *dic = @{@"total":@"500",
                              @"incomeArray":@[@{@"title":@"购买马克杯获得30积分",
                                                 @"time":@"2016-10-29",
                                                 @"integral":@"30",
                                                 @"isAdd":@"1"},
                                               @{@"title":@"购买马克杯获得30积分",
                                                 @"time":@"2016-10-29",
                                                 @"integral":@"30",
                                                 @"isAdd":@"1"},
                                               @{@"title":@"购买马克杯获得30积分",
                                                 @"time":@"2016-10-29",
                                                 @"integral":@"30",
                                                 @"isAdd":@"1"}],
                              @"spendingArray":@[@{@"title":@"购买马克杯获得30积分",
                                                 @"time":@"2016-10-29",
                                                 @"integral":@"30",
                                                 @"isAdd":@"0"},
                                               @{@"title":@"购买马克杯获得30积分",
                                                 @"time":@"2016-10-29",
                                                 @"integral":@"30",
                                                 @"isAdd":@"0"},
                                               @{@"title":@"购买马克杯获得30积分",
                                                 @"time":@"2016-10-29",
                                                 @"integral":@"30",
                                                 @"isAdd":@"0"}]};
        _model = [MyCashCounponModel mj_objectWithKeyValues:dic];
    }
    return  _model;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
