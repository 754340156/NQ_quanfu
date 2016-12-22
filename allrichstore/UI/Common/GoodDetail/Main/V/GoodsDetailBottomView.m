//
//  GoodsDetailBottomView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsDetailBottomView.h"

@interface GoodsDetailBottomView ()
/**  客服 */
@property(nonatomic,strong) QButton * serviceBtn;
/**  店铺 */
@property(nonatomic,strong) QButton * storeBtn;
/**  收藏 */
@property(nonatomic,strong) QButton * collectionBtn;
/**  加入购物车 */
@property(nonatomic,strong) UIButton * intoCartBtn;
/**  立即购买 */
@property(nonatomic,strong) UIButton * buyBtn;

@end

@implementation GoodsDetailBottomView

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
    self.serviceBtn = [[QButton alloc] initWithFrame:CGRectZero style:QButtonStyleImageTop font:QFFont_GoodsSquareCell_Min title:String(@"客服") image:Image(@"kefu") space:5.0 autoSize:NO];
    [self.serviceBtn addTarget:self action:@selector(serviceAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.serviceBtn];
    
    self.storeBtn =[[QButton alloc] initWithFrame:CGRectZero style:QButtonStyleImageTop font:QFFont_GoodsSquareCell_Min title:String(@"店铺") image:Image(@"dianpu") space:5.0 autoSize:NO];
    [self.storeBtn addTarget:self action:@selector(storeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.storeBtn];
    
    self.collectionBtn =[[QButton alloc] initWithFrame:CGRectZero style:QButtonStyleImageTop font:QFFont_GoodsSquareCell_Min title:String(@"收藏") image:Image(@"shoucang") space:5.0 autoSize:NO];
    [self.collectionBtn setImage:Image(@"shoucang_dianliang") forState:UIControlStateSelected];
    [self.collectionBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.collectionBtn];
    
    self.intoCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.intoCartBtn.titleLabel.font = Font_Mid;
    [self.intoCartBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.intoCartBtn setBackgroundColor:RGB(255, 186, 99)];
    [self.intoCartBtn setTitle:String(@"加入购物车") forState:UIControlStateNormal];
    [self.intoCartBtn addTarget:self action:@selector(intoCartAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.intoCartBtn];
    
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buyBtn.titleLabel.font = Font_Mid;
    [self.buyBtn setTitle:String(@"立即购买") forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.buyBtn setBackgroundColor:RGB(246, 105, 68)];
    [self addSubview:self.buyBtn];
}
- (void)setLayout
{
    CGFloat width = (kScreenW - 2 * GD_BottomBuyW) / 3;
    [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.bottom.offset(0);
        make.width.offset(width);
    }];
    
    [self.storeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.equalTo(self.serviceBtn.mas_right).offset(0);
        make.bottom.offset(0);
        make.width.offset(width);
    }];
    
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.equalTo(self.storeBtn.mas_right).offset(0);
        make.bottom.offset(0);
        make.width.offset(width);
    }];
    
    [self.intoCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.equalTo(self.collectionBtn.mas_right).offset(0);
        make.bottom.offset(0);
        make.width.offset(GD_BottomBuyW);
    }];
    
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.equalTo(self.intoCartBtn.mas_right).offset(0);
        make.bottom.offset(0);
        make.width.offset(GD_BottomBuyW);
    }];
}
#pragma mark - handle action
- (void)serviceAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailBottomViewDelegate_clickService)]) {
        [self.delegate GoodsDetailBottomViewDelegate_clickService];
    }
}
- (void)storeAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailBottomViewDelegate_clickStore)]) {
        [self.delegate GoodsDetailBottomViewDelegate_clickStore];
    }
}
- (void)collectionAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailBottomViewDelegate_clickCollectionWithButton:)]) {
        [self.delegate GoodsDetailBottomViewDelegate_clickCollectionWithButton:sender];
    }
}
- (void)intoCartAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailBottomViewDelegate_clickIntoCart)]) {
        [self.delegate GoodsDetailBottomViewDelegate_clickIntoCart];
    }
}
- (void)buyAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailBottomViewDelegate_clickBuy)]) {
        [self.delegate GoodsDetailBottomViewDelegate_clickBuy];
    }
}
#pragma mark - custom method
#pragma mark - settet model
- (void)setIsCollection:(BOOL)IsCollection
{
    _IsCollection = IsCollection;
    self.collectionBtn.selected = IsCollection;
}
@end
