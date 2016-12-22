//
//  RefundComplainView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/30.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RefundComplaintView.h"
#import "PlaceholderTextView.h"
#import "RefundDetailApplyModel.h"
#define kBackView1H 120.0f
@interface RefundComplaintView ()
/**  <#注释#> */
@property(nonatomic,strong) UIImageView * goodImageV;
/**  title */
@property(nonatomic,strong) UILabel * titleLabel;
/**  number */
@property(nonatomic,strong) UILabel * numberLabel;
/**  textView */
@property(nonatomic,strong) PlaceholderTextView * textView;
@end

@implementation RefundComplaintView

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
    UIView *backView1 = [[UIView alloc] init];
    backView1.backgroundColor = kWhiteColor;
    [self addSubview:backView1];
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(Adapted(kBackView1H));
        make.width.offset(kScreenW);
    }];
    
    self.goodImageV = [[UIImageView alloc] init];
    [backView1 addSubview:self.goodImageV];
    
    self.titleLabel = [[UILabel alloc] init];
    [self setLabel:self.titleLabel Title:nil TextColor:QF_BlackColor Font:Font_Mid];
    self.titleLabel.numberOfLines = 0;
    [backView1 addSubview:self.titleLabel];
    
    self.numberLabel = [[UILabel alloc] init];
    [self setLabel:self.numberLabel Title:nil TextColor:QF_GrayColor Font:Font_Min];
    [backView1 addSubview:self.numberLabel];
    
    UIView *backView2 = [[UIView alloc] init];
    backView2.backgroundColor = kWhiteColor;
    [self addSubview:backView2];
    [backView2 addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView1.mas_bottom).offset(Adapted(kMargin / 2));
        make.left.right.offset(0);
        make.height.offset(Adapted(kBackView1H));
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    [self setLabel:label1 Title:@"反馈内容" TextColor:QF_BlackColor Font:Font_Mid];
    [backView2 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(Adapted(kMargin));
    }];
    
    self.textView = [[PlaceholderTextView alloc] init];
    self.textView.font = Font_Mid;
    self.textView.textColor = QF_BlackColor;
    self.textView.placeholder = @"请您描述详细问题......";
    [backView2 addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(Adapted(kMargin));
        make.left.equalTo(label1.mas_left);
        make.bottom.right.offset(Adapted(-kMargin));
    }];
    
    UIView *backView3 = [[UIView alloc] init];
    backView3.backgroundColor = kWhiteColor;
    [self addSubview:backView3];
    [backView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(backView2.mas_bottom);
        make.height.offset(Adapted(kBottomH));
        make.bottom.offset(Adapted(kScreenH - TopBarHeight - Adapted(kBottomH + kBackView1H * 2 + kMargin / 2)));
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    [self setLabel:label2 Title:@"联系方式：18900908966" TextColor:QF_BlackColor Font:Font_Mid];
    [backView3 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.centerY.offset(0);
    }];
}
- (void)setLayout
{
    [self.goodImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(Adapted(kMargin));
        make.bottom.offset(Adapted(-kMargin));
        make.width.offset(Adapted(kBackView1H));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodImageV.mas_top);
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.bottom.equalTo(self.goodImageV.mas_bottom);
    }];
    
}
#pragma mark - custom method
- (void)setLabel:(UILabel *)label Title:(NSString *)title TextColor:(UIColor *)textColor Font:(UIFont *)font
{
    label.font = font;
    label.textColor = textColor;
    [label sizeToFit];
    if (title) label.text = title;
}
#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(RefundDetailApplyModel *)model
{
    _model = model;
    self.goodImageV.image = ImageStr(model.icon);
    self.titleLabel.text = model.title;
    self.numberLabel.text = [NSString stringWithFormat:@"x%@",model.count];
}
@end
