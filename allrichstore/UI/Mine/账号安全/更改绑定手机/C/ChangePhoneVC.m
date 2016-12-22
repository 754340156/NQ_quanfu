//
//  ChangePhoneVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ChangePhoneVC.h"
#import "IdentityVerificationVC.h"
#import "NewPhoneVC.h"
#import "Mine_OrderCell.h"
#import "VerificationPhonePopView.h"
@interface ChangePhoneVC ()<VerificationPhonePopViewDelegate>
/**  popView */
@property(nonatomic,strong) VerificationPhonePopView * popView;
/**  保存验证码 */
@property(nonatomic,copy) NSString * code;
@end

@implementation ChangePhoneVC

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
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.tableView registerClass:[Mine_OrderCell class] forCellReuseIdentifier:[Mine_OrderCell className]];
    
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    
}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Mine_OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:[Mine_OrderCell className] forIndexPath:indexPath];
    if (indexPath.row) {
        cell.titleName = String(@"原号码不能接收验证码");
    }else
    {
        cell.titleName = String(@"原号码能接收验证码");
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row) {
        //不能
        IdentityVerificationVC *VC = [[IdentityVerificationVC alloc] init];
        [self.navigationController pushVC:VC animated:YES];
    }else
    {
        //能
        [[UIApplication sharedApplication].keyWindow addSubview:self.popView];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = String(@"无法修改，拨打人工客服400-606-5555");
    label.textColor = QF_GrayColor;
    [label sizeToFit];
    label.font = Font_Mid;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(kMargin * 3 / 2);
    }];
    return view;
}
#pragma mark - VerificationPhonePopViewDelegate
//点击确定
- (void)VerificationPhonePopViewDelegate_clickSure:(BOOL)isSure
{
    [self.popView removeFromSuperview];
    if (isSure) {
        [Tools showToastMsg:@"验证成功" completion:^{
            NewPhoneVC *newVC = [[NewPhoneVC alloc] init];
            [self.navigationController pushVC:newVC animated:YES];
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
        _popView.superViewController = self;
        //如果原号码能接受到就用usermodel里的
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
