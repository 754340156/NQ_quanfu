//
//  MyOrderDetailBottomView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderDetailBottomView.h"
#define KbuttonW kScreenW / 4
@interface MyOrderDetailBottomView ()
/**  删除订单/取消订单 */
@property(nonatomic,strong) UIButton * deleteOrderBtn;
/**  查看物流 */
@property(nonatomic,strong) UIButton * logisticBtn;
/**  退款售后 */
@property(nonatomic,strong) UIButton * refundBtn;
/**  再次购买/付款/评价 */
@property(nonatomic,strong) UIButton * payBtn;
@end

@implementation MyOrderDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame Style:(MyOrderVCStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupWithStyle:style];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setupWithStyle:(MyOrderVCStyle)style
{
    self.deleteOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.deleteOrderBtn TitleColor:QF_GrayColor BackgroundColor:kWhiteColor];
    [self addSubview:self.deleteOrderBtn];
    
    self.logisticBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.logisticBtn TitleColor:QF_GrayColor BackgroundColor:kWhiteColor];
    [self addSubview:self.logisticBtn];
    
    self.refundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.refundBtn TitleColor:QF_GrayColor BackgroundColor:kWhiteColor];
    [self addSubview:self.refundBtn];
    
    self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.payBtn TitleColor:kWhiteColor BackgroundColor:QF_OrangeColor];
    [self addSubview:self.payBtn];
    
    
    switch (style) {
        case MyOrderVCWaitPay:
            //待付款
        {
            [self.deleteOrderBtn setTitle:String(@"取消订单") forState:UIControlStateNormal];
            [self.payBtn setTitle:String(@"付款") forState:UIControlStateNormal];
            self.logisticBtn.hidden = YES;
            self.refundBtn.hidden = YES;
        }
            break;
        case MyOrderVCWaitAccept:
            //待收货
        {
            [self.deleteOrderBtn setTitle:String(@"查看物流") forState:UIControlStateNormal];
            self.logisticBtn.hidden = YES;
            self.refundBtn.hidden = YES;
            [self.payBtn setTitle:String(@"确认收货") forState:UIControlStateNormal];
        }
            break;
        case MyOrderVCWaitComment:
            //待评价
        {
            [self.deleteOrderBtn setTitle:String(@"删除订单") forState:UIControlStateNormal];
            [self.logisticBtn setTitle:String(@"查看物流") forState:UIControlStateNormal];
            [self.payBtn setTitle:String(@"评价") forState:UIControlStateNormal];
            self.refundBtn.hidden = YES;
        }
            break;
        case MyOrderVCFinish:
            //已完成
        {
            [self.deleteOrderBtn setTitle:String(@"删除订单") forState:UIControlStateNormal];
            [self.logisticBtn setTitle:String(@"查看物流") forState:UIControlStateNormal];
            [self.refundBtn setTitle:String(@"退款售后") forState:UIControlStateNormal];
            [self.payBtn setTitle:String(@"再次购买") forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
}
- (void)setLayout
{
    [self.deleteOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.offset(0);
        make.width.offset(KbuttonW);
    }];
    
    [self.logisticBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.offset(KbuttonW);
        make.left.equalTo(self.deleteOrderBtn.mas_right);
    }];
    
    [self.refundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.offset(KbuttonW);
        make.left.equalTo(self.logisticBtn.mas_right);
    }];
    
    [self.payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.width.offset(KbuttonW);
    }];
}
#pragma mark - custom method
- (void)buttonAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyOrderDetailBottomViewDelegate_clickButtonWithTitleStyle:)]) {
        MyOrderDetailBottomButtonTitle titleStyle ;
        
        if ([sender.titleLabel.text isEqualToString:String(@"取消订单")]) {
            titleStyle = MyOrderDetailBottomButtonTitleCancel;
        }else if ([sender.titleLabel.text isEqualToString:String(@"删除订单")])
        {
            titleStyle = MyOrderDetailBottomButtonTitleDelete;
        }else if ([sender.titleLabel.text isEqualToString:String(@"查看物流")])
        {
            titleStyle = MyOrderDetailBottomButtonTitleLogistic;
        }else if ([sender.titleLabel.text isEqualToString:String(@"退款售后")])
        {
            titleStyle = MyOrderDetailBottomButtonTitletRefund;
        }else if ([sender.titleLabel.text isEqualToString:String(@"付款")])
        {
            titleStyle = MyOrderDetailBottomButtonTitlePay;
        }else if ([sender.titleLabel.text isEqualToString:String(@"再次购买")])
        {
            titleStyle = MyOrderDetailBottomButtonTitleAgainBuy;
        }else if ([sender.titleLabel.text isEqualToString:String(@"确认收货")])
        {
            titleStyle = MyOrderDetailBottomButtonTitleSureGet;
        }
        else if ([sender.titleLabel.text isEqualToString:String(@"评价")])
        {
            titleStyle = MyOrderDetailBottomButtonTitleComment;
        }
        [self.delegate MyOrderDetailBottomViewDelegate_clickButtonWithTitleStyle:titleStyle];
    }
}
#pragma mark - handle action
- (void)setButtonWithButton:(UIButton *)button TitleColor:(UIColor *)titleColor BackgroundColor:(UIColor *)backgroundColor
{
    button.titleLabel.font = Font_Mid;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    [button addLeftLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - setter model


@end
