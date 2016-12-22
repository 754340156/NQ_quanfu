//
//  ForgetPwVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ForgetPwVC.h"      //忘记密码
#import "ResetPwVC.h"       //重置密码

//通过修改此函数可选择：是否按比例适配
#define ForgetAdapted(x)     Adapted(x)
//#define ForgetAdapted(x)     x

#pragma mark - 布局参数
//输入框上边距
#define kMargin_top_tfs            (ForgetAdapted(20) + 0)
//输入框左右间距
#define kMargin_left_tfs            ForgetAdapted(12)
//下一步按钮的左右间距
#define kMargin_left_nextBtn        kMargin_left_tfs


//输入框的高度
#define kHeight_tfs                 ForgetAdapted(50)
//下一步按钮的高度
#define kHeight_loginBtn            ForgetAdapted(48)
//获取验证码按钮的宽度
#define kWidth_verifiCode           ForgetAdapted(96)

//输入框之间的垂直间距
#define kSpace_vertical_tfs         ForgetAdapted(18)
//输入框与下一步按钮之间的垂直距离
#define kSpace_vertical_tf_nextBtn  ForgetAdapted(90)

//输入框leftVew的图标的左间距
#define kMargin_left_leftViewImage  ForgetAdapted(16)
//输入框leftVew的图标的左间距
#define kMargin_right_leftViewImage ForgetAdapted(8)

#pragma mark - 字体参数
//输入框的字体
#define kFont_tfs               Font(ForgetAdapted(17))
//登录按钮标题的字体
#define kFont_loginBtnTitle     Font(ForgetAdapted(18))


#pragma mark - 颜色配置
//输入框的文字颜色
#define kTextColor_tfs          QF_BlackColor
//下一步按钮的背景颜色
#define kColor_nextBtnBg       QF_RedBtnColor

#pragma mark - 图片配置
//账号(图标名称)
#define kImageString_account      @""
//验证码(图标名称)
#define kImageString_password     @""


//登录界面的背景(图片名称)
#define kImageString_loginBgImage @""

#pragma mark - 开关
//是否开启弹性
#define kIsHaveBounce    0
//是否拥有背景图片
#define kIsHaveBgImage   0

@interface ForgetPwVC ()<UITextFieldDelegate>

//背景图片ImageView（可设置登录界面的背景图片）
@property (nonatomic, strong) UIImageView *bgImageView;

@end


@implementation ForgetPwVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.placeholderArray = @[String(@"手机号／邮箱"), String(@"请输入验证码")];
    self.nextBtnTitle = String(@"下一步");
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
#if kIsHaveBgImage
    //创建背景图片控件
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:kImageString_loginBgImage];
    [self.view addSubview:bgImageView];
#endif
    
    //创建scrollVew作为父视图
    self.bgScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_bgScrollView];
    //开启弹性
#if kIsHaveBounce
    _bgScrollView.alwaysBounceVertical = YES;
