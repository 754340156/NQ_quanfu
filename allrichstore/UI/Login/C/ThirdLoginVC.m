//
//  ThirdLoginVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ThirdLoginVC.h"    //第三方登录选择注册或绑定
#import "RegisterVC.h"      //注册
#import "ThirdBindVC.h"     //第三方登录绑定全富账号


//通过修改此函数可选择：是否按比例适配
#define LoginAdapted(x)     Adapted(x)
//#define LoginAdapted(x)     x

#pragma mark - 布局参数
//label上边距
#define kMargin_top_labels          LoginAdapted(20)
//label的下边距
#define kMargin_bottom_labels          LoginAdapted(16)
//label左右间距
#define kMargin_left_labels         LoginAdapted(12)
//label垂直间距
#define kSpace_vertical_labels      LoginAdapted(16)
//button垂直间距
#define kSpace_vertical_Btns        LoginAdapted(36)

//顶部白色视图与账号的垂直间距
#define kSpace_vertical_topView_Btn LoginAdapted(60)

//按钮的高
#define kHeight_Btns                LoginAdapted(36)
//按钮的宽
#define kWidth_Btns                (kHeight_Btns * 3.2)


#pragma mark - 字体参数
//label的字体
#define kFont_labels                Font(LoginAdapted(16))
//按钮标题的字体
#define kFont_BtnsTitle             Font(LoginAdapted(18))


#pragma mark - 颜色配置
//输入框的文字颜色
#define kColor_labels_text          QF_BlackColor
//登录按钮的背景颜色
#define kColor_Btns_Bg              QF_RedBtnColor

#pragma mark - 开关
//是否开启弹性
#define kIsHaveBounce    0

@interface ThirdLoginVC ()

//所有登录控件的父视图（设置弹性方便）
@property (nonatomic, strong) UIScrollView *bgScrollView;

@end

@implementation ThirdLoginVC

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
    
    //创建scrollVew作为父视图
    self.bgScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_bgScrollView];
    //开启弹性
#if kIsHaveBounce
    _bgScrollView.alwaysBounceVertical = YES;
#endif
    
    //创建顶部的白色视图
    UIView *topWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bgScrollView.width, 0)];
    topWhiteView.backgroundColor = kWhiteColor;
    [_bgScrollView addSubview:topWhiteView];
    
    //创建两列label
    CGFloat labelTop = kMargin_top_labels;
    NSString *thirdName = (_thirdLoginType == ThirdLoginTypeQQ) ? String(@"QQ") : String(@"微信");
    NSString *firstString = [NSString stringWithFormat:String(@"亲爱的%@用户：%@"), thirdName, _thirdNickName];
    NSArray *textArray = @[firstString, String(@"为了给您更好的服务，请关联一个全富账号")];
    for (int i = 0; i < 2; i++)
    {
        UILabel *label = [UILabel new];
        label.text = textArray[i];
        label.font = kFont_labels;
        label.textColor = kColor_labels_text;
        label.frame = CGRectMake(kMargin_left_labels, labelTop, topWhiteView.width - (kMargin_left_labels * 2.0), [label getHeight]);
        [topWhiteView addSubview:label];
        if (i == 0) {
            labelTop = label.bottom + kSpace_vertical_labels;
        } else {
            labelTop = label.bottom;
        }
    }
    
    topWhiteView.height = labelTop + kMargin_bottom_labels;
    
    
    //创建label和按钮
    NSArray *labelTextArray = @[String(@"还没有全富账号？"), String(@"已有全富账号？")];
    NSArray *btnTitleArray = @[String(@"快速注册"), String(@"立即关联")];
    CGFloat btnTop = topWhiteView.bottom + kSpace_vertical_topView_Btn;
    for (int i = 0; i < 2; i++)
    {
        //先创建右侧按钮
        UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        thirdBtn.frame = CGRectMake(_bgScrollView.width - kMargin_left_labels - kWidth_Btns, btnTop, kWidth_Btns, kHeight_Btns);
        btnTop = thirdBtn.bottom + kSpace_vertical_Btns;
        thirdBtn.backgroundColor = kColor_Btns_Bg;
        [thirdBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        thirdBtn.layer.masksToBounds = YES;
        thirdBtn.layer.cornerRadius = thirdBtn.height / 2.0;
        [thirdBtn setTitle:btnTitleArray[i] forState:UIControlStateNormal];
        thirdBtn.titleLabel.font = kFont_BtnsTitle;
        if (i == 0) {
            //快速注册
            [thirdBtn addTarget:self action:@selector(handleRegister:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            //立即关联
            [thirdBtn addTarget:self action:@selector(handleBinding:) forControlEvents:UIControlEventTouchUpInside];
        }
        [_bgScrollView addSubview:thirdBtn];
        
        //再创建左侧label
        UILabel *leftLabel = [UILabel new];
        leftLabel.textColor = kColor_labels_text;
        leftLabel.font = kFont_labels;
        leftLabel.text = labelTextArray[i];
        leftLabel.size = CGSizeMake(_bgScrollView.width - kMargin_left_labels * 3.0 - thirdBtn.width, [leftLabel getHeight]);
        leftLabel.origin = CGPointMake(kMargin_left_labels, 0);
        leftLabel.centerY = thirdBtn.centerY;
        [_bgScrollView addSubview:leftLabel];
    }
    
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
//快速注册 -- 触发事件
- (void)handleRegister:(UIButton *)sender
{
    RegisterVC *registerVC = [RegisterVC new];
    [self.navigationController pushVC:registerVC animated:YES];
}

//立即关联 -- 触发事件
- (void)handleBinding:(UIButton *)sender
{
    //绑定第三方账号
    ThirdBindVC *thirdBingVC = [ThirdBindVC new];
    thirdBingVC.title = String(@"登录绑定");
    thirdBingVC.thirdLoginType = self.thirdLoginType;
    [self.navigationController pushVC:thirdBingVC animated:YES];
}

#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
