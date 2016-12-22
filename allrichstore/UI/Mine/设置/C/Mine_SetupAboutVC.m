//
//  Mine_SetupAboutVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Mine_SetupAboutVC.h"

@interface Mine_SetupAboutVC ()
/**  label */
@property(nonatomic,strong) UILabel * textLabel;
@end

@implementation Mine_SetupAboutVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.view.backgroundColor = QFColor_CoodsClassMenuViewBg;
    
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
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textColor = QF_BlackColor;
    self.textLabel.backgroundColor = kWhiteColor;
    self.textLabel.numberOfLines = 0;
    self.textLabel.font = Font_Mid;
    self.textLabel.text = @"会员级别分为五个等级，分别为：注册会员、铜牌会员、银牌会员、金牌会员、钻石会员，会员级别的升降均由系统处理，无需申请。会员级别分为五个等级，分别为：注册会员、铜牌会员、银牌会员、金牌会员、钻石会员，会员级别的升降均由系统处理，无需申请。会员级别分为五个等级，分别为：注册会员、铜牌会员、银牌会员、金牌会员、钻石会员，会员级别的升降均由系统处理，无需申请。会员级别分为五个等级，分别为：注册会员、铜牌会员、银牌会员、金牌会员、钻石会员，会员级别的升降均由系统处理，无需申请。会员级别分为五个等级，分别为：注册会员、铜牌会员、银牌会员、金牌会员、钻石会员，会员级别的升降均由系统处理，无需申请。会员级别分为五个等级，分别为：注册会员、铜牌会员、银牌会员、金牌会员、钻石会员，会员级别的升降均由系统处理，无需申请。";
    [self.view addSubview:self.textLabel];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(TopBarHeight);
        make.height.offset([UILabel getHeightWithFont:self.textLabel.font Width:kScreenW text:self.textLabel.text]);
    }];
    
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
