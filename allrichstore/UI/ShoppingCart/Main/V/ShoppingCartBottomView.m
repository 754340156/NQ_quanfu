//
//  ShoppingCartBottomView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShoppingCartBottomView.h"

#define kEditButtonSize CGSizeMake(Adapted(80), Adapted(35))
@interface ShoppingCartBottomView ()
/**  移入关注 */
@property(nonatomic,strong) UIButton * toCareBtn;
/**  删除 */
@property(nonatomic,strong) UIButton * deleteButton;
/**  结算 */
@property(nonatomic,strong) UIButton * settlementBtn;
@end

@implementation ShoppingCartBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.allButton = [[QButton alloc] initWithFrame:CGRectZero layoutStyle:QButtonLayoutStyleLeft font:Font_Max title:String(@"全选") autoSize:NO];
    self.allButton.space = Adapted(kMargin);
    [self.allButton setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self.allButton setImage:Image(@"xuanze_weixuan") forState:UIControlStateNormal];
    [self.allButton setImage:Image(@"xuanze_yixuan") forState:UIControlStateSelected];
    [self.allButton addTarget:self action:@selector(allAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.allButton];
    
    self.totalLabel = [[UILabel alloc] init];
    [self.totalLabel sizeToFit];
    self.totalLabel.textAlignment = NSTextAlignmentRight;
    self.totalLabel.font = Font_Max;
    self.totalLabel.textColor = QF_BlackColor;
    self.totalLabel.text = [NSString stringWithFormat:@"%@：￥0.00",String(@"合计")];
    [self addSubview:self.totalLabel];
    
    self.subTitleLabel = [[UILabel alloc] init];
    [self.subTitleLabel sizeToFit];
    self.subTitleLabel.textAlignment = NSTextAlignmentRight;
    self.subTitleLabel.font = Font_Min;
    self.subTitleLabel.textColor = QF_BlackColor;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@：￥0.00",String(@"合计")];
    [self addSubview:self.subTitleLabel];
    
    self.settlementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settlementBtn setTitle:String(@"结算") forState:UIControlStateNormal];
    [self.settlementBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.settlementBtn setBackgroundColor:QF_RedBtnColor];
    [self.settlementBtn addTarget:self action:@selector(settlementAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.settlementBtn];
    
    self.toCareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.toCareBtn Title:String(@"移入关注") Target:@selector(toCareAction)];
    self.toCareBtn.hidden = YES;
    [self addSubview:self.toCareBtn];
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.deleteButton Title:String(@"删除")Target:@selector(deleteAction)];
    self.deleteButton.hidden = YES;
    [self addSubview:self.deleteButton];
}
- (void)setLayout
{
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(70), Adapted(30)));
    }];
    
    [self.settlementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.width.offset(Adapted(100));
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(Adapted(kMargin));
        make.right.equalTo(self.settlementBtn.mas_left).offset(Adapted(-kMargin));
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.totalLabel.mas_right);
        make.top.equalTo(self.totalLabel.mas_bottom).offset(Adapted(kMargin / 2));
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.offset(Adapted(-kMargin));
        make.size.mas_offset(kEditButtonSize);
    }];
    
    [self.toCareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.deleteButton.mas_left).offset(Adapted(-kMargin));
        make.size.mas_offset(kEditButtonSize);
    }];
}
#pragma mark - custom method
- (void)setButtonWithButton:(UIButton *)button Title:(NSString *)title Target:(SEL)target
{
    [button setTitleColor:QF_GrayColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = Font_Mid;
    button.layer.borderColor = QF_GrayColor.CGColor;
    button.layer.borderWidth = ListCell_Line_W_H / 2;
    [button addTarget:self action:target forControlEvents:UIControlEventTouchUpInside];
}
/**  编辑状态 */
- (void)editStatus
{
    self.totalLabel.hidden = YES;
    self.subTitleLabel.hidden = YES;
    self.settlementBtn.hidden = YES;
    self.toCareBtn.hidden = NO;
    self.deleteButton.hidden = NO;
}
/**  正常状态 */
- (void)normalStatus
{
    self.totalLabel.hidden = NO;
    self.subTitleLabel.hidden = NO;
    self.settlementBtn.hidden = NO;
    self.toCareBtn.hidden = YES;
    self.deleteButton.hidden = YES;
}
#pragma mark - handle action
//结算
- (void)settlementAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ShoppingCartBottomViewDelegate_clickSettlementBtn)]) {
        [self.delegate ShoppingCartBottomViewDelegate_clickSettlementBtn];
    }
}
//全选
- (void)allAction:(QButton *)sender
{
    sender.selected = !sender.selected;
    if (self.clickAllButtonBlock) {
        self.clickAllButtonBlock(sender);
    }
}
//移入关注
- (void)toCareAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ShoppingCartBottomViewDelegate_clickToCareBtn)]) {
        [self.delegate ShoppingCartBottomViewDelegate_clickToCareBtn];
    }
}
//删除
- (void)deleteAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ShoppingCartBottomViewDelegate_clickDeleteButton)]) {
        [self.delegate ShoppingCartBottomViewDelegate_clickDeleteButton];
    }
}
#pragma mark - setter model


@end
