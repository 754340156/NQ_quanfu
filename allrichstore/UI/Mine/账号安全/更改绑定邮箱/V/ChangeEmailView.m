//
//  ChangeEmailView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ChangeEmailView.h"
@interface ChangeEmailView ()
/**  验证码按钮 */
@property(nonatomic,strong) UIButton * verificationCodeBtn;
/**  完成 */
@property(nonatomic,strong) UIButton * finishButton;
@end

@implementation ChangeEmailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = QFColor_CoodsClassMenuViewBg;
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    UIView *backView1 = [[UIView alloc] init];
    backView1.backgroundColor = kWhiteColor;
    [backView1 addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self addSubview:backView1];
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.offset(kBottomH);
    }];
    
    UIView *backView2 = [[UIView alloc] init];
    backView2.backgroundColor = kWhiteColor;
    [backView2 addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self addSubview:backView2];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView1.mas_bottom);
        make.left.right.offset(0);
        make.height.offset(kBottomH);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel sizeToFit];
    titleLabel.backgroundColor = kWhiteColor;
    titleLabel.text = String(@"请输入邮箱");
    titleLabel.textColor = QF_BlackColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = Font_Mid;
    [backView1 addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.width.offset(100);
        make.centerY.offset(0);
    }];
    
    self.passwordTF = [[UITextField alloc] init];
    self.passwordTF.placeholder = @"请输入邮箱";
    self.passwordTF.font = Font_Mid;
    self.passwordTF.textColor = QF_BlackColor;
    self.passwordTF.backgroundColor = kWhiteColor;
    [backView1 addSubview:self.passwordTF];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right);
        make.right.offset(-kMargin);
        make.centerY.offset(0);
    }];
    
    self.verificationCodeTF = [[UITextField alloc] init];
    self.verificationCodeTF.backgroundColor = kWhiteColor;
    self.verificationCodeTF.placeholder = @"请输入验证码";
    self.verificationCodeTF.font = Font_Mid;
    self.verificationCodeTF.textColor = QF_BlackColor;
    [backView2 addSubview:self.verificationCodeTF];
    
    self.verificationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.verificationCodeBtn setTitle:String(@"获取验证码") forState:UIControlStateNormal];
     self.verificationCodeBtn.backgroundColor = kWhiteColor;
    self.verificationCodeBtn.titleLabel.font = Font_Min;
    [self.verificationCodeBtn setTitleColor:QF_RedColor forState:UIControlStateNormal];
    [self.verificationCodeBtn addTarget:self action:@selector(verificationCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView2 addSubview:self.verificationCodeBtn];
    
    self.finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.finishButton setTitle:String(@"完成") forState:UIControlStateNormal];
    [self.finishButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.finishButton setBackgroundColor:QF_RedColor];
    [self.finishButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.finishButton];
}
- (void)setLayout
{

    [self.passwordTF addLeftLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self.verificationCodeTF addLeftLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self.verificationCodeBtn addLeftLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    
    

    
    [self.verificationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.offset(0);
        make.size.mas_offset(CGSizeMake(Adapted(95), kBottomH));
    }];
    
    [self.verificationCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.centerY.offset(0);
        make.right.equalTo(self.verificationCodeBtn.mas_left);
    }];
    
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(kBottomH);
    }];
}
#pragma mark - custom method

#pragma mark - handle action
- (void)finishAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ChangeEmailViewDelegate_clickFinishButton)]) {
        [self.delegate ChangeEmailViewDelegate_clickFinishButton];
    }
}
- (void)verificationCodeAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ChangeEmailViewDelegate_clickVerificationCodeBtnWithButton:)]) {
        [self.delegate ChangeEmailViewDelegate_clickVerificationCodeBtnWithButton:sender];
    }
}
#pragma mark - setter model


@end
