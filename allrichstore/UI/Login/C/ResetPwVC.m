//
//  ResetPwVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ResetPwVC.h"       //重置密码

//通过修改此函数可选择：是否按比例适配
#define ForgetAdapted(x)     Adapted(x)
//#define ForgetAdapted(x)     x

#pragma mark - 布局参数
//输入框上边距
#define kMargin_top_tfs            (ForgetAdapted(20) + 0)
//输入框左右间距
#define kMargin_left_tfs            ForgetAdapted(12)
//重置密码按钮的左右间距
#define kMargin_left_resetBtn        kMargin_left_tfs


//输入框的高度
#define kHeight_tfs                 ForgetAdapted(50)
//重置密码按钮的高度
#define kHeight_loginBtn            ForgetAdapted(48)
//获取验证码按钮的宽度
#define kWidth_verifiCode           ForgetAdapted(96)

//输入框之间的垂直间距
#define kSpace_vertical_tfs         ForgetAdapted(18)
//输入框与重置密码按钮之间的垂直距离
#define kSpace_vertical_tf_resetBtn  ForgetAdapted(90)

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
//重置密码按钮的背景颜色
#define kColor_resetBtnBg       QF_RedBtnColor

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

@interface ResetPwVC ()<UITextFieldDelegate>

//背景图片ImageView（可设置登录界面的背景图片）
@property (nonatomic, strong) UIImageView *bgImageView;
//所有登录控件的父视图（设置弹性方便）
@property (nonatomic, strong) UIScrollView *bgScrollView;

@end

@implementation ResetPwVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.btnTitle = String(@"重置密码");
    self.placeholderArray = @[String(@"请输入新密码"), String(@"请再次输入新密码")];
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
    
    //创建密码和确认密码输入框
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
            self.pw1TF = tf;
        } else {
            self.pw2TF = tf;
        }
        tfTop = whiteView.bottom + kSpace_vertical_tfs;
        tf.delegate = self;
        tf.textColor = kTextColor_tfs;
        tf.font = kFont_tfs;
        tf.secureTextEntry = YES;
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
    
    
    //重置密码按钮
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    resetBtn.frame = CGRectMake(kMargin_left_resetBtn, _pw2TF.superview.bottom + kSpace_vertical_tf_resetBtn, _bgScrollView.width - kMargin_left_resetBtn * 2.0, kHeight_loginBtn);
    resetBtn.backgroundColor = kColor_resetBtnBg;
    [resetBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    resetBtn.layer.masksToBounds = YES;
    resetBtn.layer.cornerRadius = resetBtn.height / 2.0;
    resetBtn.titleLabel.font = kFont_loginBtnTitle;
    [resetBtn setTitle:self.btnTitle forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(handleResetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:resetBtn];
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

//下一步的网络请求
- (void)requestNextstep
{
    //下一步请求
    NSDictionary *parameters = @{@"u_account":_account, @"password":_pw1TF.text};
    [self POST:API_ResetPW_FindPW parameters:parameters success:^(NSDictionary *dic) {
        
        [UIAlertController qb_showAlertWithTitle:nil message:String(@"密码重置成功！") cancelTitle:nil otherTitles:@[String(@"好")] handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } vc:self];
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action
//重置密码按钮 -- 触发事件
- (void)handleResetBtn:(UIButton *)sender
{
    //验证输入的密码的格式
    if (_pw1TF.text.length <= Length_password_max && _pw1TF.text.length >= Length_password_min)
    {
        //验证两次输入的密码格式是否一致
        if ([_pw1TF.text isEqualToString:_pw2TF.text])
        {
            //下一步的网络请求
            [self requestNextstep];
        }
        else
        {
            //两次输入的密码不一致
            [self.view showToastMsg:String_prompt_pwNotsame];
        }
    }
    else
    {
        //密码格式不正确
        [self.view showToastMsg:String_prompt_pwFormatError];
    }
}

#pragma mark - <UITextFieldDelegate>
//字符限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([toBeString length] > Length_password_max)
    {
        return NO;
    }
    return YES;
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
