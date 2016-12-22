//
//  GoodsHaveBtnStyleTableCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/4.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsHaveBtnStyleTableCell.h"

#define kFont_Title QFFont_GoodsOblongCell_Title //标题字体
#define kFont_Price QFFont_GoodsOblongCell_Price //价格字体
#define kFont_EvaluatNum QFFont_GoodsOblongCell_Min //好评人数字体
#define kFont_Praise QFFont_GoodsOblongCell_Min //好评率字体

#define ListCell_Space  1

//图片的边距
#define kMargin_ImgView Adapted(9)

//图片与标题的水平间距
#define kSpace_Img_Title  Adapted(10)

//右间距
#define kMargin_Right_Title    Adapted(10)

//垂直的间距
#define kSpace_Labels_Vertical  Adapted(10)


//购物车按钮的inset
//#define kBtn_Inset_Vertical  Adapted(3)
//#define kBtn_Inset_Level     Adapted(3)


@implementation GoodsHaveBtnStyleTableCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.evaluatNumLabel];
    [self.contentView addSubview:self.praiseRateLabel];
    [self.contentView addSubview:self.addToCartBtn];
    self.bottomMargin = 0;
    
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.font = kFont_Title;
    self.titleLabel.numberOfLines = 2.0;
}

//布局子视图
- (void)layoutViews
{
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(kMargin_ImgView);
        make.left.offset(kMargin_ImgView);
        make.bottom.offset(-kMargin_ImgView-self.bottomHeight);
        
        make.width.equalTo(_imgView.mas_height).multipliedBy(Cell_Goods_W_H_Scale);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_imgView);
        make.left.equalTo(_imgView.mas_right).offset(kSpace_Img_Title);
        make.right.offset(-kMargin_Right_Title);
        make.height.offset([_titleLabel getHeight]);
        
    }];
    
    [_evaluatNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(kSpace_Labels_Vertical);
//        make.width.equalTo(_titleLabel.mas_width).multipliedBy(0.4);
        make.height.offset([_evaluatNumLabel getHeight]);
        
    }];
    
    [_praiseRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //make.left.equalTo(_evaluatNumLabel.mas_right).offset(Adapted(20));
        make.top.equalTo(_titleLabel.mas_bottom).offset(kSpace_Labels_Vertical);
        //make.width.equalTo(_evaluatNumLabel);
        make.left.equalTo(_evaluatNumLabel.mas_right).offset(Adapted(16));
        make.height.offset([_praiseRateLabel getHeight]);
        make.right.offset(-kMargin_Right_Title);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_evaluatNumLabel.mas_bottom).offset(kSpace_Labels_Vertical);
        make.width.offset(Adapted(160));
        make.height.offset([_priceLabel getHeight]);
        
        make.bottom.equalTo(_imgView.mas_bottom).offset(-Adapted(5));
    }];
    
    [_addToCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-kMargin_Right_Title);
        make.centerY.equalTo(_priceLabel);
        make.height.offset(Adapted(26));
        make.width.equalTo(_addToCartBtn.mas_height).multipliedBy(3.0);
        
    }];
    
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
        _evaluatNumLabel.textAlignment = NSTextAlignmentLeft;
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
        _praiseRateLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _praiseRateLabel;
}

- (UIButton *)addToCartBtn
{
    if (!_addToCartBtn)
    {
        self.addToCartBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _addToCartBtn.layer.masksToBounds = YES;
        _addToCartBtn.layer.cornerRadius = Adapted(5);
        _addToCartBtn.layer.borderWidth = 0.6;
        _addToCartBtn.layer.borderColor = QF_RedColor.CGColor;
        [_addToCartBtn setTitleColor:QF_RedColor forState:UIControlStateNormal];
        [_addToCartBtn setTitle:String(@"加入购物车") forState:UIControlStateNormal];
        [_addToCartBtn.titleLabel setFont:AdaptedFont(14)];
    }
    return _addToCartBtn;
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(GoodsModel *)model
{
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.g_imgurl] placeholderImage:Image_PlaceHolder_GoodsListCell];
    _titleLabel.text = model.g_name;
    _priceLabel.text = [NSString stringWithPrice:model.g_price];
    _evaluatNumLabel.text = [NSString stringWithFormat:String(@"评价%ld人"), model.g_commentcount];
    _praiseRateLabel.text = [NSString stringWithFormat:String(@"好评%@"), model.g_famerate];
}

@end
