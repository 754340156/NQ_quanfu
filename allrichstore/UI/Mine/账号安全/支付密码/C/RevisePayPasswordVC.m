//
//  RevisePayPasswordVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/24.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RevisePayPasswordVC.h"

#define kLabelW 135.0f
@interface RevisePayPasswordVC ()
/**  password */
@property(nonatomic,strong) UITextField * passwordTF;
/**  again */
@property(nonatomic,strong) UITextField * againPasswordTF;
/**  确定 */
@property(nonatomic,strong) UIButton * sureButton;
@end

@implementation RevisePayPasswordVC

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
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.view addSubview:self.tableView];
    self.tableView.bounces = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
    
    [self.view addSubview:self.sureButton];
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
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
- (void)setTextFieldWith:(UITextField *)textField Cell:(UITableViewCell *)cell leftLabel:(UILabel *)label
{
    textField.textColor = QF_BlackColor;
    textField.font = Font_Mid;
    textField.secureTextEntry = YES;
    [cell.contentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right);
        make.centerY.offset(0);
        make.right.offset(Adapted(-kMargin));
    }];
}
#pragma mark - handle action
- (void)nextAction
{
    //修改支付密码
    if ([NSString isEmpty:self.passwordTF.text]) {
        [self.view showToastMsg:@"登录密码不能为空"];
        return;
    }
    if (![self.passwordTF.text equalsString:self.againPasswordTF.text]) {
        [self.view showToastMsg:@"两次输入密码不一致"];
        return;
    }
    
    //转化为json格式
    NSDictionary *dic =  @{@"u_account":[Single getUserModel].ID, @"uPayment":self.passwordTF.text};
    NSDictionary *parameters = @{@"param":[NSString StringDicWithDic:dic]};
    [self POST:API_MineModifyUser parameters:parameters success:^(NSDictionary *dic) {
        
        [Tools showToastMsg:@"设置成功" completion:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];

    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
    if (indexPath.row == 0) {
        UILabel *label = [[UILabel alloc] init];
        [self setLabelWithLabel:label Cell:cell Title:String(@"输入新的支付密码")];
        self.passwordTF = [[UITextField alloc] init];
        [self setTextFieldWith:self.passwordTF Cell:cell leftLabel:label];
    }else
    {
        UILabel *label = [[UILabel alloc] init];
        [self setLabelWithLabel:label Cell:cell Title:String(@"再次输入支付密码")];
        self.againPasswordTF = [[UITextField alloc] init];
        [self setTextFieldWith:self.againPasswordTF Cell:cell leftLabel:label];
    }
    [cell addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kBottomH;
}
#pragma mark - lazy
- (UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:String(@"下一步") forState:UIControlStateNormal];
        [_sureButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_sureButton setBackgroundColor:QF_RedColor];
        [_sureButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
