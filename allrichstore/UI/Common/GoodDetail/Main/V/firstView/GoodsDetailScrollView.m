//
//  GoodsDetailScrollView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsDetailScrollView.h"
#import "GoodsDetailHeaderView.h"
#import "GoodsDetailActiveView.h"
#import "GoodsDetailEvaluativeView.h"
#import "GoodsDetailStoreView.h"
#import "GoodsDetailModel.h"
@interface GoodsDetailScrollView ()<GoodsDetailHeaderViewDelegate,GoodsDetailStoreViewDelegate>
/**  头部 */
@property(nonatomic,strong) GoodsDetailHeaderView  * headerView;
/**  活动 */
@property(nonatomic,strong) GoodsDetailActiveView * activeView;
/**  评价 */
@property(nonatomic,strong) GoodsDetailEvaluativeView * evaluativeView;
/**  店铺 */
@property(nonatomic,strong) GoodsDetailStoreView  * storeView;
@end

@implementation GoodsDetailScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = QFColor_CoodsClassMenuViewBg;
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.headerView = [[GoodsDetailHeaderView alloc] init];
    self.headerView.delegate = self;
    [self addSubview:self.headerView];
    
    self.activeView = [[GoodsDetailActiveView alloc] init];
    [self addSubview:self.activeView];
    
    self.evaluativeView = [[GoodsDetailEvaluativeView alloc] init];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvaluativeView)];
    [self.evaluativeView addGestureRecognizer:tap];
    [self addSubview:self.evaluativeView];
    
    self.storeView = [[GoodsDetailStoreView alloc] init];
    [self addSubview:self.storeView];
    
}
- (void)setLayout
{
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.centerX.equalTo(self.mas_centerX);
        make.width.offset(kScreenW);
        make.height.offset(Adapted(GD_HeaderViewH));
    }];
    
    [self.activeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(Adapted(GD_Margin));
        make.centerX.equalTo(self.mas_centerX);
        make.width.offset(kScreenW);
        make.height.offset(Adapted(self.model.active_height));
    }];
    
    [self.evaluativeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.activeView.mas_bottom).offset(Adapted(GD_Margin));
        make.centerX.equalTo(self.mas_centerX);
        make.width.offset(kScreenW);
        make.height.offset(Adapted(self.model.evaluative_height));
    }];
    
    [self.storeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.evaluativeView.mas_bottom).offset(Adapted(GD_Margin));
        make.centerX.equalTo(self.mas_centerX);
        make.width.offset(kScreenW);
        make.height.offset(Adapted(self.model.store_height));
        make.bottom.offset(Adapted(-GD_Margin));
    }];
    
}
#pragma mark - GoodsDetailHeaderViewDelegate
- (void)GoodsDetailHeaderViewDelegate_clickCycleScrollView:(SDCycleScrollView *)cycleScrollView index:(NSInteger)index
{
    
}
#pragma mark - GoodsDetailStoreViewDelegate
- (void)GoodsDetailStoreViewDelegate_clickView:(UIView *)storeView
{
    
}
- (void)GoodsDetailStoreViewDelegate_clickIntoButton:(UIButton *)intoButton
{
    
}
#pragma mark - handle action
- (void)tapEvaluativeView
{
    if (self.GD_delegate && [self.GD_delegate respondsToSelector:@selector(GoodsDetailScrollViewDelegate_clickEvaluativeWithEvaluativeView:)]) {
        [self.GD_delegate GoodsDetailScrollViewDelegate_clickEvaluativeWithEvaluativeView:self.evaluativeView];
    }
}
#pragma mark - custom method

#pragma mark - setter model
- (void)setModel:(GoodsDetailModel *)model
{
    _model = model;
    [self.activeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(model.active_height);
    }];
    [self.evaluativeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(model.evaluative_height);
    }];
    [self.storeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(model.store_height);
    }];
    self.headerView.model = model;
    self.activeView.model = model;
    self.evaluativeView.model = model;
    self.storeView.model = model;
}
@end
