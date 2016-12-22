//
//  ShoppingCartCell_HeaderView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShoppingCartHeaderView.h"
#import "ShoppingCartModel.h"

#define kButtonSize CGSizeMake(Adapted(25.0f), Adapted(25.0f))
@interface ShoppingCartHeaderView ()
/**  店铺图标 */
@property(nonatomic,strong) UIImageView * iconImageV;
/**  店铺全选按钮 */
@property(nonatomic,strong) UIButton * allButton;
/**  店铺名 */
@property(nonatomic,strong) UILabel * nickNameL;
/**  右箭头 */
@property(nonatomic,strong) UIImageView * arrowImageV;
@end

@implementation ShoppingCartHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kWhiteColor;
        [self setup];
        [self setLayout];
    }
    return self;
}

#pragma mark - setup
- (void)setup
{
    self.iconImageV = [[UIImageView alloc] init];
    self.iconImageV.contentMode = UIViewContentModeCenter;
    self.iconImageV.image = Image(@"xiaodianpu");
    [self.contentView addSubview:self.iconImageV];
    
    self.allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allButton setImage:Image(@"xuanze_weixuan") forState:UIControlStateNormal];
    [self.allButton setImage:Image(@"xuanze_yixuan") forState:UIControlStateSelected];
    [self.allButton addTarget:self action:@selector(allAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.allButton];
    
    
    self.nickNameL = [[UILabel alloc] init];
    [self.nickNameL sizeToFit];
    self.nickNameL.font = Font_Mid;
    self.nickNameL.textColor = QF_BlackColor;
    [self.contentView addSubview:self.nickNameL];
    
    self.arrowImageV = [[UIImageView alloc] init];
    self.arrowImageV.contentMode = UIViewContentModeCenter;
    self.arrowImageV.image = Image(@"youjiantou");
    [self.contentView addSubview:self.arrowImageV];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}
- (void)setLayout
{
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(kButtonSize);
    }];
    
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allButton.mas_right).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(kMargin * 2), Adapted(kMargin * 2)));
        make.centerY.offset(0);
    }];
    
    [self.nickNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_right).offset(Adapted(kMargin));
        make.centerY.equalTo(self.allButton.mas_centerY);
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(self.nickNameL.mas_right).offset(Adapted(kMargin));
        make.size.mas_offset(kArrowImageVSize);
    }];
}
#pragma mark - custom method

#pragma mark - handle action
- (void)allAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.model.isHeadSelected = sender.selected;
    if (self.headerClickBlock) {
        self.headerClickBlock();
    }
}

#pragma mark - setter model
- (void)setModel:(ShoppingCartModel *)model
{
    _model = model;
    self.nickNameL.text = model.shopName;
    self.allButton.selected = model.isHeadSelected;
}

@end
