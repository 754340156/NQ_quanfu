//
//  String.h
//  FullRich
//
//  Created by 任强宾 on 16/10/26.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#ifndef String_h
#define String_h

//从国际化配置里面取字符串
#define String(key) NSLocalizedString(key, nil)

//当前版本号
#define AppVersion @"1.0"

//本应用的appID
#define AppID @"1074155933"

//本应用的名称
#define App_Name        @"全富商城"

//首页标题的名称
#define App_HomeTitle   @"全富商城"

//本APP的简称
#define AppSimpleName   @"全富商城"

//App要分享的地址
#define AppShareURL @"http://live.icloudinn.com/"

//客服电话
#define ServiceTel   @"400-800-8888"

//App版本号
#define appMPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])

#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])

#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

/***********************提示语**********************/

#pragma mark - 登录注册
//账号格式不正确（提示语）
#define String_prompt_accoutFormatError  String(@"手机号或邮箱格式不正确")
#define String_prompt_phoneFormatError  String(@"手机号格式不正确")
//密码格式不正确（提示语）
#define String_prompt_pwFormatError     [NSString stringWithFormat:String(@"请输入%d-%d位的密码！"), Length_password_min, Length_password_max]
//验证码格式不正确（提示语）
#define String_prompt_verifiCodeFormatError     [NSString stringWithFormat:String(@"请输入%d位的验证码！"), Length_verifiCode]
//两次输入的密码不一致（提示语）
#define String_prompt_pwNotsame String(@"两次输入的密码不一致！")
//验证码已发送（提示语）
#define String_prompt_verifiCodeSendSuccess String(@"验证码发送成功！")

//签名为空的提示语
#define kDefaultSignature String(@"这家伙很懒~")
//支付结果通知
#define PayResultNoti @"sendPayResult"


#define kString_sexUnknown String(@"未知")

#pragma mark - keyString
/******************keyString*******************/
//是否不是是第一次安装 打开
#define IsNotFirstLaunch_Key @"isNoFirstLaunchKey"

//首页轮播图的数组缓存
#define HomeBannerArrayKey  @"homeBannerArray"

//定位地域选择数组缓存
#define LocationArrayKey  @"LocationArrayKey"

//搜索历史记录数组缓存
#define SearchArrayKey  @"SearchArrayKey"

//地域未获得的关键字
#define NotAddressString @"全国"

//Token
#define kUserToken @"userToken"

//定位成功的通知的名称
#define AppHadLocNotificationName @"AppHadLocAddressNotification"


#pragma mark - 缓存key
/******************首页*****************/
#define Key_BannerListById(ID)  [NSString stringWithFormat:@"Key_BannerListBy%@", ID]

//banner对应的id
#define BannerID_homeTop        @"1"    //首页顶部轮播
#define BannerID_homeAdvert     @"2"    //首页广告位

//自营速达-菜单列表
#define Key_SelfBusinessMenuList  @"Key_SelfBusinessMenuList"

/******************分类*****************/
//一级分类列表
#define Key_goodsClass_oneLevel @"goodsClass_oneLevel"
//商家入驻添加经营类目通知
#define kShopInformationAddClass @"kShopInformationAddClass"

//商家入驻添加经营类目结束更新tableView
#define kTableViewHeightNotification @"kTableViewHeightNotification"
/****************个人资料*****************/
//爱好（总列表）
#define Key_PersonDataHobbyArray @"Key_PersonDataHobbyArray"
//月收入（总列表）
#define Key_PersonDataIncomeArray  @"Key_PersonDataIncomeArray"
//教育程度（总列表）
#define Key_PersonDataEducatArray @"Key_PersonDataEducatArray"
//职业列表（总列表）
#define Key_PersonDataProfessionArray @"Key_PersonDataProfessionArray"

//爱好（我的列表）
#define Key_PersonDataMyHobbyArray  @"Key_PersonDataMyHobbyArray"
//职业
#define Key_PersonDataMyProfession @"Key_PersonDataMyProfession"

//苹果审核开关
#define AuditingSwitchKey @"AuditingSwitchKey"

//
#define kUserModelKey @"kUserModelKey"

//是否处于登录状态
#define kIsLoginKey    @"kIsLoginKey"

#endif /* String_h */