#endif
    
    //创建账号和密码输入框
    CGFloat tfTop = kMargin_top_tfs;
    for (int i = 0; i < 2; i++)
    {
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(kMargin_left_tfs, tfTop, _bgScrollView.width - kMargin_left_tfs * 2.0, kHeight_tfs)];
        whiteView.clipsToBounds = YES;
        whiteView.layer.cornerRadius = whiteView.height / 2.0;
        whiteView.backgroundColor = kWhiteColor;
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, whiteView.width - Adapted(20), whiteView.height)];
        if (i == 0) {
            self.accountTF = tf;
            tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        } else {
            //创建验证码
            CodeButton *codeBtn = [CodeButton buttonWithType:UIButtonTypeSystem];
            [codeBtn setTitle:String(@"获取验证码") forState:UIControlStateNormal];
            [codeBtn setTitleColor:QF_RedColor forState:UIControlStateNormal];
            
            codeBtn.titleLabel.font = [UIFont systemFontOfSize:ForgetAdapted(13)];
            codeBtn.frame = CGRectMake(whiteView.width - kWidth_verifiCode, 0, kWidth_verifiCode, whiteView.height);
            //获取验证码点击的 -- 触发事件
            WS(weakSelf)
            [codeBtn addToucheHandler:^(CodeButton *codeButton, NSInteger tag) {
                
                [weakSelf sendVerifiCodeWith:codeButton];
            }];
            [codeBtn didFinished:^NSString *(CodeButton *codeButton, int second) {
                return @"重新发送";
            }];
            [whiteView addSubview:codeBtn];
            
            //添加分割线
            [codeBtn addLeftLineWithColor:[UIColor colorWithWhite:0.86 alpha:1.0] width:1.0 margin:ForgetAdapted(15) style:LineLayoutStyleInside];
            
            self.verifiCodeTF = tf;
            tf.frame = CGRectMake(0, 0, whiteView.width - Adapted(20) - codeBtn.width, whiteView.height);
            tf.keyboardType = UIKeyboardTypeNumberPad;
        }
        tfTop = whiteView.bottom + kSpace_vertical_tfs;
        tf.delegate = self;
        tf.textColor = kTextColor_tfs;
        tf.font = kFont_tfs;
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.attributedPlaceholder = [NSAttributedString attributedStringWithString:self.placeholderArray[i] color:kGrayColor];
        
        UIButton *leftView = [UIButton new];
        leftView.userInteractionEnabled = NO;
        leftView.frame = CGRectMake(0, 0, kMargin_left_leftViewImage + kMargin_right_leftViewImage, tf.height);
        CGFloat offX = (kMargin_left_leftViewImage - kMargin_right_leftViewImage) / 2.0;
        [leftView setImageEdgeInsets:UIEdgeInsetsMake(0, offX, 0, -offX)];
        tf.leftView = leftView;
        [whiteView addSubview:tf];
        
        [_bgScrollView addSubview:whiteView];
    }
    
    //下一步按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.frame = CGRectMake(kMargin_left_nextBtn, _verifiCodeTF.superview.bottom + kSpace_vertical_tf_nextBtn, _bgScrollView.width - kMargin_left_nextBtn * 2.0, kHeight_loginBtn);
    nextBtn.backgroundColor = kColor_nextBtnBg;
    [nextBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = nextBtn.height / 2.0;
    nextBtn.titleLabel.font = kFont_loginBtnTitle;
    [nextBtn setTitle:_nextBtnTitle forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(handleNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:nextBtn];
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

//获取验证码的网络请求
- (void)sendVerifiCodeWith:(CodeButton *)btn
{
    BOOL isForgetPwVC = [self isMemberOfClass:[ForgetPwVC class]];
    BOOL isSuccessFormat = isForgetPwVC ? ([_accountTF.text isMobileNumber] || [_accountTF.text isEmailAddress]) : [_accountTF.text isMobileNumber];
    //验证手机号和邮箱账号的格式
    if (isSuccessFormat)
    {
        //发送验证码
        NSDictionary *parameters = @{@"u_account":_accountTF.text};
        [NetWork POST:API_SendCode parameters:parameters success:^(NSDictionary *dic) {
            
            [btn startWithSecond:60];
            
        } fail:^(NSError *error) {
            
        } sendView:nil animSuperView:self.view animated:YES];
//        [self POST:API_SendCode parameters:parameters success:^(NSDictionary *dic) {
//            
//            [btn startWithSecond:60];
//            
//        } fail:^(NSError *error) {
//            
//            
//        } sendView:nil animSuperView:self.view animated:YES];
    }
    else
    {
        NSString *formatError = isForgetPwVC ? String_prompt_accoutFormatError : String_prompt_phoneFormatError;
        if (_accountTF.text.length == 0)
        {
            formatError = _accountTF.placeholder;
        }
        [self.view showToastMsg:formatError];
    }
}

//下一步的网络请求
- (void)requestNextstep
{
    //下一步请求
    NSDictionary *parameters = @{@"u_account":_accountTF.text, @"clientCode":_verifiCodeTF.text};
    [self POST:API_ClientCode_FindPW parameters:parameters success:^(NSDictionary *dic) {
        
        ResetPwVC *resetPwVC = [ResetPwVC new];
        resetPwVC.account = _accountTF.text;
        resetPwVC.title = @"忘记密码";
        [self.navigationController pushVC:resetPwVC animated:YES];
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action
//下一步按钮 -- 触发事件
- (void)handleNextBtn:(UIButton *)sender
{
    //验证手机号和邮箱账号的格式
    if ([_accountTF.text isMobileNumber] || [_accountTF.text isEmailAddress])
    {
        //验证验证码的格式
        if (_verifiCodeTF.text.length == Length_verifiCode)
        {
            //下一步的网络请求
            [self requestNextstep];
        }
        else
        {
            //验证码格式不正确
            [self.view showToastMsg:String_prompt_verifiCodeFormatError];
        }
    }
    else
    {
        BOOL isForgetPwVC = [self isMemberOfClass:[ForgetPwVC class]];
        NSString *formatError = isForgetPwVC ? String_prompt_accoutFormatError : String_prompt_phoneFormatError;
        if (_accountTF.text.length == 0)
        {
            formatError = _accountTF.placeholder;
        }
        [self.view showToastMsg:formatError];
    }
}

#pragma mark - <UITextFieldDelegate>
//字符限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _accountTF)
    {   //账号输入框
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 32)
        {
            return NO;
        }
    }
    else
    {   //验证码码输入框
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > Length_verifiCode)
        {
            return NO;
        }
    }
    return YES;
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
