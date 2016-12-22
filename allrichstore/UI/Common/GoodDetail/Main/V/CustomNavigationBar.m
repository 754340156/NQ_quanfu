//
//  CustomNavigationBar.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CustomNavigationBar.h"

#define kButtonSize CGSizeMake(30, 30)
@interface CustomNavigationBar ()
/**  返回按钮 */
@property(nonatomic,strong) UIButton * backButton;
/**  分享 */
@property(nonatomic,strong) UIButton * shareButton;
/**  购物车 */
@property(nonatomic,strong) UIButton * cartButton;

@end

@implementation CustomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //开始默认
        self.backgroundColor = ColorWhiteAlpha(0.97, 0);
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:Image(@"fanhuijian") forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareButton setImage:Image(@"fenxiang_daidi") forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shareButton];
    
    self.cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cartButton setImage:Image(@"gouwuche_daidi") forState:UIControlStateNormal];
    [self.cartButton addTarget:self action:@selector(cartAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cartButton];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.alpha = 0;
    self.lineView.backgroundColor = Home_ListCell_Line_Color;
    [self addSubview:self.lineView];
}
- (void)setLayout
{
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kMargin);
        make.size.mas_offset(kButtonSize);
        make.centerY.offset(kMargin);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.centerY.equalTo(self.backButton.mas_centerY);
        make.size.mas_offset(kButtonSize);
    }];
    
    [self.cartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareButton.mas_left).offset(-kMargin);
        make.centerY.equalTo(self.backButton.mas_centerY);
        make.size.mas_offset(kButtonSize);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(self.width);
        make.bottom.offset(0);
        make.height.offset(ListCell_Line_W_H);
    }];
}
#pragma mark - custom method
/**  设置隐藏状态下的图片 */
- (void)setHiddenStatusButtonImage
{
    self.backgroundColor = ColorWhiteAlpha(0.97,0);
    self.lineView.alpha = 0;
    [self.shareButton setImage:Image(@"fenxiang_daidi") forState:UIControlStateNormal];
    [self.cartButton setImage:Image(@"gouwuche_daidi") forState:UIControlStateNormal];
}
/**  设置显示状态下的图片 */
- (void)setShowStatusButtonImageWithAlpha:(CGFloat)alpha
{
    self.backgroundColor = ColorWhiteAlpha(0.97,alpha);
    self.lineView.alpha = alpha;
    [self.shareButton setImage:Image(@"fenxiang") forState:UIControlStateNormal];
    [self.cartButton setImage:Image(@"gouwuche") forState:UIControlStateNormal];
}
#pragma mark - handle action
- (void)backAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CustomNavigationBar_back)]) {
        [self.delegate CustomNavigationBar_back];
    }
}
- (void)shareAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CustomNavigationBar_share)]) {
        [self.delegate CustomNavigationBar_share];
    }
}
- (void)cartAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CustomNavigationBar_cart)]) {
        [self.delegate CustomNavigationBar_cart];
    }
}
#pragma mark - setter model

@end
