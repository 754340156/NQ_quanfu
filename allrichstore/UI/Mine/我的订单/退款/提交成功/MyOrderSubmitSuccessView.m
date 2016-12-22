//
//  MyOrderSubmitSuccessView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderSubmitSuccessView.h"

#define kBackViewH 120.0f
#define kButtonSize CGSizeMake(Adapted(85), Adapted(33))
@interface MyOrderSubmitSuccessView ()
/**  申请成功 */
@property(nonatomic,strong) UILabel * successLabel;
/**  申请时间 */
@property(nonatomic,strong) UILabel * timeLabel;
/**  查看进度 */
@property(nonatomic,strong) UIButton * progressSearchBtn;
/**  售后首页 */
@property(nonatomic,strong) UIButton * homeBtn;
@end

@implementation MyOrderSubmitSuccessView

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
    UIView * backView = [[UIView alloc] init];
    backView.backgroundColor = kWhiteColor;
    [self addSubview:backView];
    
    self.successLabel = [[UILabel alloc] init];
    self.successLabel.text = @"售后服务单申请成功";
    self.successLabel.textAlignment = NSTextAlignmentCenter;
    [self.successLabel sizeToFit];
    self.successLabel.font = Font_Max;
    self.successLabel.textColor = QF_BlackColor;
    [backView addSubview:self.successLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.timeLabel sizeToFit];
    self.timeLabel.font = Font_Mid;
    self.timeLabel.textColor = QF_BlackColor;
    [backView addSubview:self.timeLabel];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(Adapted(kBackViewH));
    }];
    
    self.progressSearchBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setupButtonWithButton:self.progressSearchBtn Title:String(@"查看进度") Target:@selector(progressSearchAction)];
    [self addSubview:self.progressSearchBtn];
    
    self.homeBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setupButtonWithButton:self.homeBtn Title:String(@"售后首页") Target:@selector(homeAction)];
    [self addSubview:self.homeBtn];
    
    [self.homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(kButtonSize);
        make.right.offset(Adapted(-kMargin));
        make.top.equalTo(backView.mas_bottom).offset(Adapted(kMargin));
    }];
    
    [self.progressSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(kButtonSize);
        make.right.equalTo(self.homeBtn.mas_left).offset(Adapted(-kMargin));
        make.top.equalTo(backView.mas_bottom).offset(Adapted(kMargin));
    }];
}
- (void)setLayout
{
    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.left.right.offset(0);
        make.centerY.offset(Adapted(-kMargin * 2));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.left.right.offset(0);
        make.centerY.offset(Adapted(kMargin * 2));
    }];
}
#pragma mark - custom method
- (void)setupButtonWithButton:(UIButton *)sender Title:(NSString *)title Target:(SEL)target
{
    sender.titleLabel.font = Font_Mid;
    [sender setTitle:title forState:UIControlStateNormal];
    sender.layer.cornerRadius = 5.0f;
    sender.layer.masksToBounds = YES;
    sender.layer.borderColor = QF_GrayColor.CGColor;
    sender.layer.borderWidth = 0.5f;
    [sender addTarget:self action:target forControlEvents:UIControlEventTouchUpInside];
    [sender setTitleColor:QF_GrayColor forState:UIControlStateNormal];
}
#pragma mark - handle action
//查看进度
- (void)progressSearchAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyOrderSubmitSuccessViewDelegate_clickProgressSearch)]) {
        [self.delegate MyOrderSubmitSuccessViewDelegate_clickProgressSearch];
    }
}
//售后首页
- (void)homeAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyOrderSubmitSuccessViewDelegate_clickHome)]) {
        [self.delegate MyOrderSubmitSuccessViewDelegate_clickHome];
    }
}
#pragma mark - setter model
- (void)setTime:(NSString *)time
{
    _time = time;
    self.timeLabel.text = [NSString stringWithFormat:@"申请时间：%@",time];
}
@end
