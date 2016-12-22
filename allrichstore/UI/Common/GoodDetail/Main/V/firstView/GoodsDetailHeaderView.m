//
//  GoodsDetailHeaderView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/1.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsDetailHeaderView.h"
#import "GoodsDetailModel.h"
@interface GoodsDetailHeaderView ()<SDCycleScrollViewDelegate>
/**  头部轮播图 */
@property(nonatomic,strong) SDCycleScrollView * cycleScrollView;
/**  title */
@property(nonatomic,strong) UILabel * titleLabel;
/**  价格 */
@property(nonatomic,strong) UILabel * priceLabel;
/**  快递 */
@property(nonatomic,strong) UILabel * expressLabel;
/**  付款人数 */
@property(nonatomic,strong) UILabel * buyCntLabel;
/**  地址 */
@property(nonatomic,strong) UILabel * addressLabel;
@end


@implementation GoodsDetailHeaderView

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
#warning 站位图
    //轮播图
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW, Adapted(270)) delegate:self placeholderImage:Image_PlaceHolder_Banner];
    self.cycleScrollView.currentPageDotImage = Image(@"lunbodian1");
    self.cycleScrollView.pageDotImage = Image(@"lunbodian2");
    self.cycleScrollView.pageControlDotSize = CGSizeMake(Adapted(10), Adapted(10));
    [self addSubview:self.cycleScrollView];
    
    //title
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.font = Font_Mid;
    [self addSubview:self.titleLabel];
    
    //价格
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = Font_Mid;
    self.priceLabel.textColor = QF_RedColor;
    [self addSubview:self.priceLabel];
    
    //快递
    self.expressLabel = [[UILabel alloc] init];
    self.expressLabel.font = Font_Min;
    self.expressLabel.textColor = QF_GrayColor;
    [self addSubview:self.expressLabel];
    
    //付款人数
    self.buyCntLabel = [[UILabel alloc] init];
    self.buyCntLabel.textAlignment = NSTextAlignmentRight;
    self.buyCntLabel.font = Font_Min;
    self.buyCntLabel.textColor = QF_GrayColor;
    [self addSubview:self.buyCntLabel];
    
    //地址
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.textAlignment = NSTextAlignmentRight;
    self.addressLabel.font = Font_Min;
    self.addressLabel.textColor = QF_GrayColor;
    [self addSubview:self.addressLabel];
}
- (void)setLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(Adapted(10));
        make.left.offset(Adapted(10));
        make.right.offset(Adapted(-10));
        make.height.offset(Adapted(20));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Adapted(5));
        make.right.equalTo(self.titleLabel.mas_right);
        make.height.offset(Adapted(20));
    }];
    
    CGFloat width = (kScreenW -Adapted(20)) / 3;
    [self.expressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(Adapted(5));
        make.left.equalTo(self.titleLabel.mas_left);
        make.size.mas_offset(CGSizeMake(width, Adapted(20)));
    }];
    
    [self.buyCntLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(Adapted(5));
        make.left.equalTo(self.expressLabel.mas_right);
        make.size.mas_offset(CGSizeMake(width, Adapted(20)));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(Adapted(5));
        make.right.offset(Adapted(-10));
        make.size.mas_offset(CGSizeMake(width, Adapted(20)));
    }];
}

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GoodsDetailHeaderViewDelegate_clickCycleScrollView:index:)]) {
        [self.delegate GoodsDetailHeaderViewDelegate_clickCycleScrollView:cycleScrollView index:index];
    }
}
#pragma mark - handle action
#pragma mark - custom method
#pragma mark - setter model
- (void)setModel:(GoodsDetailModel *)model
{
    self.cycleScrollView.imageURLStringsGroup = model.image;
    self.titleLabel.text = model.g_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥：%@",model.g_price];
    self.expressLabel.text = [NSString stringWithFormat:@"%@：%@",String(@"快递"),model.g_freight];
    self.buyCntLabel.text = [NSString stringWithFormat:@"%@",model.g_salenumber];
    self.addressLabel.text = model.g_site;
}
@end
