//
//  RefundDetailApplyCountView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RefundDetailApplyCountView.h"

#define kLabelH 20.0f
@interface RefundDetailApplyCountView ()
/**  title */
@property(nonatomic,strong) UILabel * titleLabel;
/**  - */
@property(nonatomic,strong) UIButton * reduceButton;
/**  数字label */
@property(nonatomic,strong) UILabel * numberLabel;
/**  + */
@property(nonatomic,strong) UIButton * addButton;
@end

@implementation RefundDetailApplyCountView

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
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel sizeToFit];
    self.titleLabel.text = @"申请数量";
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    [self addSubview:self.titleLabel];
    
    self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reduceButton setBackgroundColor:QFColor_CoodsClassMenuViewBg];
    [self.reduceButton setTitle:@"-" forState:UIControlStateNormal];
    [self.reduceButton setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self.reduceButton setTitleColor:QF_GrayColor forState:UIControlStateDisabled];
    [self.reduceButton addTarget:self action:@selector(reduceAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.reduceButton];
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.text = @"1";
    self.numberLabel.font = Font_Mid;
    self.numberLabel.textColor = QF_BlackColor;
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self addSubview:self.numberLabel];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton setBackgroundColor:QFColor_CoodsClassMenuViewBg];
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    [self.addButton setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self.addButton setTitleColor:QF_GrayColor forState:UIControlStateDisabled];
    [self.addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addButton];
}
- (void)setLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(kLabelH),Adapted(kLabelH)));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reduceButton.mas_right).offset(2);
        make.centerY.equalTo(self.reduceButton.mas_centerY);
        make.size.mas_offset(CGSizeMake(Adapted(kLabelH * 2), Adapted(kLabelH)));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numberLabel.mas_right).offset(2);
        make.centerY.equalTo(self.reduceButton.mas_centerY);
        make.size.mas_offset(CGSizeMake(Adapted(kLabelH), Adapted(kLabelH)));
    }];
}
#pragma mark - custom method

#pragma mark - handle action
- (void)addButtonAction
{
    if (self.clickAddBlock) {
        self.clickAddBlock(self.numberLabel);
    }
}
- (void)reduceAction
{
    if (self.clickReduceBlock) {
        self.clickReduceBlock(self.numberLabel);
    }
}
#pragma mark - setter model


@end
