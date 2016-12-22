//
//  RegisterVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RegisterVC.h"         //注册
#import "SetupPwVC.h"          //设置密码

@interface RegisterVC ()

//是否服从全富注册协议
@property (nonatomic, strong) UIButton *isAgreeProtocolBtn;
//查看全富注册协议
@property (nonatomic, strong) QButton *lookProtocolBtn;

@end

@implementation RegisterVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.placeholderArray = @[String(@"请输入手机号"), String(@"请输入验证码")];
    self.nextBtnTitle = String(@"同意并注册");
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    self.title = String(@"手机快速注册");
    //添加右侧的登录按钮
    [self addRightTitle:String(@"登录") action:@selector(handleLogin)];
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];

    //
    UIView *verifiSuperview = self.verifiCodeTF.superview;
    UIView *supView = [[UIView alloc] initWithFrame:CGRectMake(verifiSuperview.left, verifiSuperview.bottom + 5, self.view.width - verifiSuperview.left * 2.0, 36)];
    [self.bgScrollView addSubview:supView];
    
    [supView addSubview:self.isAgreeProtocolBtn];
    [supView addSubview:self.lookProtocolBtn];
    [self.isAgreeProtocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(30);
    }];
    
    [self.lookProtocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_isAgreeProtocolBtn.mas_right).offset(3);
        make.top.offset(0);
        make.bottom.offset(0);
        make.right.offset(0);
        
    }];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - lazy
- (UIButton *)isAgreeProtocolBtn
{
    if (!_isAgreeProtocolBtn)
    {
        self.isAgreeProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_isAgreeProtocolBtn setImage:Image(@"xuanze_weixuan") forState:UIControlStateNormal];
        [_isAgreeProtocolBtn setImage:Image(@"xuanze_yixuan") forState:UIControlStateSelected];
        [_isAgreeProtocolBtn addTarget:self action:@selector(handleIsAgreeProtocolBtn:) forControlEvents:UIControlEventTouchUpInside];
        _isAgreeProtocolBtn.selected = YES;
    }
    return _isAgreeProtocolBtn;
}

- (QButton *)lookProtocolBtn
{
    if (!_lookProtocolBtn)
    {
        self.lookProtocolBtn = [[QButton alloc] initWithFrame:CGRectZero layoutStyle:QButtonLayoutStyleLeft font:Font(15) title:String(@"同意全富用户注册协议") autoSize:NO];
        [_lookProtocolBtn addTarget:self action:@selector(handleLookProtocolBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lookProtocolBtn;
}

#pragma mark - request data
//注册下一步的网络请求
- (void)requestNextstep
{
    //判断是否同意了全富用户协议
    if (_isAgreeProtocolBtn.selected)
    {
        NSDictionary *parameters = @{@"clientCode":self.verifiCodeTF.text};
        [self POST:API_ClientCode parameters:parameters success:^(NSDictionary *dic) {
            
            //下一步请求
            SetupPwVC *setupPwVC = [SetupPwVC new];
            setupPwVC.title = String(@"同意并注册");
            [self.navigationController pushVC:setupPwVC animated:YES];
            //[self.view showToastMsg:nil];
            
        } fail:^(NSError *error) {
            
            
        } sendView:nil animSuperView:self.view animated:YES];
    }
    else
    {
        [self.view showToastMsg:String(@"您还没有同意全富用户注册协议哦！")];
    }
}

#pragma mark - custom method


#pragma mark - handle action
//导航条右侧登录按钮 -- 触发事件
- (void)handleLogin
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//是否同意全富注册协议 -- 触发事件
- (void)handleIsAgreeProtocolBtn:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

//查看全富注册协议 -- 触发协议
- (void)handleLookProtocolBtn:(UIButton *)btn
{
    //跳转至用户协议页面
    BaseVC *webVC = [BaseVC new];
    webVC.webViewUrl = @"https://www.baidu.com/";
    webVC.title = String(@"全富用户注册协议");
    BaseNC *webNC = [[BaseNC alloc] initWithBackBtnStyleRootViewController:webVC];
    [self presentVC:webNC animated:YES completion:nil];
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
