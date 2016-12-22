//
//  OrderPaySuccessVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "OrderPaySuccessVC.h"
#import "OrderPaySuccessView.h"
@interface OrderPaySuccessVC ()<OrderPaySuccessViewDelegate>
/**  view */
@property(nonatomic,strong) OrderPaySuccessView * successView;
@end

@implementation OrderPaySuccessVC
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
    [self.view addSubview:self.successView];
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

#pragma mark - OrderPaySuccessViewDelegate
//订单详情
- (void)OrderPaySuccessViewDelegate_cliclOrderDetailBtn
{
    
}
//立即评论
- (void)OrderPaySuccessViewDelegate_clickCommentButton
{
    
}
#pragma mark - dealloc
- (void)dealloc
{
    
}
- (OrderPaySuccessView *)successView
{
    if (!_successView) {
        _successView = [[OrderPaySuccessView alloc] initWithFrame:kCommentRect];
        _successView.delegate = self;
    }
    return _successView;
}

@end
