//
//  VerificationPhonePopView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "VerificationPhonePopView.h"
#define kBackViewSize CGSizeMake(Adapted(290), Adapted(170))
#define kTextFieldH 40.0f
#define kTextFieldW 165.0f

@interface VerificationPhonePopView ()
/**  back */
@property(nonatomic,strong) UIView * backView;
/**  title */
@property(nonatomic,strong) UILabel * titleLabel;
/**  subtitle */
@property(nonatomic,strong) UILabel * subTitleL;
/**  确定 */
@property(nonatomic,strong) UIButton * sureBtn;
/**  取消 */
@property(nonatomic,strong) UIButton * cancelBtn;

/**  获取验证码 */
@property(nonatomic,strong) UIButton * getCodeBtn;
/**  保存验证码 */
@property(nonatomic,copy) NSString * code;
@end

@implementation VerificationPhonePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setLayout];
        
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.backView = [[UIView alloc] init];
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 5.0f;
    self.backView.backgroundColor = kWhiteColor;
    self.backView.size = kBackViewSize;
    self.backView.centerX = self.centerX;
    self.backView.centerY = self.centerY - Adapted(50);
    self.backView.alpha = 0;
    [self addSubview:self.backView];
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.backView.alpha = 1.0f;
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    [self setLabel:self.titleLabel Title:String(@"验证手机号")];
    [self.backView addSubview:self.titleLabel];
    
    self.subTitleL = [[UILabel alloc] init];
    [self setLabel:self.subTitleL Title:@""];
    [self.backView addSubview:self.subTitleL];
    
    self.textfield = [[UITextField alloc] init];
    self.textfield.placeholder = String(@"丨填写短信验证码");
    self.textfield.font = Font_Mid;
    self.textfield.textColor = QF_BlackColor;
    self.textfield.layer.borderColor = Home_ListCell_Line_Color.CGColor;
    self.textfield.layer.borderWidth = ListCell_Line_W_H / 2;
    [self.backView addSubview:self.textfield];
    
    self.getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getCodeBtn setTitle:String(@"获取验证码") forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:QF_RedColor forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = Font_Min;
    self.getCodeBtn.layer.borderColor = Home_ListCell_Line_Color.CGColor;
    self.getCodeBtn.layer.borderWidth = ListCell_Line_W_H / 2;
    [self.getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.getCodeBtn];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.cancelBtn Title:String(@"取消") TitleColor:QF_BlackColor target:@selector(cancelAction)];
    [self.backView addSubview:self.cancelBtn];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.sureBtn Title:String(@"确定") TitleColor:QF_RedColor target:@selector(sureAction)];
    [self.backView addSubview:self.sureBtn];
    [self.sureBtn addLeftLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
}
- (void)setLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(Adapted(kMargin));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.subTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Adapted(kMargin));
        make.left.right.offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin * 2));
        make.top.equalTo(self.subTitleL.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(kTextFieldW), Adapted(kTextFieldH)));
    }];
    
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textfield.mas_top);
        make.right.offset(Adapted(-kMargin * 2));
        make.left.equalTo(self.textfield.mas_right).offset(2);
        make.bottom.equalTo(self.textfield.mas_bottom);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.size.mas_offset(CGSizeMake(_backView.width / 2, Adapted(kTextFieldH)));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(0);
        make.size.mas_offset(CGSizeMake(_backView.width / 2, Adapted(kTextFieldH)));
    }];
}
#pragma mark - custom method
- (void)setLabel:(UILabel *)label Title:(NSString *)title
{
    label.font = Font_Mid;
    label.textColor = QF_BlackColor;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
}
- (void)setButtonWithButton:(UIButton *)button Title:(NSString *)title TitleColor:(UIColor *)titleColor target:(SEL)target
{
    button.titleLabel.font = Font_Mid;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor: kWhiteColor];
    [button addTarget:self action:target forControlEvents:UIControlEventTouchUpInside];
    [button addTopLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}
#pragma mark - handle action
//获取验证码
- (void)getCodeAction:(UIButton *)sender
{
    //发送验证码
    NSDictionary *parameters = @{@"u_account":self.phone};
    WS(weakSelf)
    [self.superViewController POST:API_SendCode parameters:parameters success:^(NSDictionary *dic) {
        [weakSelf.superview showToastMsg:dic[@"errorMessage"]];
        weakSelf.code = dic[@"response"];
        [Tools countdownButton:sender timeout:60 originalTitle:String(@"获取验证码") timingTitle:@""];
    } fail:^(NSError *error) {
        
    } sendView:nil animSuperView:self.superview animated:YES];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(VerificationPhonePopViewDelegate_clickGetCodeWithButton:)]) {
        [self.delegate VerificationPhonePopViewDelegate_clickGetCodeWithButton:sender];
    }
}
//取消
- (void)cancelAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(VerificationPhonePopViewDelegate_clickSure:)]) {
        [self.delegate VerificationPhonePopViewDelegate_clickSure:NO];
    }
}
//确定
- (void)sureAction
{
    if ([NSString isEmpty:self.textfield.text]) {
        [self.superview showToastMsg:@"验证码不能为空"];
        return;
    }
    //验证验证码
    if (![self.textfield.text isEqualToString:self.code]) {
        [self.superview showToastMsg:@"验证码不正确"];
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(VerificationPhonePopViewDelegate_clickSure:)]) {
        [self.delegate VerificationPhonePopViewDelegate_clickSure:YES];
    }
}
#pragma mark - setter model
- (void)setPhone:(NSString *)phone
{
    _phone = phone;
    self.subTitleL.text = [NSString stringWithFormat:String(@"输入手机尾号%@接收到的验证码"),[NSString StringEndFourWithStr:phone]];
}
//移除视图重置textField
- (void)removeFromSuperview
{
    self.textfield.text = @"";
    [super removeFromSuperview];
}
@end
