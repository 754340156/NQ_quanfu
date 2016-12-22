//
//  ShopsApplyPaymentVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopsApplyPaymentVC.h"
#import "ShopsApplyPaymentView.h"
@interface ShopsApplyPaymentVC ()
/**  backView */
@property(nonatomic,strong) ShopsApplyPaymentView * backView;
@end

@implementation ShopsApplyPaymentVC
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
    self.backView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([ShopsApplyPaymentView class]) owner:nil options:nil].lastObject;
    self.backView.frame = kCommentRect;
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


#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
