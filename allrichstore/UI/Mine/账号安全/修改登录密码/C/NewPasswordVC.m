//
//  NewPasswordVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/24.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "NewPasswordVC.h"
#define kLabelW 105.0f
@interface NewPasswordVC ()
/**  password */
@property(nonatomic,strong) UITextField * passwordTF;
/**  again */
@property(nonatomic,strong) UITextField * againPasswordTF;
/**  submit */
@property(nonatomic,strong) UIButton * submitBtn;
@end

@implementation NewPasswordVC

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
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    self.tableView.bounces = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
    
    [self.view addSubview:self.submitBtn];
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(kBottomH);
    }];
    
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    
}

#pragma mark - custom method
- (void)setLabelWithLabel:(UILabel *)label Cell:(UITableViewCell *)cell Title:(NSString *)title
{
    label.text = title;
    label.textColor = QF_BlackColor;
    label.font = Font_Mid;
    [label sizeToFit];
    [label addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.centerY.offset(0);
        make.width.offset(Adapted(kLabelW));
    }];
}
- (void)setTextFieldWith:(UITextField *)textField Cell:(UITableViewCell *)cell leftLabel:(UILabel *)label PlaceHolder:(NSString *)placeHolder
{
    textField.textColor = QF_BlackColor;
    textField.font = Font_Mid;
    textField.placeholder = placeHolder;
    textField.secureTextEntry = YES;
    [cell.contentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right);
        make.centerY.offset(0);
        make.right.offset(Adapted(-kMargin));
    }];
}
#pragma mark - handle action
- (void)submitAction
{
    if ([NSString isEmpty:self.passwordTF.text]) {
        [self.view showToastMsg:@"登录密码不能为空"];
        return;
    }
    if (![self.passwordTF.text equalsString:self.againPasswordTF.text]) {
        [self.view showToastMsg:@"两次输入密码不一致"];
        return;
    }
    
    NSDictionary *parameters = @{@"u_account":[Single getUserModel].uPhone, @"password":self.passwordTF.text};
    WS(weakSelf)
    [self POST:API_UpdatePassword_SubmitNewPW parameters:parameters success:^(NSDictionary *dic) {
        
        [Tools showToastMsg:@"设置成功" completion:^{
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }];
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}
#pragma mark - UITableVielDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = Image(@"Mine_UpdatePassword");
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }else
    {
        if (indexPath.row == 0) {
            UILabel *label = [[UILabel alloc] init];
            [self setLabelWithLabel:label Cell:cell Title:String(@"设置登录密码")];
            self.passwordTF = [[UITextField alloc] init];
            [self setTextFieldWith:self.passwordTF Cell:cell leftLabel:label PlaceHolder:String(@"请输入密码")];
        }else
        {
            UILabel *label = [[UILabel alloc] init];
            [self setLabelWithLabel:label Cell:cell Title:String(@"请重新输入")];
            self.againPasswordTF = [[UITextField alloc] init];
            [self setTextFieldWith:self.againPasswordTF Cell:cell leftLabel:label PlaceHolder:String(@"请再次输入密码")];
        }
        [cell addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  Adapted(kSection1H);
    }
    return kBottomH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kFooterViewH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kFooterViewH)];
    view.backgroundColor = QFColor_CoodsClassMenuViewBg;
    return view;
}
#pragma mark - lazy
- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:String(@"提交") forState:UIControlStateNormal];
        [_submitBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:QF_RedColor];
        [_submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
