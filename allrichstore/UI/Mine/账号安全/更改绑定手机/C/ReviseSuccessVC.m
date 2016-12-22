//
//  ReviseSuccessVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/24.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ReviseSuccessVC.h"

@interface ReviseSuccessVC ()
/**  successLabel */
@property(nonatomic,strong) UILabel * successLabel;
@end

@implementation ReviseSuccessVC

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
    self.successLabel.text = String(@"设置成功");
    
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

#pragma mark - lazy
- (UILabel *)successLabel
{
    if (!_successLabel) {
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = kWhiteColor;
        [self.view addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(TopBarHeight);
            make.left.right.offset(0);
            make.height.offset(150);
        }];
        _successLabel = [[UILabel alloc] init];
        _successLabel.font = Font_Mid;
        _successLabel.textColor = QF_BlackColor;
        [_successLabel sizeToFit];
        [backView addSubview:_successLabel];
        [_successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.offset(0);
        }];
    }
    return _successLabel;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
