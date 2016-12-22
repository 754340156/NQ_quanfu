//
//  MyOrderHintView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/22.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderHintView.h"

@implementation MyOrderHintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = QFColor_CoodsClassMenuViewBg;
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    UILabel *label1 = [[UILabel alloc] init];
    [self setLabelWithLabel:label1 title:String(@"您还没有相关订单") fontSize:16];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.offset(Adapted(100.0f));
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    [self setLabelWithLabel:label2 title:String(@"赶紧开始您的购物之旅吧") fontSize:12];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(label1.mas_bottom).offset(Adapted(10.0f));
    }];
}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action
- (void)setLabelWithLabel:(UILabel *)label title:(NSString *)title fontSize:(CGFloat)fontSize
{
    label.font = AdaptedFont(fontSize);
    label.textColor = QF_BlackColor;
    label.text = title;
    [label sizeToFit];
}
#pragma mark - setter model


@end
