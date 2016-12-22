//
//  AuthenticationVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AuthenticationVC.h"
#import "Authentication_UploadVC.h"
#import "Authentication_HomeView.h"
@interface AuthenticationVC ()<Authentication_HomeViewDelegate>
/**  homeView */
@property(nonatomic,strong) Authentication_HomeView * homeView;
@end

@implementation AuthenticationVC

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
    self.homeView = [[Authentication_HomeView alloc] initWithFrame:kCommentRect];
    self.homeView.delegate = self;
    [self.view addSubview:self.homeView];
    
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

#pragma mark - Authentication_HomeViewDelegate
- (void)Authentication_HomeViewDelegate_clickNextButton
{
    Authentication_UploadVC *uploadVC = [[Authentication_UploadVC alloc] init];
    [self.navigationController pushVC:uploadVC animated:YES];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
