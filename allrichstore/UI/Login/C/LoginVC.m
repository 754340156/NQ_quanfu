//
//  LoginVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "LoginVC.h"         //登录
#import "ForgetPwVC.h"      //忘记密码
#import "RegisterVC.h"      //注册
#import "ThirdLoginVC.h"    //第三方登录
#import "HobbyModel.h"      //爱好model
#import "ProfessionModel.h" //职业model

//通过修改此函数可选择：是否按比例适配
#define LoginAdapted(x)     Adapted(x)
//#define LoginAdapted(x)     x

#pragma mark - 布局参数
//输入框上边距
#define kMargin_top_tfs            (LoginAdapted(20) + 0)
//输入框左右间距
#define kMargin_left_tfs            LoginAdapted(12)
//登录按钮的左右间距
#define kMargin_left_loginBtn       kMargin_left_tfs
//第三方登录按钮的宽高
#define kWidth_thirdBtn             120
#define kHeight_thirdBtn            90
//第三方登录按钮的下间距
#define kMargn_bottom_thirdBtn      LoginAdapted(40)
//第三方登录按钮的左右边距
#define kMargin_level_thirdBtn  (((_bgScrollView.width - 2 * kWidth_thirdBtn) / 3.0) + Adapted(10))
//第三方按钮的水平间距
#define kSpace_level_thirdBtn  (((_bgScrollView.width - 2 * kWidth_thirdBtn) / 3.0) - Adapted(20))

//输入框的高度
#define kHeight_tfs                  LoginAdapted(50)
//登录按钮的高度
#define kHeight_loginBtn             LoginAdapted(48)
//忘记密码的高度
#define kHeight_forgetBtn            LoginAdapted(36)

//输入框之间的垂直间距
#define kSpace_vertical_tfs          LoginAdapted(18)
//输入框与登录按钮之间的垂直距离
#define kSpace_vertical_tf_loginBtn  LoginAdapted(90)
//登录按钮与忘记密码之间的垂直距离
#define kSpace_vertical_login_forget LoginAdapted(10)

//输入框leftVew的图标的左间距
#define kMargin_left_leftViewImage   LoginAdapted(18)
//输入框leftVew的图标的左间距
#define kMargin_right_leftViewImage  LoginAdapted(10)

#pragma mark - 字体参数
//输入框的字体
#define kFont_tfs               Font(LoginAdapted(17))
//登录按钮标题的字体
#define kFont_loginBtnTitle     Font(LoginAdapted(18))
//忘记密码按钮标题的字体
#define kFont_forgetBtnTitle    Font(LoginAdapted(15))
//第三方登录label的字体
#define kFont_thirdLabel        Font(13)

#pragma mark - 颜色配置
//输入框的文字颜色
#define kTextColor_tfs          QF_BlackColor
//登录按钮的背景颜色
#define kColor_LoginBtnBg       QF_RedBtnColor

#pragma mark - 图片配置
//账号(图标名称)
#define kImageString_account      @"denglu_shoujihao"
//密码(图标名称)
#define kImageString_password     @"denglu_mima"

//密码可见(图标名称)
#define kImageString_pwShow     @"kejian"
//密码不可见(图标名称)
#define kImageString_pwHidden   @"bukejian"

/***第三方登录***/
//QQ(图标名称)
#define kImageString_qq           @"qqdenglu"
//微信(图标名称)
#define kImageString_weiChat      @"weixindenglu"
//登录界面的背景(图片名称)
#define kImageString_loginBgImage @""

#pragma mark - 开关
//是否开启弹性
#define kIsHaveBounce       0
//是否拥有背景图片
#define kIsHaveBgImage      0

@interface LoginVC ()<UITextFieldDelegate>

//背景图片ImageView（可设置登录界面的背景图片）
@property (nonatomic, strong) UIImageView *bgImageView;
//所有登录控件的父视图（设置弹性方便）
@property (nonatomic, strong) UIScrollView *bgScrollView;
//账号输入框
@property (nonatomic, strong) UITextField *accountTF;
//密码输入框
@property (nonatomic, strong) UITextField *passwordTF;

@end

