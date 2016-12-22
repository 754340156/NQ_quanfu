//
//  RefundDetailApplyHeaderView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RefundDetailApplyHeaderView.h"
#import "RefundDetailApplyModel.h"
#define kImageViewSize CGSizeMake(Adapted(130), Adapted(100))
@interface RefundDetailApplyHeaderView ()
/**  商品图片 */
@property(nonatomic,strong) UIImageView * goodImageV;
/**  商品名 */
@property(nonatomic,strong) UILabel * titleLabel;
/**  数量 */
@property(nonatomic,strong) UILabel * numberLabel;
/**  联系卖家 */
@property(nonatomic,strong) UIButton * contactSellerBtn;
@end

@implementation RefundDetailApplyHeaderView

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
    self.goodImageV = [[UIImageView alloc] init];
    [self addSubview:self.goodImageV];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.font = Font_Min;
    self.numberLabel.textColor = QF_GrayColor;
    [self.numberLabel sizeToFit];
    [self addSubview:self.numberLabel];
    
    self.contactSellerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.contactSellerBtn.titleLabel.font = Font_Min;
    [self.contactSellerBtn setTitleColor:QF_GrayColor forState:UIControlStateNormal];
    [self.contactSellerBtn setTitle:@"联系卖家" forState:UIControlStateNormal];
    [self.contactSellerBtn addTarget:self action:@selector(contactSellerAction) forControlEvents:UIControlEventTouchUpInside];
    self.contactSellerBtn.layer.masksToBounds =  YES;
    self.contactSellerBtn.layer.cornerRadius = 5.0f;
    self.contactSellerBtn.layer.borderColor = QF_GrayColor.CGColor;
    self.contactSellerBtn.layer.borderWidth = ListCell_Line_W_H / 2;
    [self addSubview:self.contactSellerBtn];
}
- (void)setLayout
{
    [self.goodImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(Adapted(kMargin));
        make.size.mas_offset(kImageViewSize);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodImageV.mas_top);
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.bottom.equalTo(self.goodImageV.mas_bottom);
    }];
    
    [self.contactSellerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.goodImageV.mas_bottom);
        make.right.equalTo(self.titleLabel.mas_right);
        make.size.mas_offset(CGSizeMake(Adapted(60), Adapted(25)));
    }];
}
#pragma mark - custom method

#pragma mark - handle action
- (void)contactSellerAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(RefundDetailApplyHeaderViewDelegate_clickContactSellerBtn)]) {
        [self.delegate RefundDetailApplyHeaderViewDelegate_clickContactSellerBtn];
    }
}
#pragma mark - setter model
- (void)setModel:(RefundDetailApplyModel *)model
{
    _model = model;
    self.goodImageV.image = ImageStr(model.icon);
    self.titleLabel.text = model.title;
    self.numberLabel.text = [NSString stringWithFormat:@"x%@",model.count];
}


@end
