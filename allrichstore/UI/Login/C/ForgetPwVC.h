//
//  ForgetPwVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"


@class RegisterVC;
@interface ForgetPwVC : BaseVC

//所有登录控件的父视图（设置弹性方便）
@property (nonatomic, strong) UIScrollView *bgScrollView;

//账号输入框
@property (nonatomic, strong) UITextField *accountTF;
//验证码输入框
@property (nonatomic, strong) UITextField *verifiCodeTF;

//下一步按钮的名称
@property (nonatomic, copy) NSString *nextBtnTitle;

//下一步的网络请求(暴露接口，方便注册页面继承时重写接口)
- (void)requestNextstep;

@end
