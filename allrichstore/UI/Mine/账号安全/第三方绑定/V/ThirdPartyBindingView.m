//
//  ThirdPartyBindingView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/21.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ThirdPartyBindingView.h"
#define kBackViewH 150.0f
@interface ThirdPartyBindingView ()
/**  backView */
@property(nonatomic,strong) UIView * backView;
/**  titleLabel */
@property(nonatomic,strong) UILabel * titleLabel;
/**  cancelBinding */
@property(nonatomic,strong) UIButton * cancelBindingBtn;
@end


@implementation ThirdPartyBindingView

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
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = kWhiteColor;
    [self addSubview:self.backView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    [self.backView addSubview:self.titleLabel];
    
    self.cancelBindingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBindingBtn setTitle:@"解除关联" forState:UIControlStateNormal];
    [self.cancelBindingBtn setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self.cancelBindingBtn setBackgroundColor:kWhiteColor];
    [self.cancelBindingBtn addTarget:self action:@selector(cancelBindingAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.cancelBindingBtn];
}
- (void)setLayout
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(kBackViewH);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
        make.left.right.offset(0);
    }];
    
    [self.cancelBindingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(kBottomH);
    }];
}
#pragma mark - custom method

#pragma mark - handle action
- (void)cancelBindingAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ThirdPartyBindingViewDelegate_clickCancelBinding)]) {
        [self.delegate ThirdPartyBindingViewDelegate_clickCancelBinding];
    }
}
#pragma mark - setter model


@end
