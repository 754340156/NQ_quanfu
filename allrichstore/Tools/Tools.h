//
//  Tools.h
//  YunSuLive
//
//  Created by hai on 16/6/23.
//  Copyright © 2016年 22. All rights reserved.
//

#import <UIKit/UIKit.h>

//第三方登录的类型
typedef NS_ENUM(NSInteger, ThirdLoginType)
{
    ThirdLoginTypeQQ,
    ThirdLoginTypeWeChat
};

typedef void(^ImageBlock)(UIImage *image);
typedef void(^ItemAction)(NSUInteger itemIndex);

@interface Tools : NSObject

/**
 *  AlertView(自定义按钮)
 *
 *  @param title      标题
 *  @param message    消息
 *  @param items      按钮标题数组
 *  @param controller 要展示的目的控制器
 *  @param ItemAction 按钮回调(通过index区分)
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)items atController:(UIViewController *)controller action:(ItemAction)ItemAction;

/**
 *  ActionSheet
 *
 *  @param title      标题
 *  @param message    消息
 *  @param items      按钮标题数组
 *  @param controller 要展示的目的控制器
 *  @param action     按钮回调(通过index区分)
 */
+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message items:(NSArray *)items atController:(UIViewController *)controller action:(ItemAction)action;


/**
 *  按钮倒计时
 *
 *  @param btn         要进行倒计时的按钮
 *  @param second      倒计时秒数
 *  @param title       初始标题
 *  @param timingTitle 倒计时标题(x秒...)
 */
+ (void)countdownButton:(UIButton *)btn timeout:(int)second originalTitle:(NSString *)title timingTitle:(NSString *)timingTitle;
/**
 *  图片选择器(单选)
 *
 *  @param VC    当前视图控制器
 *  @param block 选中图片之后的回调
 */
+ (void)imagePickerAtController:(UIViewController *)VC image:(ImageBlock)block;

// 手机号码
+ (BOOL)validateMobile:(NSString *)mobile;

//姓名验证
+ (BOOL)validateName:(NSString* )name;

//身份证
+ (BOOL)checkID:(NSString *)sPaperId;

/**
 *  将礼物model转换为json字符串
 *
 *  @param model 礼物model
 *
 *  @return json字符串
 */
//+ (NSString *)gift:(GiftListModel *)model;

//归档到本地
+ (void)writeToSandBox:(id)object key:(NSString *)key;

//通过key从本地解档
+ (id)readFromSandBox:(NSString *)key;

//根据key获取沙河路径
+ (NSString *)getFilePathWithKey:(NSString *)key;

//时间截转格式时间
+ (NSString *)getTimeTextFormat:(NSString *)formatStr timeNum:(NSInteger)timeNum;

//根据出生日期计算星座
+ (NSString *)getConstellationFromDate:(NSDate *)date;

//window展示吐丝
+ (void)showToastMsg:(NSString *)msg;

//window展示吐丝(带回调block)
+ (void)showToastMsg:(NSString *)msg completion:(void(^)())completion;

//第一次打开App
+ (void)firstOpenAppBlock:(void(^)())block;

@end
