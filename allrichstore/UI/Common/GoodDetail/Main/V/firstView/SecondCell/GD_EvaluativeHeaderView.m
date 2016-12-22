//
//  GD_EvaluativeHeaderView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GD_EvaluativeHeaderView.h"

@interface GD_EvaluativeHeaderView ()
/**  title */
@property(nonatomic,strong) UILabel * titleLabel;
/**  好评率 */
@property(nonatomic,strong) UILabel * rateLabel;
/**  右侧箭头 */
@property(nonatomic,strong) UIImageView * arrowImageV;
@end


@implementation GD_EvaluativeHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
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
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = Font_Mid;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview: self.titleLabel];
    
    self.rateLabel = [[UILabel alloc] init];
    self.rateLabel.textColor = QF_GrayColor;
    self.rateLabel.font = Font_Mid;
    [self.rateLabel sizeToFit];
    self.rateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.rateLabel];
    
    self.arrowImageV = [[UIImageView alloc] init];
    self.arrowImageV.contentMode = UIViewContentModeCenter;
    self.arrowImageV.image = Image(@"youjiantou");
    [self.contentView addSubview:self.arrowImageV];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}
- (void)setLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.offset(Adapted(10));
        make.height.offset(Adapted(25));
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.offset(Adapted(-10));
        make.size.mas_offset(kArrowImageVSize);
    }];
    
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageV.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.height.offset(Adapted(25));
    }];
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setTotalCount:(NSString *)totalCount
{
    _totalCount = totalCount;
    self.titleLabel.text = [NSString stringWithFormat:@"%@ （%@）",String(@"宝贝评价"),totalCount];
}
- (void)setRate:(NSString *)rate
{
    _rate = rate;
    self.rateLabel.text = [NSString stringWithFormat:@"%@%@",String(@"好评度"),rate];
}
@end
