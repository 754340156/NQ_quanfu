//
//  CreateOrderBottomView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CreateOrderBottomView.h"
#define kSubmitW 100.0f

@interface CreateOrderBottomView ()
/**  实付款 */
@property(nonatomic,strong) UILabel * factPrice;
/**  提交订单 */
@property(nonatomic,strong) UIButton * submitOrderBtn;
@end

@implementation CreateOrderBottomView

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
    self.factPrice = [[UILabel alloc] init];
    [self.factPrice sizeToFit];
    self.factPrice.font = Font_Mid;
    self.factPrice.textColor = QF_BlackColor;
    [self addSubview:self.factPrice];
    
    self.submitOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitOrderBtn.backgroundColor = QF_RedColor;
    [self.submitOrderBtn setTitle:String(@"提交订单") forState:UIControlStateNormal];
    self.submitOrderBtn.titleLabel.font = Font_Max;
    [self.submitOrderBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.submitOrderBtn addTarget:self action:@selector(submitOrderAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.submitOrderBtn];
}
- (void)setLayout
{
    [self.submitOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.width.offset(Adapted(kSubmitW));
    }];
    
    [self.factPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.submitOrderBtn.mas_left).offset(Adapted(-kMargin));
        make.centerY.equalTo(self.mas_centerY);
    }];
}
#pragma mark - custom method

#pragma mark - handle action
- (void)submitOrderAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CreateOrderBottomViewDelegate_clickSubmitBtn)]) {
        [self.delegate CreateOrderBottomViewDelegate_clickSubmitBtn];
    }
}
#pragma mark - setter model


@end
