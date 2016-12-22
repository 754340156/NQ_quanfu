//
//  ContractSigningVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ContractSigningVC.h"
#import "ContractSigningFirstView.h"
#import "ContractSigningSecondView.h"
@interface ContractSigningVC ()
/**  <#注释#> */
@property(nonatomic,strong) ContractSigningFirstView * firstView;
/**  <#注释#> */
@property(nonatomic,strong) ContractSigningSecondView * secondView;
@end

@implementation ContractSigningVC

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
//    if () {
        self.firstView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ContractSigningFirstView class]) owner:nil options:nil].lastObject;
        self.firstView.frame = kCommentRect;
        [self.view addSubview:self.firstView];
//    }else
//    {
//        self.secondView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ContractSigningSecondView class]) owner:nil options:nil].lastObject;
//        self.secondView.frame = kCommentRect;
//        [self.view addSubview:self.secondView];
//    }
//    
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


#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
