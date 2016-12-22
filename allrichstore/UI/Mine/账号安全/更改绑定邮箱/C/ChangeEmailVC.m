//
//  ChangeEmailVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ChangeEmailVC.h"
#import "ChangeEmailView.h"
@interface ChangeEmailVC ()<ChangeEmailViewDelegate>
/**  view */
@property(nonatomic,strong) ChangeEmailView * emailView;
/**  保存发过来的验证码 */
@property(nonatomic,copy) NSString * code;
@end

@implementation ChangeEmailVC

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
    [self.view addSubview:self.emailView];
    
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
    
}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - ChangeEmailViewDelegate
- (void)ChangeEmailViewDelegate_clickVerificationCodeBtnWithButton:(UIButton *)sender
{
    //发验证码
    if ([NSString isEmpty:self.emailView.passwordTF.text]) {
        [self.view showToastMsg:@"邮箱不能为空"];
        return;
    }
    
    if (![self.emailView.passwordTF.text isEmailAddress]) {
        [self.view showToastMsg:@"不是正确的邮箱格式"];
        return;
    }
    NSDictionary *parameters = @{@"u_account":self.emailView.passwordTF.text};
    WS(weakSelf)
    [self POST:API_SendCode parameters:parameters success:^(NSDictionary *dic) {
        
        [weakSelf.view showToastMsg:dic[@"errorMessage"]];
        weakSelf.code = dic[@"response"];
        [Tools countdownButton:sender timeout:60 originalTitle:String(@"获取验证码") timingTitle:@""];
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}
//完成
- (void)ChangeEmailViewDelegate_clickFinishButton
{
    //修改
    
    if (![self.emailView.passwordTF.text isEmailAddress]) {
        [self.view showToastMsg:@"不是正确的邮箱格式"];
        return;
    }
    if ([NSString isEmpty:self.emailView.verificationCodeTF.text]) {
        [self.view showToastMsg:@"验证码不能为空"];
        return;
    }
    //验证验证码
    if (![self.emailView.verificationCodeTF.text isEqualToString:self.code]) {
        [self.view showToastMsg:@"验证码不正确"];
        return;
    }
    //转化为json格式
    NSDictionary *dic = @{@"id":[Single getUserModel].ID,@"uEmail":self.emailView.passwordTF.text};
    NSDictionary *parameters = @{@"param":[NSString StringDicWithDic:dic]};
    [self POST:API_MineModifyUser parameters:parameters success:^(NSDictionary *dic) {
        
        [Tools showToastMsg:@"设置成功" completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];

    } fail:^(NSError *error) {
    
    } sendView:nil animSuperView:self.view animated:YES];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}
#pragma mark - lazy
- (ChangeEmailView *)emailView
{
    if (!_emailView) {
        _emailView = [[ChangeEmailView alloc] initWithFrame:kCommentRect];
        _emailView.delegate = self;
    }
    return _emailView;
}

@end
