//
//  ShopHomeTopView.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopHomeTopView.h"
@interface ShopHomeTopView ()

//用来触发点击进入店铺的事件
@property (nonatomic, strong) UIButton *alphaBtn;

@end

@implementation ShopHomeTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = Color_CustomEffectViewbg;
        [self showEffectViewWithStyle:UIBlurEffectStyleExtraLight alpha:1.0];
        [self createViews]; //创建子视图
        [self layoutViews]; //布局子视图
 
    }
    return self;
}

//创建子视图
- (void)createViews
{
    [self addSubview:self.shopIconImgView];
    [self addSubview:self.shopNameLabel];
    [self addSubview:self.shopScoreLabel];
    [self addSubview:self.collectShopBtn];
    
}

//布局子视图
- (void)layoutViews
{
    [_shopIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(Adapted(kMargin));
        make.top.offset(Adapted(kMargin));
        make.bottom.offset(-Adapted(kMargin));
        make.width.equalTo(_shopIconImgView.mas_height);
        
    }];
    
    [_shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_shopIconImgView);
        make.top.equalTo(_shopIconImgView);
        make.bottom.equalTo(_shopIconImgView);
        make.left.equalTo(_shopIconImgView.mas_right).offset(Adapted(kMargin));
        
    }];
    
    [_shopScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_shopIconImgView);
        make.top.equalTo(_shopIconImgView);
        make.bottom.equalTo(_shopIconImgView);
        make.left.equalTo(_shopNameLabel.mas_right).offset(Adapted(12));
        
    }];
    
    [_collectShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-Adapted(kMargin));
        make.centerY.equalTo(_shopIconImgView);
        make.height.offset(Adapted(28));
        make.width.equalTo(_collectShopBtn.mas_height).multipliedBy(2.8);
        
    }];
    
    [_alphaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.and.top.bottom.equalTo(_shopIconImgView);
        make.right.equalTo(_collectShopBtn.mas_left).offset(-Adapted(kMargin));
    }];
}

#pragma mark - lazy
//店铺图标
- (UIImageView *)shopIconImgView
{
    if (!_shopIconImgView)
    {
        self.shopIconImgView = [UIImageView new];
    }
    return _shopIconImgView;
}

//店铺标题
- (UILabel *)shopNameLabel
{
    if (!_shopNameLabel)
    {
        self.shopNameLabel = [UILabel new];
        _shopNameLabel.textColor = QF_BlackColor;
        _shopNameLabel.font = AdaptedFontSize(17);
    }
    return _shopNameLabel;
}

//店铺评分
- (UILabel *)shopScoreLabel
{
    if (!_shopScoreLabel)
    {
        self.shopScoreLabel = [UILabel new];
        _shopScoreLabel.textColor = QF_DarkGrayColor;
        _shopScoreLabel.font = AdaptedFontSize(15);
    }
    return _shopScoreLabel;
}

//收藏店铺
- (QButton *)collectShopBtn
{
    if (!_collectShopBtn)
    {
        self.collectShopBtn = [[QButton alloc] init];
        _collectShopBtn.transparentWhenhighlight = YES;
        [_collectShopBtn setTitleColor:QF_RedColor forState:UIControlStateNormal];
        _collectShopBtn.titleLabel.font = AdaptedFontSize(14);
        _collectShopBtn.layer.masksToBounds = YES;
        _collectShopBtn.layer.cornerRadius = Adapted(3.0);
        _collectShopBtn.layer.borderColor = QF_RedColor.CGColor;
        _collectShopBtn.layer.borderWidth = 0.5;
        [_collectShopBtn setTitle:String(@"收藏") forState:UIControlStateNormal];
        [_collectShopBtn setTitle:String(@"已收藏") forState:UIControlStateSelected];
        [_collectShopBtn addTarget:self action:@selector(handleCollectShop:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectShopBtn;
}

- (UIButton *)alphaBtn
{
    if (!_alphaBtn)
    {
        self.alphaBtn = [UIButton new];
        [_alphaBtn addTarget:self action:@selector(handleJoinShopIntroduce:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alphaBtn;
}

#pragma mark - custom method

#pragma mark - handle action
//进入店铺介绍
- (void)handleJoinShopIntroduce:(UIButton *)sender
{
    NSLog(@"进入店铺介绍");
}

//收藏店铺
- (void)handleCollectShop:(UIButton *)sender
{
    
    if (sender.selected)
    {
        NSLog(@"取消收藏店铺");
        sender.selected = !sender.selected;
    }
    else
    {
        NSLog(@"收藏店铺");
        sender.selected = !sender.selected;
    }
}

#pragma mark - setter model



@end
