//
//  ThirdPartyBindingVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ThirdPartyBindingVC.h"
#import "ThirdPartyBindingView.h"
@interface ThirdPartyBindingVC ()<ThirdPartyBindingViewDelegate>
/**  view */
@property(nonatomic,strong) ThirdPartyBindingView * bindingView;
@end

@implementation ThirdPartyBindingVC

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
#pragma mark - ThirdPartyBindingViewDelegate
- (void)ThirdPartyBindingViewDelegate_clickCancelBinding
{
    
}
#pragma mark - lazy
- (ThirdPartyBindingView *)bindingView
{
    if (!_bindingView) {
        _bindingView = [[ThirdPartyBindingView alloc] initWithFrame:kCommentRect];
        _bindingView.delegate = self;
    }
    return _bindingView;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
