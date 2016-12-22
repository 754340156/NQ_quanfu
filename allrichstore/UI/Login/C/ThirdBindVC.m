//
//  ThirdBindVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ThirdBindVC.h"     //第三方登录绑定全富账号

//通过修改此函数可选择：是否按比例适配
#define BindAdapted(x)     Adapted(x)
//#define BindAdapted(x)     x

#pragma mark - 布局参数
//输入框上边距
#define kMargin_top_tfs             BindAdapted(50)
//输入框左右间距
#define kMargin_left_tfs            BindAdapted(12)
//按钮的左右间距
#define kMargin_left_Btn            kMargin_left_tfs

//输入框的高度
#define kHeight_tfs                 BindAdapted(50)
//按钮的高度
#define kHeight_btn                 BindAdapted(48)

//输入框之间的垂直间距
#define kSpace_vertical_tfs         BindAdapted(18)
//输入框与按钮之间的垂直距离
#define kSpace_vertical_tf_btn      BindAdapted(90)

//输入框leftVew的图标的左间距
#define kMargin_left_leftViewImage  BindAdapted(16)
//输入框leftVew的图标的左间距
#define kMargin_right_leftViewImage BindAdapted(8)

#pragma mark - 字体参数
//输入框的字体
#define kFont_tfs               Font(BindAdapted(17))
//按钮标题的字体
#define kFont_btnTitle          Font(BindAdapted(18))
//label的字体
#define kFont_labels            Font(BindAdapted(16))


#pragma mark - 颜色配置
//输入框的文字颜色
#define kColor_tfs          QF_BlackColor
//按钮的背景颜色
#define kColor_BtnBg        QF_RedBtnColor
//label的字体颜色
#define kColor_labels       kGrayColor

#pragma mark - 图片配置
//账号(图标名称)
#define kImageString_account      @""
//验证码(图标名称)
#define kImageString_password     @""

#pragma mark - 开关
//是否开启弹性
#define kIsHaveBounce    0

@interface ThirdBindVC ()<UITextFieldDelegate>

//所有登录控件的父视图（设置弹性方便）
@property (nonatomic, strong) UIScrollView *bgScrollView;
//账号输入框
@property (nonatomic, strong) UITextField *accountTF;
//密码输入框
@property (nonatomic, strong) UITextField *pwTF;

@end

@implementation ThirdBindVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.placeholderArray = @[String(@"手机号／邮箱"), String(@"请输入密码")];
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
    
    //创建scrollVew作为父视图
    self.bgScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_bgScrollView];
    //开启弹性
#if kIsHaveBounce
    _bgScrollView.alwaysBounceVertical = YES;
#endif
    
    //创建顶部的label
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin_left_tfs, 0, _bgScrollView.width - kMargin_left_tfs * 2.0, kMargin_top_tfs)];
    topLabel.textColor = kColor_labels;
    topLabel.font = kFont_labels;
    topLabel.text = String(@"关联已有全富账号");
    [_bgScrollView addSubview:topLabel];
    
    //创建账号和密码输入框
    CGFloat tfTop = kMargin_top_tfs;
    //    NSArray *leftViewImageArray = @[[UIImage imageNamed:kImageString_account], [UIImage imageNamed:kImageString_password]];
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
        }else {
            self.pwTF = tf;
            tf.secureTextEntry = YES;
            tf.keyboardType = UIKeyboardTypeDefault;
        }
        tfTop = whiteView.bottom + kSpace_vertical_tfs;
        tf.delegate = self;
        tf.textColor = kColor_tfs;
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
    
    //创建输入框下面的label
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMargin_left_tfs, _pwTF.superview.bottom, _bgScrollView.width - kMargin_left_tfs * 2.0, kMargin_top_tfs)];
    bottomLabel.textColor = kColor_labels;
    bottomLabel.font = kFont_labels;
    NSString *thirdString = (_thirdLoginType == ThirdLoginTypeQQ) ? String(@"QQ") : String(@"微信");
    NSString *labelText = [NSString stringWithFormat:String(@"关联后，您的%@账号和全富账号都可以登录"), thirdString];
    bottomLabel.text = labelText;
    [_bgScrollView addSubview:bottomLabel];
    
    //登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame = CGRectMake(kMargin_left_Btn, _pwTF.superview.bottom + kSpace_vertical_tf_btn, _bgScrollView.width - kMargin_left_Btn * 2.0, kHeight_btn);
    loginBtn.backgroundColor = kColor_BtnBg;
    [loginBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = loginBtn.height / 2.0;
    loginBtn.titleLabel.font = kFont_btnTitle;
    [loginBtn setTitle:String(@"登录") forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(handleLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:loginBtn];
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

//绑定并登录的网络请求
- (void)bindingAndLoginRequest
{
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    NSString *thirdString = (_thirdLoginType == ThirdLoginTypeQQ) ? String(@"QQ") : String(@"微信");
    [NetWork POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
        [UIAlertController qb_showAlertWithTitle:String(@"关联成功") message:[NSString stringWithFormat:String(@"%@已经与您的%@账号成功关联 该账号和您的%@账号都可以用来登录"), _accountTF.text, thirdString, thirdString] cancelTitle:String(@"我知道了") otherTitles:nil handler:nil vc:self];
        
    } fail:^(NSError *error) {
        
        [weakSelf.view showToastMsg:String_prompt_verifiCodeSendSuccess];
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action
//按钮 -- 触发事件
- (void)handleLoginBtn:(UIButton *)sender
{
    //验证账号的格式是否正确
    if ([_accountTF.text isMobileNumber] || [_accountTF.text isEmailAddress])
    {
        //验证密码的格式是否正确
        if (_pwTF.text.length <= Length_password_max && _pwTF.text.length >= Length_password_min)
        {
            //绑定并登录的网络请求
            [self bindingAndLoginRequest];
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
