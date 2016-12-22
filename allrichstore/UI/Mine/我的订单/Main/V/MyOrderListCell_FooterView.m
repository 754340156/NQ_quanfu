//
//  MyOrderListCell_FooterView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderListCell_FooterView.h"
#import "MyOrderListModel.h"
#define kButtonH 20.0f

@interface MyOrderListCell_FooterView ()
/**  total */
@property(nonatomic,strong) UILabel * totalLabel;
/**  rightButton */
@property(nonatomic,strong) UIButton * rightButton;
/**  leftButton */
@property(nonatomic,strong) UIButton * leftButton;
@end

@implementation MyOrderListCell_FooterView

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
    self.totalLabel = [[UILabel alloc] init];
    self.totalLabel.textColor = QF_BlackColor;
    self.totalLabel.textAlignment = NSTextAlignmentRight;
    self.totalLabel.font = Font_Mid;
    [self.totalLabel sizeToFit];
    [self.contentView addSubview:self.totalLabel];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButonWithButton:self.rightButton];
    [self.contentView addSubview:self.rightButton];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButonWithButton:self.leftButton];
    [self.contentView addSubview:self.leftButton];
    
    
    [self addBottomLineWithColor:QFColor_CoodsClassMenuViewBg height:Adapted(5) style:LineLayoutStyleInside];
}
- (void)setLayout
{
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
        make.height.offset(Adapted(kButtonH));
    }];    
}
#pragma mark - custom method
- (void)setButonWithButton:(UIButton *)sender
{
    sender.layer.borderColor = QF_OrangeColor.CGColor;
    sender.layer.borderWidth = 1.0f;
    sender.layer.cornerRadius = Adapted(kButtonH) / 2;
    sender.layer.masksToBounds = YES;
    [sender setTitleColor:QF_OrangeColor forState:UIControlStateNormal];
    sender.titleLabel.font = Font_Min;
    [sender addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)reSetupButtonWithButton:(UIButton *)sender Index:(NSInteger)index RightAttribute:(MASViewAttribute *)rightViewAttribute
{
    sender.hidden = NO;
    [sender setTitle:self.model.buttonArray[index] forState:UIControlStateNormal];
    [sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalLabel.mas_bottom).offset(Adapted(kMargin / 2));
        make.right.equalTo(rightViewAttribute).offset(Adapted(-kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(kMargin * 2)+ [UILabel getWidthWithFont:sender.titleLabel.font text:sender.titleLabel.text], Adapted(kButtonH)));
    }];
}
#pragma mark - handle action
- (void)buttonAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyOrderListCell_FooterViewDelegate_clickButtonWithButton:)]) {
        [self.delegate MyOrderListCell_FooterViewDelegate_clickButtonWithButton:sender];
    }
}
#pragma mark - setter model
- (void)setModel:(MyOrderListModel *)model
{
    _model = model;
    self.totalLabel.text = [NSString stringWithFormat:String(@"共%ld件商品 合计：%.2f"),(long)model.goodsCount,model.totalPrice];
    self.height = Adapted(kMyOrderListCell_FooterViewH) ;
    if (model.buttonArray.count) {
        [self reSetupButtonWithButton:self.rightButton Index:0 RightAttribute:self.mas_right];
        if (model.buttonArray.count > 1) {
            [self reSetupButtonWithButton:self.leftButton Index:1 RightAttribute:self.rightButton.mas_left];
        }
    }else
    {
        self.rightButton.hidden = YES;
        self.leftButton.hidden = YES;
    }
    
}

@end
