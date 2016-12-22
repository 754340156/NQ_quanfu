//
//  MyOrderRefundSearchCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderRefundSearchCell.h"
#import "MyOrderRefundSearchModel.h"
#define kButtonSize CGSizeMake(Adapted(60), Adapted(25))
#define kLabelH 45.0f

#define kImageViewSize CGSizeMake(Adapted(130), Adapted(100))
@interface MyOrderRefundSearchCell ()
/**  服务单号 */
@property(nonatomic,strong) UILabel * serviceNumLabel;
/**  服务状态 */
@property(nonatomic,strong) UILabel * serviceStatusL;
/**  商品图片 */
@property(nonatomic,strong) UIImageView * goodImageV;
/**  申请时间 */
@property(nonatomic,strong) UILabel * applyTimeL;
/**  取消申请 */
@property(nonatomic,strong) UIButton * cancelApplyBtn;
/**  进度查询 */
@property(nonatomic,strong) UIButton * progressSearchBtn;
@end
@implementation MyOrderRefundSearchCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.serviceNumLabel = [[UILabel alloc] init];
    self.serviceNumLabel.textColor = QF_BlackColor;
    self.serviceNumLabel.font = Font_Max;
    [self.contentView addSubview:self.serviceNumLabel];
    [self.serviceNumLabel addTopLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self.serviceNumLabel addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    
    self.serviceStatusL = [[UILabel alloc] init];
    self.serviceStatusL.textColor = QF_BlackColor;
    self.serviceStatusL.font = Font_Max;
    [self.contentView addSubview:self.serviceStatusL];
    [self.serviceStatusL addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    
    self.goodImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.goodImageV];
    
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.applyTimeL = [[UILabel alloc] init];
    self.applyTimeL.font = Font_Min;
    self.applyTimeL.textColor = QF_GrayColor;
    [self.applyTimeL sizeToFit];
    [self.contentView addSubview:self.applyTimeL];
    
    self.cancelApplyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.cancelApplyBtn Title:String(@"取消申请") Target:@selector(cancelApplyAction)];
    [self.contentView addSubview:self.cancelApplyBtn];
    
    self.progressSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self setButtonWithButton:self.progressSearchBtn Title:String(@"进度查询") Target:@selector(progressSearchAction)];
    [self.contentView addSubview:self.progressSearchBtn];
    
}

//布局子视图
- (void)layoutViews
{
    [self.serviceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.serviceStatusL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.serviceNumLabel.mas_bottom);
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.goodImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.top.equalTo(self.serviceStatusL.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(kImageViewSize);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodImageV.mas_top);
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.applyTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.goodImageV.mas_bottom);
        make.left.equalTo(self.titleLabel.mas_left);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = Home_ListCell_Line_Color;
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.goodImageV.mas_bottom).offset(Adapted(kMargin));
        make.height.offset(ListCell_Line_W_H);
    }];
    
    [self.progressSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(Adapted(kMargin));
        make.right.equalTo(self.titleLabel.mas_right);
        make.size.mas_offset(kButtonSize);
        make.bottom.offset(Adapted(-kMargin));
    }];
    
    [self.cancelApplyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(Adapted(kMargin));
        make.right.equalTo(self.progressSearchBtn.mas_left).offset(Adapted(-kMargin));
        make.size.mas_offset(kButtonSize);
    }];
}

#pragma mark - custom method
- (void)setButtonWithButton:(UIButton *)sender Title:(NSString *)title Target:(SEL)target
{
    sender.titleLabel.font = Font_Min;
    [sender setTitle:title forState:UIControlStateNormal];
    sender.layer.cornerRadius = 5.0f;
    sender.layer.masksToBounds = YES;
    sender.layer.borderColor = QF_GrayColor.CGColor;
    sender.layer.borderWidth = 0.5f;
    [sender addTarget:self action:target forControlEvents:UIControlEventTouchUpInside];
    [sender setTitleColor:QF_GrayColor forState:UIControlStateNormal];
}
#pragma mark - handle action

- (void)cancelApplyAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyOrderRefundSearchCellDelegate_clickCancelApply)]) {
        [self.delegate MyOrderRefundSearchCellDelegate_clickCancelApply];
    }
}
- (void)progressSearchAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyOrderRefundSearchCellDelegate_clickProgressSearch)]) {
        [self.delegate MyOrderRefundSearchCellDelegate_clickProgressSearch];
    }
}
#pragma mark - setter model
- (void)setModel:(MyOrderRefundSearchModel *)model
{
    _model = model;
    self.serviceNumLabel.text = [NSString stringWithFormat:@"%@：%@",String(@"  服务单号"),model.serviceNumber];
    self.serviceStatusL.text = [NSString stringWithFormat:@"  %@",model.serviceStatus];
    self.goodImageV.image = ImageStr(model.goodImage);
    self.titleLabel.text = model.title;
    self.applyTimeL.text = [NSString stringWithFormat:@"%@：%@",String(@"申请时间"),model.applyTime];
}

@end
