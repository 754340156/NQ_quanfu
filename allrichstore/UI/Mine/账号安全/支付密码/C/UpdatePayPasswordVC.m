//
//  UpdatePayPasswordVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "UpdatePayPasswordVC.h"
#import "RevisePayPasswordVC.h"
#import "VerificationPhonePopView.h"

@interface UpdatePayPasswordVC ()<VerificationPhonePopViewDelegate>
/**  popView */
@property(nonatomic,strong) VerificationPhonePopView * popView;
@end

@implementation UpdatePayPasswordVC

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (indexPath.row == 0) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = String(@"修改支付密码");
    }else
    {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        }
        cell.textLabel.text = String(@"支付密码使用说明");
        cell.detailTextLabel.text = String(@"当前使用积分进行现金抵用时需要输入支付密码进行操作");
    }
    cell.textLabel.textColor = QF_BlackColor;
    cell.textLabel.font = Font_Mid;
    cell.detailTextLabel.font = Font_Mid;
    cell.detailTextLabel.textColor = QF_BlackColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  indexPath.row ? 80 : kBottomH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    UILabel *label = [[UILabel alloc] init];
    [label sizeToFit];
    label.text = String(@"默认支付密码为登录密码");
    label.font = Font_Mid;
    label.textColor = QF_GrayColor;
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kMargin);
        make.left.offset(kMargin * 3 / 2);
    }];
    return backView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
    }
}
#pragma mark - VerificationPhonePopViewDelegate
- (void)VerificationPhonePopViewDelegate_clickSure:(BOOL)isSure
{
    [self.popView removeFromSuperview];
    if (isSure) {

        [Tools showToastMsg:@"验证成功" completion:^{
            RevisePayPasswordVC *reviseVC = [[RevisePayPasswordVC alloc] init];
            [self.navigationController pushVC:reviseVC animated:YES];
        }];
    }
}

- (void)VerificationPhonePopViewDelegate_clickGetCodeWithButton:(UIButton *)sender
{
    
}

#pragma mark - lazy
- (VerificationPhonePopView *)popView
{
    if (!_popView) {
        _popView = [[VerificationPhonePopView alloc] initWithFrame:self.view.bounds];
        _popView.backgroundColor = Color_Translucent;
        _popView.phone = [Single getUserModel].uPhone;
        _popView.delegate = self;
    }
    return _popView;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
