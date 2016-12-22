//
//  GoodsTwoListFirstStyleCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsTwoListFirstStyleCell.h"

#define kFont_Title QFFont_GoodsSquareCell_Title //标题字体
#define kFont_Price QFFont_GoodsSquareCell_Price //价格字体
#define kFont_EvaluatNum QFFont_GoodsSquareCell_Min //好评人数字体
#define kFont_Praise QFFont_GoodsSquareCell_Min //好评字体

#define ListCell_Space  1

#define kMargin_ImgView Adapted(9)

#define KImgView_W  ((kScreenW - ListCell_Space) / 2.0 - 2 * kMargin_ImgView)
#define kImgView_H  floorf(((kScreenW - ListCell_Space) / 2.0 - 2 * kMargin_ImgView) / Cell_Goods_W_H_Scale)

#define kSpace_Img_Title  Adapted(10)

#define kSpace_Title_Price  Adapted(6)

#define kMargin_Price   Adapted(9)

#define kSpace_Labels_Level    1

#define kPrice_W        ((KImgView_W  -  3.0 * kSpace_Labels_Level) / 3.0 + 2 * kSpace_Labels_Level)
#define kEvaluatNum_W   ((KImgView_W  -  3.0 * kSpace_Labels_Level) / 3.0 - 0 * kSpace_Labels_Level)
#define kPraise_W       ((KImgView_W  -  3.0 * kSpace_Labels_Level) / 3.0 - 2 * kSpace_Labels_Level)

@implementation GoodsTwoListFirstStyleCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.backgroundColor = kWhiteColor;
    
    [self.contentView addSubview:self.imgView];         //商品图标
    [self.contentView addSubview:self.titleLabel];      //商品标题
    [self.contentView addSubview:self.priceLabel];      //商品价格
    [self.contentView addSubview:self.evaluatNumLabel]; //评价人数
    [self.contentView addSubview:self.praiseRateLabel]; //好评率

    _titleLabel.font = kFont_Title;
    _titleLabel.numberOfLines = 2.0;
    
    //添加分割线
    [self.contentView addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H];
    [self.contentView addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleOutside];
}

//布局子视图
- (void)layoutViews
{
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(kMargin_ImgView + 1.0);
        make.left.offset(kMargin_ImgView);
        make.right.offset(-kMargin_ImgView);
        make.height.offset(kImgView_H);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_imgView.mas_bottom).offset(kSpace_Img_Title);
        make.left.equalTo(_imgView);
        make.right.equalTo(_imgView);
        make.height.offset([_titleLabel getHeight]);
        
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_imgView);
        make.top.equalTo(_titleLabel.mas_bottom).offset(kSpace_Title_Price);
        make.height.offset([_priceLabel getHeight]);
        make.width.offset(kPrice_W);
        
    }];
    
    [_evaluatNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_priceLabel);
        make.width.offset(kEvaluatNum_W);
        make.left.equalTo(_priceLabel.mas_right).offset(kSpace_Labels_Level);
        make.height.offset([_evaluatNumLabel getHeight]);
    }];
    
    [_praiseRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_priceLabel);
        make.width.offset(kPraise_W);
        make.right.equalTo(_titleLabel.mas_right);
        make.height.offset([_praiseRateLabel getHeight]);
    }];
}

+ (CGFloat)cellHeight
{
    return (kMargin_ImgView + kImgView_H + kSpace_Img_Title + [UILabel getHeightWithFont:kFont_Title] * 2.0 + kSpace_Title_Price + [UILabel getHeightWithFont:kFont_Price] + kMargin_Price);
}

#pragma mark - lazy
- (UILabel *)priceLabel
{
    if (!_priceLabel)
    {
        self.priceLabel = [UILabel new];
        _priceLabel.textColor = QF_RedColor;
        _priceLabel.font = kFont_Price;
    }
    return _priceLabel;
}

- (UILabel *)evaluatNumLabel
{
    if (!_evaluatNumLabel)
    {
        self.evaluatNumLabel = [UILabel new];
        _evaluatNumLabel.textColor = kGrayColor_D;
        _evaluatNumLabel.font = kFont_EvaluatNum;
        _evaluatNumLabel.textAlignment = NSTextAlignmentRight;
    }
    return _evaluatNumLabel;
}

- (UILabel *)praiseRateLabel
{
    if (!_praiseRateLabel)
    {
        self.praiseRateLabel = [UILabel new];
        _praiseRateLabel.textColor = kGrayColor_D;
        _praiseRateLabel.font = kFont_Praise;
        _praiseRateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _praiseRateLabel;
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(GoodsModel *)model
{
    if (_model == model)
    {
        return;
    }
    _model = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.g_imgurl] placeholderImage:Image_PlaceHolder_GoodsListCell];
    _titleLabel.text = model.g_name;
    _priceLabel.text = [NSString stringWithPrice:model.g_price];
    _evaluatNumLabel.text = [NSString stringWithFormat:String(@"%ld人评价"), model.g_commentcount];
    _praiseRateLabel.text = [NSString stringWithFormat:String(@"好评%@"), model.g_famerate];
}

@end
