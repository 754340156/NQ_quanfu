//
//  MyOrderDetailHeaderView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderDetailHeaderView.h"
#import "MyOrderDetailModel.h"

@interface MyOrderDetailHeaderView ()
/**  backView */
@property(nonatomic,strong) UIView * backView;
/**  订单状态 */
@property(nonatomic,strong) UILabel * orderStatusL;
/**  订单编号 */
@property(nonatomic,strong) UILabel * numberLabel;
/**  收货人 */
@property(nonatomic,strong) UILabel * nameLabel;
/**  收货人电话 */
@property(nonatomic,strong) UILabel * phoneLabel;
/**  收货地址 */
@property(nonatomic,strong) UILabel * addressLabel;
/**  图标 */
@property(nonatomic,strong) UIImageView * arrowImageV;
@end

@implementation MyOrderDetailHeaderView

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
    self.backView = [[UIView alloc] init];
    [self addSubview:self.backView];
    
    self.orderStatusL = [[UILabel alloc] init];
    [self.orderStatusL sizeToFit];
    self.orderStatusL.font = Font_Max;
    self.orderStatusL.textColor = QF_BlackColor;
    [self.backView addSubview:self.orderStatusL];
    
    self.numberLabel = [[UILabel alloc] init];
    [self.numberLabel sizeToFit];
    self.numberLabel.font = Font_Min;
    self.numberLabel.textColor = QF_BlackColor;
    [self.backView addSubview:self.numberLabel];
    
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
    self.arrowImageV.image = Image(@"youjiantou");
    self.arrowImageV.contentMode = UIViewContentModeCenter;
    [self addSubview:self.arrowImageV];
}
- (void)setLayout
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.offset(Adapted(kBackViewH));
    }];
    
    [self.orderStatusL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView.mas_centerY);
        make.left.offset(Adapted(kMargin));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderStatusL.mas_centerY);
        make.left.equalTo(self.orderStatusL.mas_right).offset(Adapted(kMargin * 3));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.top.equalTo(self.backView.mas_bottom).offset(Adapted(kMargin));
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
        make.top.equalTo(self.backView.mas_bottom).offset(Adapted(kMargin * 2));
        make.right.offset(Adapted(-kMargin));
        make.size.mas_offset(kArrowImageVSize);
    }];
    
    [self.backView addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(MyOrderDetailModel *)model
{
    _model = model;
    self.orderStatusL.text = model.status;
    self.numberLabel.text = [NSString stringWithFormat:@"%@：%@",String(@"订单编号"),model.number];
    self.nameLabel.text = [NSString stringWithFormat:@"%@：%@",String(@"收货人"),model.name];
    self.phoneLabel.text = model.phone;
    self.addressLabel.text = [NSString stringWithFormat:@"%@：%@",String(@"收货地址"),model.address];
    self.addressLabel.height = model.addressH;
}


@end
