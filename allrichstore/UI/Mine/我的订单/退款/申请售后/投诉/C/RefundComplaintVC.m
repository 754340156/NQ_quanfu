//
//  RefundComplaintVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RefundComplaintVC.h"
#import "RefundComplaintView.h"
@interface RefundComplaintVC ()
/**  backView */
@property(nonatomic,strong) RefundComplaintView * backView;
@end

@implementation RefundComplaintVC

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
    [self addRightTitle:@"提交" action:@selector(submitAction)];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    self.backView = [[RefundComplaintView alloc] initWithFrame:kCommentRect];
    self.backView.model = self.model;
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
//提交
- (void)submitAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - lazy
- (RefundDetailApplyModel *)model
{
    if (!_model) {
        _model = [[RefundDetailApplyModel alloc] init];
    }
    return _model;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
