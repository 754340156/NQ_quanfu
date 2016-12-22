//
//  MyOrderSubmitSuccessVc.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderSubmitSuccessVC.h"
#import "MyOrderSubmitSuccessView.h"
@interface MyOrderSubmitSuccessVC ()<MyOrderSubmitSuccessViewDelegate>
/**  view */
@property(nonatomic,strong) MyOrderSubmitSuccessView * successView;
@end

@implementation MyOrderSubmitSuccessVC

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

#pragma mark - MyOrderSubmitSuccessViewDelegate
//查看进度
- (void)MyOrderSubmitSuccessViewDelegate_clickProgressSearch
{
    
}
//售后首页
- (void)MyOrderSubmitSuccessViewDelegate_clickHome
{
    
}
#pragma mark - dealloc
- (void)dealloc
{
    
}
#pragma mark -  lazy
- (MyOrderSubmitSuccessView *)successView
{
    if (!_successView) {
        _successView = [[MyOrderSubmitSuccessView alloc] initWithFrame:kCommentRect];
        _successView.time = @"2016-10-19";
        _successView.delegate = self;
    }
    return _successView;
}

@end
