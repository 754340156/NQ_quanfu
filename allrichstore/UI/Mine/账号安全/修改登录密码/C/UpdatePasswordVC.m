//
//  UpdatePasswordVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "UpdatePasswordVC.h"
#import "NewPasswordVC.h"
#define kButtonW 95.0f

@interface UpdatePasswordVC ()
/**  phonenum */
@property(nonatomic,strong) UILabel * phoneNumL;
/**  textField */
@property(nonatomic,strong) UITextField * textField;
/**  getCode */
@property(nonatomic,strong) UIButton * getCodeBtn;
/**  next */
@property(nonatomic,strong) UIButton * nextButton;

@end

@implementation UpdatePasswordVC

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
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
    
    [self.view addSubview:self.nextButton];
    
}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
- (void)setLabelWith:(UILabel *)label Cell:(UITableViewCell *)cell TitleColor:(UIColor *)titleColor title:(NSString *)title Font:(UIFont *)font isLeft:(BOOL)isLeft Offset:(CGFloat)offset right:(MASViewAttribute *)right
{
    label.font = font;
    label.textColor = titleColor;
    label.text = title;
    [label sizeToFit];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        isLeft ? make.left.offset(offset):make.right.equalTo(right).offset(offset);
    }];
}
- (void)setCell1WithCell:(UITableViewCell *)cell
{
    UILabel *titleLabel = [[UILabel alloc] init];
    [self setLabelWith:titleLabel Cell:cell TitleColor:QF_BlackColor title:String(@"请选择验证身份方式") Font:Font_Mid isLeft:YES Offset:kMargin right:nil];
    
    UIImageView *arrowImageV = [[UIImageView alloc] init];
    arrowImageV.contentMode = UIViewContentModeCenter;
    arrowImageV.image = Image(@"youjiantou");
    [cell.contentView addSubview:arrowImageV];
    [arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(20, 20));
        make.centerY.offset(0);
        make.right.offset(-kMargin);
    }];
    
    UILabel *subTitleL = [[UILabel alloc] init];
    [self setLabelWith:subTitleL Cell:cell TitleColor:QF_GrayColor title:String(@"已验证手机" )Font:Font_Min isLeft:NO Offset:-kMargin right:arrowImageV.mas_left];
}
- (void)setCell2WithCell:(UITableViewCell *)cell
{
    UILabel *titleLabel = [[UILabel alloc] init];
    [self setLabelWith:titleLabel Cell:cell TitleColor:QF_BlackColor title:String(@"已验证手机") Font:Font_Mid isLeft:YES Offset:kMargin right:nil];
    
    self.phoneNumL = [[UILabel alloc] init];
    [self setLabelWith:self.phoneNumL Cell:cell TitleColor:QF_GrayColor title:[Single getUserModel].uPhone Font:Font_Min isLeft:NO Offset:-kMargin right:cell.mas_right];
}
- (void)setCell3WithCell:(UITableViewCell *)cell
{
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getCodeBtn setTitle:String(@"获取验证码") forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:QF_RedColor forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = Font_Mid;
    [self.getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.getCodeBtn addLeftLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    [cell.contentView addSubview:self.getCodeBtn];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset(0);
        make.width.offset(kButtonW);
    }];
    
    self.textField = [[UITextField alloc] init];
    self.textField.font = Font_Mid;
    self.textField.placeholder = String(@"丨填写短信验证码");
    self.textField.textColor = QF_BlackColor;
    [cell.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.centerY.offset(0);
        make.right.equalTo(self.getCodeBtn.mas_left).offset(-kMargin);
    }];
}
#pragma mark - handle action
- (void)getCodeAction:(UIButton *)sender
{
    [Tools countdownButton:sender timeout:60 originalTitle:String(@"获取验证码") timingTitle:@""];
    //发验证码请求
    NSDictionary *parameters = @{@"u_account":[Single getUserModel].uPhone};
    WS(weakSelf)
    [self POST:API_SendCode parameters:parameters success:^(NSDictionary *dic) {
        [weakSelf.view showToastMsg:dic[@"errorMessage"]];
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.view animated:YES];
}
- (void)nextAction
{
    if ([NSString isEmpty:self.textField.text])
    {
        [self.view showToastMsg:@"验证码不能为空"];
        return;
    }
    //验证验证码
    NSDictionary *parameters = @{@"u_account":[Single getUserModel].uPhone,@"clientCode":self.textField.text};
    WS(weakSelf)
    [self POST:API_UpdatePassword_VerificationCode parameters:parameters success:^(NSDictionary *dic) {
        
        NewPasswordVC *newPasswordVC = [[NewPasswordVC alloc] init];
        [weakSelf.navigationController pushVC:newPasswordVC animated:YES];
        
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.view animated:YES];
    

}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    if (indexPath.section == 0) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = Image(@"Mine_UpdatePassword");
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }else
    {
        switch (indexPath.row) {
            case 0:
            {
                [self setCell1WithCell:cell];
            }
                break;
            case 1:
            {
                [self setCell2WithCell:cell];
            }
                break;
            case 2:
            {
                [self setCell3WithCell:cell];
            }
                break;
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return  kSection1H;
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
- (UIButton *)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setTitle:String(@"下一步") forState:UIControlStateNormal];
        [_nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_nextButton setBackgroundColor:QF_RedColor];
        [_nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
