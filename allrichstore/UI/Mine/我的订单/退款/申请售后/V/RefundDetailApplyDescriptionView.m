//
//  RefundDetailApplyDescriptionView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RefundDetailApplyDescriptionView.h"
#import "PlaceholderTextView.h"
#define kLabelH 20.0f
@interface RefundDetailApplyDescriptionView ()
/**  titlelabel */
@property(nonatomic,strong) UILabel * titleLabel;
/**  输入框 */
@property(nonatomic,strong) PlaceholderTextView * textView;

@end

@implementation RefundDetailApplyDescriptionView
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
    self.titleLabel.font = Font_Mid;
    self.titleLabel.text = @"问题描述";
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    [self addSubview:self.titleLabel];
    
    self.textView = [[PlaceholderTextView alloc] init];
    self.textView.font = Font_Mid;
    self.textView.textColor = QF_BlackColor;
    self.textView.placeholder = @"请您描述详细问题...";
    [self addSubview:self.textView];
}
- (void)setLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Adapted(kMargin));
        make.right.offset(Adapted(kMargin));
        make.bottom.offset(Adapted(-kMargin));
    }];
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model


@end
