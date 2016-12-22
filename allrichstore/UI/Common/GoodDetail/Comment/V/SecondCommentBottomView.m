
//
//  SecondCommentBottomView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SecondCommentBottomView.h"
#define  kMargin 10.0f
#define  kButtonW 70.0f
@interface SecondCommentBottomView ()
/**  textFiled */
@property(nonatomic,strong) UITextField * textField;
/**  submit */
@property(nonatomic,strong) UIButton * submimtBtn;
@end

@implementation SecondCommentBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.textField = [[UITextField alloc] init];
    self.textField.placeholder = @"请输入您要回复的内容";
    self.textField.font = Font_Mid;
    self.textField.textColor = QF_BlackColor;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:self.textField];
    
    self.submimtBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submimtBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.submimtBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.submimtBtn setBackgroundColor:QF_OrangeColor];
    self.submimtBtn.layer.cornerRadius = 5.0f;
    self.submimtBtn.layer.masksToBounds = YES;
    [self.submimtBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.submimtBtn];
}
- (void)setLayout
{
    [self.submimtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(Adapted(kMargin * 2 / 3));
        make.right.offset(Adapted(-kMargin));
        make.bottom.offset(Adapted(-kMargin * 2 / 3));
        make.width.offset(Adapted(kButtonW));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.right.equalTo(self.submimtBtn.mas_left).offset(Adapted(-kMargin * 2 / 3));
        make.top.offset(Adapted(kMargin * 2 / 3));
        make.bottom.offset(Adapted(-kMargin * 2 / 3));
    }];
}
#pragma mark - custom method

#pragma mark - handle action
- (void)submitAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SecondCommentBottomViewDelegate_clickSubmit)]) {
        [self.delegate SecondCommentBottomViewDelegate_clickSubmit];
    }
}
#pragma mark - setter model


@end
