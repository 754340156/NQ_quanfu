//
//  SecurityVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SecurityVC.h"
#import "Mine_OrderCell.h"

#import "UpdatePasswordVC.h"//修改登录密码
#import "ChangeEmailVC.h"//更改绑定邮箱
#import "ChangePhoneVC.h"//更改绑定手机
#import "UpdatePayPasswordVC.h"//支付密码
#import "ThirdPartyBindingVC.h"//QQ绑定 微信绑定
#import "SafeInstructionVC.h"//安全说明
@interface SecurityVC ()

@end

@implementation SecurityVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.listArray = @[@[@{@"titleName":String(@"修改登录密码")},
                         @{@"titleName":[Single getUserModel].uEmail.length ? String(@"更改绑定邮箱"):String(@"设置绑定邮箱")},
                         @{@"titleName":[Single getUserModel].uPhone.length ? String(@"更改绑定手机"):String(@"设置绑定手机")},
                         @{@"titleName":String(@"支付密码")},
                         @{@"titleName":String(@"QQ绑定"),
                           @"attestationName":String(@"QQ绑定")},
                         @{@"titleName":String(@"微信绑定(已绑定)"),
                           @"attestationName":String(@"解除绑定")}],
                       @[@{@"titleName":String(@"安全说明")}]].mutableCopy;
    
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
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.tableView registerClass:[Mine_OrderCell class] forCellReuseIdentifier:[Mine_OrderCell className]];
    
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

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Mine_OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:[Mine_OrderCell className]];
    cell.titleName = self.listArray[indexPath.section][indexPath.row][@"titleName"];
    cell.attestationName = self.listArray[indexPath.section][indexPath.row][@"attestationName"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  kFooterViewH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  kBottomH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kFooterViewH)];
    view.backgroundColor = QFColor_CoodsClassMenuViewBg;
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                //修改登录密码
                UpdatePasswordVC *passwordVC = [[UpdatePasswordVC alloc] init];
                [self.navigationController pushVC:passwordVC animated:YES];
            }
                break;
            case 1:
            {
                //更改绑定邮箱
                ChangeEmailVC *emailVC = [[ChangeEmailVC alloc] init];
                [self.navigationController pushVC:emailVC animated:YES];
            }
                break;
            case 2:
            {
                //更改绑定手机
                ChangePhoneVC *phoneVC = [[ChangePhoneVC alloc] init];
                [self.navigationController pushVC:phoneVC animated:YES];
            }
                break;
            case 3:
            {
                //支付密码
                UpdatePayPasswordVC *payPasswordVC = [[UpdatePayPasswordVC alloc] init];
                [self.navigationController pushVC:payPasswordVC animated:YES];
            }
                break;
            case 4:
            {
                //QQ绑定
                ThirdPartyBindingVC *bindingVC = [[ThirdPartyBindingVC alloc] init];
                [self.navigationController pushVC:bindingVC animated:YES];
            }
                break;
            case 5:
            {
                //微信绑定
                ThirdPartyBindingVC *bindingVC = [[ThirdPartyBindingVC alloc] init];
                [self.navigationController pushVC:bindingVC animated:YES];
            }
                break;
        }
    }else
    {
     //安全说明
        SafeInstructionVC *safeVC = [[SafeInstructionVC alloc] init];
        [self.navigationController pushVC:safeVC animated:YES];
    }
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
