//
//  Authentication_HomeView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Authentication_HomeView.h"
#import "CustomInputView.h"

@interface Authentication_HomeView ()
/**  name */
@property(nonatomic,strong) CustomInputView * nameView;
/**  identitycard */
@property(nonatomic,strong) CustomInputView * identityCardView;
/**  next */
@property(nonatomic,strong) UIButton * nextButton;
@end

@implementation Authentication_HomeView

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
    self.nameView = [[CustomInputView alloc] initWithTitleName:String(@"真实姓名") PlaceHolder:nil IsGrayLine:YES];
    [self addSubview:self.nameView];

    self.identityCardView = [[CustomInputView alloc] initWithTitleName:String(@"身份证号") PlaceHolder:nil IsGrayLine:NO];
    [self addSubview:self.identityCardView];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setBackgroundImage:[UIImage imageWithColor:QF_RedColor] forState:UIControlStateNormal];
    [self.nextButton setBackgroundImage:[UIImage imageWithColor:QF_GrayColor] forState:UIControlStateDisabled];
    [self.nextButton setTitle:String(@"下一步") forState:UIControlStateNormal];
    [self.nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.nextButton];
}
- (void)setLayout
{
    UILabel *titleLabel1 = [[UILabel alloc] init];
    [self addSubview:titleLabel1];
    titleLabel1.font = Font_Min;
    titleLabel1.textColor = QF_GrayColor;
    titleLabel1.text = String(@"请填写您的真实姓名,通过后将不能更改");
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.offset(0);
        make.left.offset(kMargin);
        make.height.offset(40);
    }];
    
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel1.mas_bottom);
        make.left.right.offset(0);
        make.height.offset(kHeight);
    }];
    
    [self.identityCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameView.mas_bottom);
        make.left.right.offset(0);
        make.height.offset(kHeight);
    }];
    
    
    UILabel *titleLabel2  = [[UILabel alloc] init];
    [self addSubview:titleLabel2];
    titleLabel2.font = Font_Min;
    titleLabel2.textColor = QF_GrayColor;
    titleLabel2.text = String(@"实名认证后您的账户将得到更完美的保护,投资支付更安全");
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.left.offset(kMargin);
        make.top.equalTo(self.identityCardView.mas_bottom);
        make.height.offset(40);
    }];

    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(kBottomH);
    }];
    
}
#pragma mark - custom method

#pragma mark - handle action
- (void)nextAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(Authentication_HomeViewDelegate_clickNextButton)]) {
        [self.delegate Authentication_HomeViewDelegate_clickNextButton];
    }
}
#pragma mark - setter model

@end
