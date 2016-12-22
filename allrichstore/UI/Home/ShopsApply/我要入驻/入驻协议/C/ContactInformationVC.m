//
//  ContactInformationVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ContactInformationVC.h"
#import "ConpanyInformationVC.h"
#import "ContactInformationView.h"
@interface ContactInformationVC ()<ContactInformationViewDelegate>
/**  view */
@property(nonatomic,strong) ContactInformationView * backView;
@end

@implementation ContactInformationVC

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
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    self.backView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ContactInformationView class]) owner:nil options:nil].lastObject;
    self.backView.frame = kCommentRect;
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

#pragma mark - ContactInformationViewDelegate
- (void)ContactInformationViewDelegate_clickNext
{
    ConpanyInformationVC *VC = [[ConpanyInformationVC alloc] init];
    [self.navigationController pushVC:VC animated:YES];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
