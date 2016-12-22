//
//  MyOrderDetailInvoiceCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/14.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderDetailInvoiceCell.h"
#import "MyOrderDetailModel.h"
@interface MyOrderDetailInvoiceCell ()
/**  发票信息 */
@property(nonatomic,strong) UILabel * invoiceTypeL;
/**  发票抬头 */
@property(nonatomic,strong) UILabel * invoiceRiseL;
/**  发票内容 */
@property(nonatomic,strong) UILabel * invoiceContentL;
@end

@implementation MyOrderDetailInvoiceCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.invoiceTypeL = [[UILabel alloc] init];
    [self.invoiceTypeL sizeToFit];
    self.invoiceTypeL.textColor = QF_BlackColor;
    self.invoiceTypeL.font = Font_Mid;
    [self.contentView addSubview:self.invoiceTypeL];
    
    self.invoiceRiseL = [[UILabel alloc] init];
    self.invoiceRiseL.numberOfLines = 0;
    self.invoiceRiseL.textColor = QF_GrayColor;
    self.invoiceRiseL.font = Font_Min;
    [self.contentView addSubview:self.invoiceRiseL];
    
    self.invoiceContentL = [[UILabel alloc] init];
    self.invoiceContentL.numberOfLines = 0;
    self.invoiceContentL.textColor = QF_GrayColor;
    self.invoiceContentL.font = Font_Min;
    [self.contentView addSubview:self.invoiceContentL];
}

//布局子视图
- (void)layoutViews
{
    UILabel *label1 = [[UILabel alloc] init];
    [label1 sizeToFit];
    label1.text = String(@"发票信息");
    label1.textColor = QF_BlackColor;
    label1.font = Font_Mid;
    [self.contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(Adapted(kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.invoiceTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_top);
        make.right.offset(Adapted(-kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = [NSString stringWithFormat:@"%@：",String(@"发票抬头")];
    label2.textColor = QF_GrayColor;
    label2.font = Font_Min;
    [self.contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(Adapted(kMargin));
        make.left.equalTo(label1.mas_left);
        make.height.offset([UILabel getHeightWithFont:kInvoiceRiseFont]);
        make.width.offset(Adapted(kInvoiceRiseW));
    }];
    
    [self.invoiceRiseL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2.mas_right);
        make.top.equalTo(label2.mas_top);
        make.right.offset(Adapted(-kMargin));
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = [NSString stringWithFormat:@"%@：",String(@"发票内容")] ;
    label3.textColor = QF_GrayColor;
    label3.font = Font_Min;
    [self.contentView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.invoiceRiseL.mas_bottom).offset(Adapted(kMargin));
        make.left.equalTo(label1.mas_left);
        make.height.offset([UILabel getHeightWithFont:kInvoiceRiseFont]);
        make.width.offset(Adapted(kInvoiceRiseW));
    }];
    
    [self.invoiceContentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label3.mas_right);
        make.top.equalTo(label3.mas_top);
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(MyOrderDetailModel *)model
{
    _model = model;
    self.invoiceTypeL.text = model.invoiceType;
    self.invoiceRiseL.text = model.invoiceRise;
    self.invoiceContentL.text = model.invoiceContent;
    self.invoiceRiseL.height = model.invoiceRiseH;
    self.invoiceContentL.height = model.invoiceContentH;
}


@end
