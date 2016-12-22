//
//  CreateOrderCashCouponCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/5.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CreateOrderCashCouponCell.h"

@interface CreateOrderCashCouponCell ()

/**  可用总额 */
@property(nonatomic,strong) UILabel * totalLabel;
/**  输入使用 */
@property(nonatomic,strong) UITextField * currentTF;
/**  确认按钮 */
@property(nonatomic,strong) UIButton * sureButton;
@end

@implementation CreateOrderCashCouponCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel sizeToFit];
    self.titleLabel.text = String(@"现金券");
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.font = Font_Mid;
    [self.contentView addSubview:self.titleLabel];
    
    self.totalLabel = [[UILabel alloc] init];
    [self.totalLabel sizeToFit];
    self.totalLabel.text = @"可用总额";
    self.totalLabel.textColor = QF_RedColor;
    self.totalLabel.font = Font_Min;
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithString:@"可用总额" color:QF_BlackColor];
    self.totalLabel.attributedText = attributedString;
    [self.contentView addSubview:self.totalLabel];
    
    self.currentTF = [[UITextField alloc] init];
    self.currentTF.placeholder = @"请输入使用现金额度";
    self.currentTF.textColor = QF_BlackColor;
    self.currentTF.font = Font_Min;
    self.currentTF.borderStyle = UITextBorderStyleLine;
    [self.contentView addSubview:self.currentTF];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.sureButton setTitleColor:QF_GrayColor forState:UIControlStateNormal];
    self.sureButton.layer.masksToBounds = YES;
    self.sureButton.layer.cornerRadius = Layout_cornerRadius;
    self.sureButton.layer.borderColor = QF_GrayColor.CGColor;
    self.sureButton.layer.borderWidth = Layout_borderWidth;
    [self.sureButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.contentView addSubview:self.sureButton];
}

//布局子视图
- (void)layoutViews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.centerY.offset(0);
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(Adapted(60), Adapted(25)));
        make.centerY.offset(0);
        make.right.offset(-kMargin);
    }];
    
    [self.currentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.size.mas_offset(CGSizeMake(Adapted(135), Adapted(25)));
        make.right.equalTo(self.sureButton.mas_left).offset(Adapted(-kMargin));
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(Adapted(kMargin));
        make.right.equalTo(self.currentTF.mas_left).offset(Adapted(-kMargin));
        make.centerY.offset(0);
    }];
}

#pragma mark - custom method

#pragma mark - handle action
- (void)sureAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(CreateOrderCashCouponCellDelegate_clickSureWithNumber:)]) {
        [self.delegate CreateOrderCashCouponCellDelegate_clickSureWithNumber:self.currentTF.text];
    }
}
#pragma mark - setter model


@end
