//
//  NewPhoneVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/24.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "NewPhoneVC.h"
#import "ReviseSuccessVC.h"
#import "VerificationPhonePopView.h"
@interface NewPhoneVC ()<VerificationPhonePopViewDelegate>
/**  next */
@property(nonatomic,strong) UIButton * nextButton;
/**  textField */
@property(nonatomic,strong) UITextField * textField;
/**  popView */
@property(nonatomic,strong) VerificationPhonePopView * popView;
@end

@implementation NewPhoneVC

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
    [self setup];
    
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

- (void)setup
{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = kWhiteColor;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopBarHeight);
        make.left.right.offset(0);
        make.height.offset(kBottomH);
    }];
    
    [backView addSubview:self.textField];
    [self.view addSubview:self.nextButton];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(kMargin);
        make.right.offset(-kMargin);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(kBottomH);
    }];
}
#pragma mark - handle action
//点击下一步
- (void)nextAction
{
    //先验证手机号是否正确
    if ([NSString isEmpty:self.textField.text]) {
        [self.view showToastMsg:@"手机号不能为空"];
        return;
    }
    if (![self.textField.text isMobileNumber]) {
        [self.view showToastMsg:@"手机号不正确"];
        return;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
    self.popView.phone = self.textField.text;
}
#pragma mark - VerificationPhonePopViewDelegate
//点击确定
- (void)VerificationPhonePopViewDelegate_clickSure:(BOOL)isSure
{
    [self.popView removeFromSuperview];
    if (isSure) {
        //发请求修改手机号
        //转化为json格式
        NSDictionary *dic = @{@"id":[Single getUserModel].ID,@"uPhone":self.textField.text};
        NSDictionary *parameters = @{@"param":[NSString StringDicWithDic:dic]};
        WS(weakSelf)
        [self POST:API_MineModifyUser parameters:parameters success:^(NSDictionary *dic) {
            ReviseSuccessVC *successVC = [[ReviseSuccessVC alloc] init];
            [weakSelf.navigationController pushVC:successVC animated:YES];
        } fail:^(NSError *error) {
            
        } sendView:nil animSuperView:self.view animated:YES];
;
    }
    
}
//点击获取验证码
- (void)VerificationPhonePopViewDelegate_clickGetCodeWithButton:(UIButton *)sender
{
    
}
#pragma mark - lazy
- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setTitle:String(@"下一步") forState:UIControlStateNormal];
        [_nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:QF_RedColor];
        [_nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = Font_Mid;
        _textField.textColor = QF_BlackColor;
        _textField.placeholder = String(@"请输入您的手机号");
    }
    return _textField;
}
- (VerificationPhonePopView *)popView
{
    if (!_popView) {
        _popView = [[VerificationPhonePopView alloc] initWithFrame:self.view.bounds];
        _popView.superViewController = self;
        _popView.backgroundColor = Color_Translucent;
 //默认电话
        _popView.phone = [Single getUserModel].uPhone;
        _popView.delegate = self;
    }
    return _popView;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
