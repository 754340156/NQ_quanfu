//
//  NewBrandVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "NewBrandVC.h"
#import "NewBrandView.h"
#import "NewBrandModel.h"
@interface NewBrandVC ()<NewBrandViewDelegate>
/**  backView */
@property(nonatomic,strong) NewBrandView * backView;
/**  model */
@property(nonatomic,strong) NewBrandModel * model;
@end

@implementation NewBrandVC

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
    self.backView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NewBrandView class]) owner:nil options:nil].lastObject;
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
#pragma mark - NewBrandViewDelegate
- (void)NewBrandViewDelegate_clickSave
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - lazy
- (NewBrandModel *)model
{
    if (!_model) {
        _model = [[NewBrandModel alloc] init];
    }
    return _model;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
