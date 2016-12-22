//
//  MyCashCounponTotalCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCashCounponTotalView.h"

@interface MyCashCounponTotalView ()
/**  title */
@property(nonatomic,strong) UILabel * titleLabel;
/**  total */
@property(nonatomic,strong) UILabel * totalLabel;
/**  imageView */
@property(nonatomic,strong) UIImageView * imageView;
@end

@implementation MyCashCounponTotalView

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
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = Image(@"quanfuxianjinbeijing");
    [self addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = String(@"全富现金");
    [self.titleLabel sizeToFit];
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    [self addSubview:self.titleLabel];
    
    self.totalLabel = [[UILabel alloc] init];
    self.totalLabel.textColor = QF_RedColor;
    self.totalLabel.font = AdaptedFont(18);
    self.totalLabel.textAlignment = NSTextAlignmentCenter;
    [self.totalLabel sizeToFit];
    [self addSubview:self.totalLabel];
}
- (void)setLayout
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY).offset(Adapted(- kMargin / 2));
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(Adapted(kMargin / 2));
        make.centerX.equalTo(self.mas_centerX);
        make.width.offset(kScreenW);
    }];
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setTotal:(NSString *)total
{
    _total = total;
    self.totalLabel.text = [NSString stringWithFormat:@"%.2f元",total.floatValue];
}
@end
