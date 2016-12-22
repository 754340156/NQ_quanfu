//
//  GoodsOneListFirstStyleCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsOneListFirstStyleCell.h"

#define kFont_Title QFFont_GoodsOblongCell_Title //标题字体
#define kFont_Price QFFont_GoodsOblongCell_Price //价格字体
#define kFont_PayCtn QFFont_GoodsOblongCell_Min  //付款人数字体
#define kFont_Address QFFont_GoodsOblongCell_Address //地址字体
#define kFont_Praise  QFFont_GoodsOblongCell_Min //好评率字体

//图片的边距
#define kMargin_ImgView Adapted(9)
////图片的宽度
//#define KImgView_W  Adapted(100)
////图片的高度
//#define kImgView_H  (KImgView_W / Cell_Goods_W_H_Scale)

//图片与标题的水平间距
#define kSpace_Img_Title  Adapted(9)

//右间距
#define kMargin_Right_Title    Adapted(10)

//控件的垂直的间距
#define kSpace_Labels_Vertical  Adapted(9)

#define kSpace_Labels_Level    1

//好评率的宽度
#define kPraiseRate_W   Adapted(68)
//评价的宽度
#define kPayCount_W     Adapted(68)



@interface GoodsOneListFirstStyleCell ()

@end

@implementation GoodsOneListFirstStyleCell
#pragma mark - override super
//创建子视图
- (void)createViews
{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.praiseRateLabel];
    [self.contentView addSubview:self.payCountLabel];
    
//    _priceLabel.backgroundColor = kRedColor;
//    _praiseRateLabel.backgroundColor = kGreenColor;
//    _payCountLabel.backgroundColor = kOrangeColor;
    
    _titleLabel.numberOfLines = 2;
    _titleLabel.font = kFont_Title;
    
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = kFont_Address;
    self.addressLabel.textColor = kGrayColor_D;
    [self.contentView addSubview:self.addressLabel];
    
    
    [self.contentView addBottomLineWithColor:BaseColor_Cell_SplitLine height:0.7];
}

//布局子视图
- (void)layoutViews
{
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(kMargin_ImgView);
        make.left.offset(kMargin_ImgView);
        make.bottom.offset(-kMargin_ImgView-0.7);
        
        make.width.equalTo(_imgView.mas_height).multipliedBy(Cell_Goods_W_H_Scale);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_imgView);
        make.left.equalTo(_imgView.mas_right).offset(kSpace_Img_Title);
        make.right.offset(-kMargin_Right_Title);
        make.height.offset([_titleLabel getHeight]);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(kSpace_Labels_Vertical);
        make.right.offset(-kMargin_Right_Title);
        make.height.offset([_addressLabel getHeight]);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_addressLabel.mas_bottom).offset(kSpace_Labels_Vertical);
        make.height.offset([_priceLabel getHeight]);
        make.right.equalTo(_praiseRateLabel.mas_left).offset(-kSpace_Labels_Level);
        make.bottom.equalTo(_imgView.mas_bottom).offset(-Adapted(3));
    }];
    
    [_payCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-kMargin_Right_Title);
        make.centerY.equalTo(_priceLabel);
        make.height.offset([_payCountLabel getHeight]);
        make.width.offset(kPayCount_W);
        
    }];
    
    [_praiseRateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(_payCountLabel.mas_left).offset(-kSpace_Labels_Level);
        make.centerY.equalTo(_priceLabel);
        make.height.offset([_praiseRateLabel getHeight]);
        make.width.offset(kPraiseRate_W);
        
    }];
}

#pragma mark - lazy
- (UILabel *)addressLabel
{
    if (!_addressLabel)
    {
        self.addressLabel = [UILabel new];
        _addressLabel.textColor = QF_GrayColor_GoodsListCell;
        _addressLabel.font = kFont_Address;
    }
    return _addressLabel;
}

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

- (UILabel *)praiseRateLabel
{
    if (!_praiseRateLabel)
    {
        self.praiseRateLabel = [UILabel new];
        _praiseRateLabel.textColor = QF_GrayColor_GoodsListCell;
        _praiseRateLabel.font = kFont_Praise;
        _praiseRateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _praiseRateLabel;
}

- (UILabel *)payCountLabel
{
    if (!_payCountLabel)
    {
        self.payCountLabel = [UILabel new];
        _payCountLabel.textColor = QF_GrayColor_GoodsListCell;
        _payCountLabel.font = kFont_PayCtn;
        _payCountLabel.textAlignment = NSTextAlignmentRight;
    }
    return _payCountLabel;
}

+ (CGFloat)cellHeight
{
    
    return (kMargin_ImgView * 2.0 + 0.7 +  kSpace_Labels_Vertical * 2.0 + Adapted(5) + [UILabel getHeightWithFont:kFont_Title] * 2.0 + [UILabel getHeightWithFont:kFont_Address] + [UILabel getHeightWithFont:kFont_Price]);
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
    _addressLabel.text = model.g_site;
    _praiseRateLabel.text = [NSString stringWithFormat:String(@"好评%@"), model.g_famerate];
    _payCountLabel.text = [NSString stringWithFormat:String(@"%ld人付款"), model.g_paysum];
}

@end
