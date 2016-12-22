//
//  SetupPwVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SetupPwVC.h"

@interface SetupPwVC ()

@end

@implementation SetupPwVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.btnTitle = String(@"下一步");
    self.placeholderArray = @[String(@"请输入密码"), String(@"请再次输入密码")];
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
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - request data
//下一步的网络请求
- (void)requestNextstep
{
    //设置密码 - 下一步的网络请求
    NSDictionary *parameters = @{@"password":self.pw1TF.text};
    //WS(weakSelf)
    [self POST:API_SetPW parameters:parameters success:^(NSDictionary *dic) {
        
        [UIAlertController qb_showAlertWithTitle:nil message:String(@"密码设置成功！") cancelTitle:nil otherTitles:@[String(@"好")] handler:^(UIAlertController *alertController, NSInteger buttonIndex) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } vc:self];
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method


#pragma mark - handle action


#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
