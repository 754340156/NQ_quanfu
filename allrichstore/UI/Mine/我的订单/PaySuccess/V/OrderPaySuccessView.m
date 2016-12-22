//
//  OrderPaySuccessView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "OrderPaySuccessView.h"
#define kBackViewH 120.0f
@interface OrderPaySuccessView ()
/**  显示交易成功 */
@property(nonatomic,strong) UILabel * successLabel;
/**  立即评价 */
@property(nonatomic,strong) UIButton * commentButton;
/**  订单详情 */
@property(nonatomic,strong) UIButton * orderDetailBtn;
@end

@implementation OrderPaySuccessView
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
    [self addSubview:backView];
    
    self.successLabel = [[UILabel alloc] init];
    [self.successLabel sizeToFit];
    self.successLabel.font = Font_Max;
    self.successLabel.textColor = QF_BlackColor;
    [backView addSubview:self.successLabel];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(Adapted(kBackViewH));
    }];
    
    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_centerX);
        make.centerY.equalTo(backView.mas_centerY);
    }];
    
    self.commentButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.commentButton Title:String(@"立即评价") TitleColor:kWhiteColor BackgroundColor:QF_RedColor Target:@selector(commentAction)];
    [self addSubview:self.commentButton];
    
    self.orderDetailBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.orderDetailBtn Title:String(@"订单详情") TitleColor:QF_RedColor BackgroundColor:kWhiteColor Target:@selector(orderDetailAction)];
    [self addSubview:self.orderDetailBtn];
}
- (void)setLayout
{
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.orderDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}
#pragma mark - custom method
- (void)setButtonWithButton:(UIButton *)sender Title:(NSString *)title TitleColor:(UIColor *)titleColor BackgroundColor:(UIColor *)backgroundColor Target:(SEL)target
{
    [sender setBackgroundColor:backgroundColor];
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setTitleColor:titleColor forState:UIControlStateNormal];
    sender.titleLabel.font = Font_Mid;
    sender.layer.masksToBounds = YES;
    sender.layer.cornerRadius = 5.0f;
    [sender addTarget:self action:target forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - handle action
- (void)commentAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderPaySuccessViewDelegate_clickCommentButton)]) {
        [self.delegate OrderPaySuccessViewDelegate_clickCommentButton];
    }
}
- (void)orderDetailAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(OrderPaySuccessViewDelegate_cliclOrderDetailBtn)]) {
        [self.delegate OrderPaySuccessViewDelegate_cliclOrderDetailBtn];
    }
}
#pragma mark - setter model



@end
