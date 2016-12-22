//
//  ResetPwVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"

@interface ResetPwVC : BaseVC

//新密码输入框
@property (nonatomic, strong) UITextField *pw1TF;
//确认新密码输入框
@property (nonatomic, strong) UITextField *pw2TF;

//暴露给子类（方便设置密码继承时修改）
@property (nonatomic, strong) NSString *btnTitle;
//账号
@property (nonatomic, copy) NSString *account;
//下一步的网络请求(暴露接口，子类重写接口)
- (void)requestNextstep;

@end
