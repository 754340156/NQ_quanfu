//
//  MyCollectionVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCollectionVC.h"
#import "MyCollection_GoodsVC.h"
#import "MyCollection_ShopsVC.h"
#import "MyCollectionTitleView.h"
@interface MyCollectionVC ()<MyCollectionTitleViewDelegate>
/**  titleView */
@property(nonatomic,strong) MyCollectionTitleView * titleView;
/**  取消收藏 */
@property(nonatomic,strong) UIButton * cancelCollectionBtn;
@end

@implementation MyCollectionVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
    UIButton *editButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.titleLabel.font = Font_Min;
    [editButton setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [editButton setTitle:String(@"编辑") forState:UIControlStateNormal];
    [editButton setTitle:String(@"完成") forState:UIControlStateSelected];
    editButton.size = CGSizeMake(40, 20);
    [self addRightBtn:editButton action:@selector(editAction:)];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    
    //添加导航栏上面的分段
    self.titleView =  [[MyCollectionTitleView alloc] initWithTitleArray:@[String(@"宝贝"),String(@"店铺")] Frame:CGRectMake(0, 0, 200, 44)];
    [self.titleView MyCollectionTitleViewClickWithIndex:0];
    self.titleView.delegate = self;
    self.navigationItem.titleView = self.titleView;
    
    self.scrollView.frame = kCommentRect;
    self.scrollView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * 2, 0);
    [self.view addSubview: self.scrollView];

    //配置子控制器
    MyCollection_GoodsVC * goodsVC = [[MyCollection_GoodsVC alloc] init];
    goodsVC.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:goodsVC.view];
    [self addChildViewController:goodsVC];
    
    MyCollection_ShopsVC * shopsVC = [[MyCollection_ShopsVC alloc] init];
    shopsVC.view.frame = CGRectMake(kScreenW, 0, kScreenW, self.scrollView.height);
    [self.scrollView addSubview:shopsVC.view];
    [self addChildViewController:shopsVC];
    
    [self.view addSubview:self.cancelCollectionBtn];
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
//编辑方法
- (void)editAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [[NSNotificationCenter defaultCenter] postNotificationName:kEditNotifiCation object:nil];
    if (sender.selected) {
     [UIView animateWithDuration:0.2 animations:^{
         self.cancelCollectionBtn.transform = CGAffineTransformMakeTranslation(0, -kBottomH);
     } completion:^(BOOL finished) {
         self.scrollView.frame = CGRectMake(0, TopBarHeight, kScreenW, kScreenH - kBottomH - TopBarHeight);
         [[NSNotificationCenter defaultCenter] postNotificationName:kEditFinishNotification object:@(sender.selected)];
     }];
    }else
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.cancelCollectionBtn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.scrollView.frame = kCommentRect;
            [[NSNotificationCenter defaultCenter] postNotificationName:kEditFinishNotification object:@(sender.selected)];
        }];
    }
}
//取消收藏
- (void)cancelCollectionAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCancelCollectionNotification object:nil];
}
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
#pragma mark - lazy
- (UIButton *)cancelCollectionBtn
{
    if (!_cancelCollectionBtn) {
        _cancelCollectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelCollectionBtn.frame = CGRectMake(0, kScreenH, kScreenW, kBottomH);
        _cancelCollectionBtn.titleLabel.font = Font(18);
        [_cancelCollectionBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        [_cancelCollectionBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_cancelCollectionBtn setBackgroundColor:QF_RedColor];
        [_cancelCollectionBtn addTarget:self action:@selector(cancelCollectionAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelCollectionBtn;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
