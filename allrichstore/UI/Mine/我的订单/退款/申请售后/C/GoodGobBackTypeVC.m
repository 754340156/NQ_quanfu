//
//  GoodGobBackTypeVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodGobBackTypeVC.h"
#import "GoodGobBackTypeView.h"
#import "MyOrderSubmitSuccessVC.h"
@interface GoodGobBackTypeVC ()<GoodGobBackTypeViewDelegate>
/**  <#注释#> */
@property(nonatomic,strong) GoodGobBackTypeView * backView;
@end

@implementation GoodGobBackTypeVC

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
    self.backView = [[GoodGobBackTypeView alloc] initWithFrame:kCommentRect Contact:@"米洛洛" Phone:@"18890998066" GobackTypeArray:@[@"快递至卖家",@"快递至卖家",@"快递至卖家",@"快递至卖家",@"快递至卖家"]];
    self.backView.delegate = self;
    [self.view addSubview:self.backView];
    
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
#pragma mark - GoodGobBackTypeViewDelegate
//提交
- (void)GoodGobBackTypeViewDelegate_clickSubmitWithPerson:(NSString *)person Phone:(NSString *)phone type:(NSString *)type
{
    MyOrderSubmitSuccessVC *successVC =[[MyOrderSubmitSuccessVC alloc] init];
    [self.navigationController pushVC:successVC animated:YES];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
