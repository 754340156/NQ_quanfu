//
//  IdentityVerificationVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "IdentityVerificationVC.h"
#import "EmailVerificationVC.h"
#define kPayLabelW 135.0f
@interface IdentityVerificationVC ()
/**  next */
@property(nonatomic,strong) UIButton * nextButton;
/**  textField */
@property(nonatomic,strong) UITextField * textField;
@end

@implementation IdentityVerificationVC

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
    [self setup];
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
- (void)nextAction
{
    //验证支付密码
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
//        [Tools showToastMsg:@"验证zhif" completion:<#^(void)completion#>]
        [Tools showToastMsg:@"验证zhif" completion:^{
            
        }];
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
    
    EmailVerificationVC * emailVC = [[EmailVerificationVC alloc] init];
    [self.navigationController pushVC:emailVC animated:YES];
}

#pragma mark - handle action

- (void)setLabelWithLabel:(UILabel *)label Title:(NSString *)title TitleColor:(UIColor *)titleColor Font:(UIFont *)font
{
    label.text = title;
    label.textColor = titleColor;
    label.font = font;
    [label sizeToFit];
}
- (void)setup
{
    UILabel *titleLabel = [[UILabel alloc] init];
    [self setLabelWithLabel:titleLabel Title:String(@"输入修改支付密码，完成身份验证") TitleColor:QF_GrayColor Font:Font_Min];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopBarHeight + kMargin);
        make.left.offset(kMargin);
    }];
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = kWhiteColor;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(kMargin);
        make.left.right.offset(0);
        make.height.offset(kBottomH);
    }];
    
    UILabel *payLabel = [[UILabel alloc] init];
    [self setLabelWithLabel:payLabel Title:String(@"支付密码") TitleColor:QF_BlackColor Font:Font_Mid];
    [backView addSubview:payLabel];
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.centerY.offset(0);
        make.width.offset(kPayLabelW);
    }];
    
    [backView addSubview:self.textField];
    [self.view addSubview:self.nextButton];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(payLabel.mas_right);
        make.right.offset(-kMargin);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(kBottomH);
    }];
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
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        [_textField addLeftLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
        _textField.font = Font_Mid;
        _textField.textColor = QF_BlackColor;
    }
    return _textField;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