@implementation LoginVC

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
    
    
    self.title = String(@"登录");
    //添加导航条右侧的注册按钮
    [self addRightTitle:String(@"注册") action:@selector(handleRegister)];
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
    NSArray *placeholderArray = @[String(@"请输入手机号／邮箱"), String(@"请输入您的密码")];
    
    NSArray *leftViewImageArray = @[Image(kImageString_account), Image(kImageString_password)];
    for (int i = 0; i < 2; i++)
    {
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(kMargin_left_tfs, tfTop, _bgScrollView.width - kMargin_left_tfs * 2.0, kHeight_tfs)];
        whiteView.clipsToBounds = YES;
        whiteView.layer.cornerRadius = whiteView.height / 2.0;
        whiteView.backgroundColor = kWhiteColor;
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, whiteView.width - Adapted(18), whiteView.height)];
        if (i == 0) {
            self.accountTF = tf;
            tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }else {
            self.passwordTF = tf;
            tf.secureTextEntry = YES;
            tf.keyboardType = UIKeyboardTypeDefault;
        }
        tfTop = whiteView.bottom + kSpace_vertical_tfs;
        tf.delegate = self;
        tf.textColor = kTextColor_tfs;
        tf.font = kFont_tfs;
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.rightViewMode = UITextFieldViewModeAlways;
        tf.attributedPlaceholder = [NSAttributedString attributedStringWithString:placeholderArray[i] color:kGrayColor];
        
        UIButton *leftView = [UIButton new];
        leftView.userInteractionEnabled = NO;
        UIImage *leftImage = leftViewImageArray[i];
        [leftView setImage:leftImage forState:UIControlStateNormal];
        leftView.frame = CGRectMake(0, 0, leftImage.size.width + kMargin_left_leftViewImage + kMargin_right_leftViewImage, leftImage.size.height);
        CGFloat offX = (kMargin_left_leftViewImage - kMargin_right_leftViewImage) / 2.0;
        [leftView setImageEdgeInsets:UIEdgeInsetsMake(0, offX, 0, -offX)];
        tf.leftView = leftView;
        [whiteView addSubview:tf];
        
        if (i == 1)
        {
            //如果是密码输入框（添加密码是否可见按钮）
            UIButton *rightBtn = [UIButton new];
            rightBtn.frame = CGRectMake(0, 0, 30, 30);
            [rightBtn setImage:Image(kImageString_pwHidden) forState:UIControlStateNormal];
            [rightBtn setImage:Image(kImageString_pwShow) forState:UIControlStateSelected];
            [rightBtn addTarget:self action:@selector(handleRightBtn:) forControlEvents:UIControlEventTouchUpInside];
            tf.rightView = rightBtn;
        }
        
        [_bgScrollView addSubview:whiteView];
    }
    
    
    //创建登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame = CGRectMake(kMargin_left_loginBtn, _passwordTF.superview.bottom + kSpace_vertical_tf_loginBtn, _bgScrollView.width - kMargin_left_loginBtn * 2.0, kHeight_loginBtn);
    loginBtn.backgroundColor = kColor_LoginBtnBg;
    [loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = loginBtn.height / 2.0;
    loginBtn.titleLabel.font = kFont_loginBtnTitle;
    [loginBtn setTitle:String(@"登录") forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(handleLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:loginBtn];
    
    //忘记密码按钮
    QButton *forgetPW = [QButton buttonWithType:UIButtonTypeSystem];
    CGFloat forgetWidth = Adapted(80);
    forgetPW.frame = CGRectMake(_bgScrollView.width - forgetWidth - kMargin_left_loginBtn, loginBtn.bottom+ 5, forgetWidth, kHeight_forgetBtn);
    forgetPW.titleLabel.font = kFont_forgetBtnTitle;
    [forgetPW setTitleColor:kGrayColor forState:UIControlStateNormal];
    [forgetPW setTitle:String(@"忘记密码？") forState:UIControlStateNormal];
    forgetPW.layoutStyle = QButtonLayoutStyleRight;
    [forgetPW addTarget:self action:@selector(handleForgetPW:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:forgetPW];
    
    //创建第三放登录按钮
    NSArray *btnImageStrArray = @[kImageString_qq, kImageString_weiChat];
    NSArray *titleArray = @[@"QQ登录", @"微信登录"];
    CGFloat thirdBtnLeft = kMargin_level_thirdBtn;
    for (int i = 0; i < 2; i++)
    {
        QButton *thirdBtn = [[QButton alloc] initWithFrame:CGRectMake(thirdBtnLeft, _bgScrollView.height - kMargn_bottom_thirdBtn - kHeight_thirdBtn - 64, kWidth_thirdBtn, kHeight_thirdBtn) style:QButtonStyleImageTop font:kFont_thirdLabel title:titleArray[i] image:Image(btnImageStrArray[i]) space:8 autoSize:NO];
        thirdBtn.tag = 1001 + i;
        thirdBtnLeft = thirdBtn.right + kSpace_level_thirdBtn;
        [thirdBtn addTarget:self action:@selector(handleThirdLogin:) forControlEvents:UIControlEventTouchUpInside];
        [_bgScrollView addSubview:thirdBtn];
    }
    
    //创建展示"-----手机快速登录-----"
    HorLineLabelView *horLineLabelView = [[HorLineLabelView alloc] initWithFrame:CGRectMake(0, 0, _bgScrollView.width, 15) text:String(@"第三方登录") textColor:kGrayColor font:Font(13) space:14];
    [horLineLabelView autoHeight];
    UIButton *thirdBtn = [_bgScrollView viewWithTag:1001];
    horLineLabelView.center = CGPointMake(_bgScrollView.width / 2.0, thirdBtn.top - kMargn_bottom_thirdBtn);
    [_bgScrollView addSubview:horLineLabelView];
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - request data
//登录的网络请求
- (void)loginRequest
{
    NSDictionary *parameters = @{@"u_account":_accountTF.text, @"u_password":_passwordTF.text};
    WS(weakSelf)
    [self POST:API_Login parameters:parameters success:^(NSDictionary *dic) {
        
        NSDictionary *reDic = dic[kResponse];
        //取出用户信息 -> 存本地
        UserModel *userModel = [UserModel mj_objectWithKeyValues:reDic[@"personInfo"]];
        [Single updateWithUserModel:userModel];
        [Single single].isLogin = YES;
        
        //我的爱好列表 -> 存本地
        NSArray *hobbyArray = [HobbySubModel mj_objectArrayWithKeyValuesArray:reDic[@"hobby"]];
        [Tools writeToSandBox:hobbyArray key:Key_PersonDataMyHobbyArray];
        //我的职业 -> 存本地
        ProfessionModel *myProfessionModel = [ProfessionModel mj_objectWithKeyValues:reDic[@"Monthly_income"][0]];
        [Tools writeToSandBox:myProfessionModel key:Key_PersonDataMyProfession];
        
        //请求个人的用户信息
        [self dismissVCAnimated:YES completion:^{
            [Tools showToastMsg:@"登录成功"];
            if (self.loginSuccessBlock) {
                self.loginSuccessBlock();
            }
        }];
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

//更新个人信息的网络请求
- (void)updatePersonDataRequest
{
    UserModel *userModel = [Single getUserModel];
    NSDictionary *parameters = @{@"userId":userModel.ID};
    [self POST:API_MineGetUserData parameters:parameters success:^(NSDictionary *dic) {
        
        NSDictionary *reDic = dic[kResponse];
        
        //取出用户信息 -> 存本地
        UserModel *userModel = [UserModel mj_objectWithKeyValues:reDic[@"personInfo"]];
        [Single updateWithUserModel:userModel];
        [Single single].isLogin = YES;
        
        //我的爱好列表 -> 存本地
        NSArray *hobbyArray = [HobbySubModel mj_objectArrayWithKeyValuesArray:reDic[@"hobby"]];
        [Tools writeToSandBox:hobbyArray key:Key_PersonDataMyHobbyArray];
        //我的职业 -> 存本地
        ProfessionModel *myProfessionModel = [ProfessionModel mj_objectWithKeyValues:reDic[@"Monthly_income"][0]];
        [Tools writeToSandBox:myProfessionModel key:Key_PersonDataMyProfession];
        
        //请求个人的用户信息
        
        [self dismissVCAnimated:YES completion:^{
            [Tools showToastMsg:@"登录成功"];
            if (self.loginSuccessBlock) {
                self.loginSuccessBlock();
            }
        }];
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action
//登录按钮 -- 触发事件
- (void)handleLoginBtn:(UIButton *)sender
{
    //验证账号的格式是否正确
    if ([_accountTF.text isMobileNumber] || [_accountTF.text isEmailAddress])
    {
        //验证密码的格式是否正确
        if (_passwordTF.text.length <= Length_password_max && _passwordTF.text.length >= Length_password_min)
        {
            //发送登录请求
            [self loginRequest];
        }
        else
        {
            //密码格式不正确
            [self.view showToastMsg:String_prompt_pwFormatError];
        }
    }
    else
    {
        //账号格式不正确
        [self.view showToastMsg:String_prompt_accoutFormatError];
    }
}

//密码输入框（右侧的密码是否可见的按钮）
- (void)handleRightBtn:(UIButton *)sender
{
    _passwordTF.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
    [_passwordTF becomeFirstResponder];
}

//忘记密码 -- 触发事件
- (void)handleForgetPW:(UIButton *)sender
{
    ForgetPwVC *forgetPwVC = [ForgetPwVC new];
    forgetPwVC.title = String(@"忘记密码");
    [self.navigationController pushVC:forgetPwVC animated:YES];
}

//第三方登录 -- 触发事件
- (void)handleThirdLogin:(UIButton *)sender
{
    NSInteger index = sender.tag - 1001;
    if (index == 0)
    {//QQ登录
        ThirdLoginVC *qqLoginVC = [ThirdLoginVC new];
        qqLoginVC.title = String(@"QQ登录");
        qqLoginVC.thirdLoginType = ThirdLoginTypeQQ;
        qqLoginVC.thirdNickName = @"米洛洛";
        [self.navigationController pushVC:qqLoginVC animated:YES];
    }
    else
    {//微信登录
        ThirdLoginVC *weChatLoginVC = [ThirdLoginVC new];
        weChatLoginVC.title = String(@"微信登录");
        weChatLoginVC.thirdLoginType = ThirdLoginTypeWeChat;
        weChatLoginVC.thirdNickName = @"米洛洛";
        [self.navigationController pushVC:weChatLoginVC animated:YES];
    }
}

//注册
- (void)handleRegister
{
    RegisterVC *registerVC = [RegisterVC new];
    [self.navigationController pushVC:registerVC animated:YES];
}

#pragma mark - <UITextFieldDelegate>
//字符限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _accountTF)
    {//账号输入框
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 32)
        {
            return NO;
        }
    }
    else
    {//密码输入框
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > Length_password_max)
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
