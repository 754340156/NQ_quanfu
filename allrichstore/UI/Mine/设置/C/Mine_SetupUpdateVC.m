//
//  Mine_SetupUpdateVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Mine_SetupUpdateVC.h"

@interface Mine_SetupUpdateVC ()
/**  当前版本 */
@property(nonatomic,strong) UILabel * versionLabel;
/**  更新按钮 */
@property(nonatomic,strong) UIButton * updateButton;
@end

@implementation Mine_SetupUpdateVC

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
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, TopBarHeight, kScreenW, 120)];
    backView.backgroundColor = kWhiteColor;
    [self.view addSubview:backView];
    [backView addSubview:self.versionLabel];
    self.versionLabel.text = [NSString stringWithFormat:@"%@:V%@",String(@"当前版本"),@"1.1.1"];
#warning 请求出当前版本
    [backView addSubview:self.updateButton];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.top.equalTo(backView.mas_top).offset(30);
    }];
    
    [self.updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.bottom.equalTo(backView.mas_bottom).offset(-10);
        make.size.mas_offset(CGSizeMake(70, 25));
    }];
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
- (void)upadateAction
{
    //去跳转更新
}
#pragma mark - settet model
- (UILabel *)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc] init];
        [_versionLabel sizeToFit];
        _versionLabel.font = Font_Mid;
        _versionLabel.textColor = QF_BlackColor;
    }
    return _versionLabel;
}
- (UIButton *)updateButton
{
    if (!_updateButton) {
        _updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _updateButton.layer.masksToBounds = YES;
        _updateButton.titleLabel.font = Font_Mid;
        [_updateButton setTitleColor:QF_GrayColor forState:UIControlStateNormal];
        [_updateButton setTitle:String(@"更新") forState:UIControlStateNormal];
        _updateButton.layer.cornerRadius = 5.0f;
        _updateButton.layer.borderColor = QF_GrayColor.CGColor;
        _updateButton.layer.borderWidth = 1.0f;
        [_updateButton addTarget:self action:@selector(upadateAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateButton;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
