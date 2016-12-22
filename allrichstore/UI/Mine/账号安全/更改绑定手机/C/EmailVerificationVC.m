//
//  EmailVerificationVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/24.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "EmailVerificationVC.h"
#import "NewPhoneVC.h"
#define kButtonW 95.0f
@interface EmailVerificationVC ()
/**  email */
@property(nonatomic,strong) UITextField * emailTextF;
/**  code */
@property(nonatomic,strong) UITextField * codeTextF;
/**  getcode */
@property(nonatomic,strong) UIButton * getCodeBtn;
/**  next */
@property(nonatomic,strong) UIButton * nextButton;
@end

@implementation EmailVerificationVC

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
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(kBottomH);
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
- (void)setup
{
    UIView *backView1 = [[UIView alloc] init];
    [self setupBackViewWithView:backView1];
    [self.view addSubview:backView1];
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(TopBarHeight);
        make.height.offset(kBottomH);
    }];
    
    UIView *backView2 = [[UIView alloc] init];
    [self setupBackViewWithView:backView2];
    [self.view addSubview:backView2];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(backView1.mas_bottom);
        make.height.offset(kBottomH);
    }];
    
    self.emailTextF = [[UITextField alloc] init];
    [self setupTextFieldWithTextField:self.emailTextF PlaceHolder:String(@"请输入您的邮箱地址")];
    [backView1 addSubview:self.emailTextF];
    [self.emailTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(kMargin);
        make.right.offset(- kMargin);
    }];
    
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getCodeBtn addLeftLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self.getCodeBtn setTitle:String(@"获取验证码") forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = Font_Min;
    [self.getCodeBtn setTitleColor:QF_RedColor forState:UIControlStateNormal];
    [self.getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside
     ];
    [backView2 addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.width.offset(kButtonW);
    }];
    
    self.codeTextF = [[UITextField alloc] init];
    [self setupTextFieldWithTextField:self.codeTextF PlaceHolder:String(@"请输入验证码")];
    [backView2 addSubview:self.codeTextF];
    [self.codeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(kMargin);
        make.right.equalTo(self.getCodeBtn.mas_left).offset(- kMargin);
    }];
    
    [self.view addSubview:self.nextButton];
    
}
- (void)setupBackViewWithView:(UIView *)view
{
    view.backgroundColor = kWhiteColor;
    [view addTopLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}
- (void)setupTextFieldWithTextField:(UITextField *)textField PlaceHolder:(NSString *)placeholder
{
    textField.placeholder = placeholder;
    textField.font = Font_Mid;
    textField.textColor = QF_BlackColor;
}
#pragma mark - handle action
//点击获取验证码
- (void)getCodeAction:(UIButton *)sender
{
    [Tools countdownButton:sender timeout:60 originalTitle:String(@"获取验证码") timingTitle:@""];
}
//下一步
- (void)nextAction
{
    NewPhoneVC *newVC = [[NewPhoneVC alloc] init];
    [self.navigationController pushVC:newVC animated:YES];
}
#pragma mark - lazy
- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setTitle:String(@"下一步") forState:UIControlStateNormal];
        [_nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside
         ];
        [_nextButton setBackgroundColor:QF_RedColor];
    }
    return _nextButton;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
