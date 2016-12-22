//
//  CreateOrderHeaderView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CreateOrderHeaderView.h"
#import "CreateOrderModel.h"

@interface CreateOrderHeaderView ()
/**  收货人 */
@property(nonatomic,strong) UILabel * nameLabel;
/**  收货人电话 */
@property(nonatomic,strong) UILabel * phoneLabel;
/**  收货地址 */
@property(nonatomic,strong) UILabel * addressLabel;
/**  图标 */
@property(nonatomic,strong) UIImageView * arrowImageV;
@end

@implementation CreateOrderHeaderView

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
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel sizeToFit];
    self.nameLabel.font = Font_Mid;
    self.nameLabel.textColor = QF_BlackColor;
    [self addSubview:self.nameLabel];
    
    self.phoneLabel = [[UILabel alloc] init];
    self.phoneLabel.textAlignment = NSTextAlignmentRight;
    [self.phoneLabel sizeToFit];
    self.phoneLabel.font = Font_Mid;
    self.phoneLabel.textColor = QF_BlackColor;
    [self addSubview:self.phoneLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.font = kAddressFont;
    self.addressLabel.textColor = QF_BlackColor;
    [self addSubview:self.addressLabel];
    
    self.arrowImageV = [[UIImageView alloc] init];
    self.arrowImageV.contentMode = UIViewContentModeCenter;
    self.arrowImageV.image = Image(@"youjiantou");
    [self addSubview:self.arrowImageV];
    
    UITapGestureRecognizer *tap  =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
    [self addGestureRecognizer:tap];
}
- (void)setLayout
{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(Adapted(kMargin));
        make.width.offset(Adapted(kAddressW));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addressLabel.mas_right);
        make.top.equalTo(self.nameLabel.mas_top);
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(Adapted(kMargin * 2));
        make.right.offset(-kMargin);
        make.size.mas_offset(kArrowImageVSize);
    }];
}
#pragma mark - custom method

#pragma mark - handle action
- (void)clickAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CreateOrderHeaderViewDelegate_clickSelf)]) {
        [self.delegate CreateOrderHeaderViewDelegate_clickSelf];
    }
}
#pragma mark - setter model
- (void)setModel:(CreateOrderModel *)model
{
    _model = model;
    self.nameLabel.text = [NSString stringWithFormat:@"%@：%@",String(@"收货人"),model.name];
    self.phoneLabel.text = model.phone;
    self.addressLabel.text = [NSString stringWithFormat:@"%@：%@",String(@"收货地址"),model.address];
    self.addressLabel.height = model.addressH;
}
@end
