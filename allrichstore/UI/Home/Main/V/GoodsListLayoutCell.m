//
//  GoodsListLayoutCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsListLayoutCell.h"
#import "GoodsModel.h"

#define kFont_Title QFFont_GoodsSquareCell_Title //标题字体
#define kFont_Price QFFont_GoodsSquareCell_Price //价格字体
#define kFont_BuyCtn QFFont_GoodsSquareCell_Min  //付款人数字体
#define kFont_Adress QFFont_GoodsSquareCell_Min  //地址字体

#define ListCell_Space  1

#define kMargin_ImgView Adapted(9)

#define KImgView_W  ((kScreenW - ListCell_Space) / 2.0 - 2 * kMargin_ImgView)
#define kImgView_H  floorf(((kScreenW - ListCell_Space) / 2.0 - 2 * kMargin_ImgView) / Cell_Goods_W_H_Scale)

#define kSpace_Img_Title  Adapted(10)

#define kSpace_Title_Price  Adapted(8)

#define kMargin_Price   Adapted(8)

#define kSpace_Labels_Level    1

#define kPrice_W        ((KImgView_W  -  3.0 * kSpace_Labels_Level) / 3.0 + 2 * kSpace_Labels_Level)
#define kBuyCtn_W   ((KImgView_W  -  3.0 * kSpace_Labels_Level) / 3.0 - 3 * kSpace_Labels_Level)
#define kAddress_W       ((KImgView_W  -  3.0 * kSpace_Labels_Level) / 3.0 + kSpace_Labels_Level)

@interface GoodsListLayoutCell ()
/**  商品图片 */
@property(nonatomic,strong) UIImageView * goodsImageV;
/**  商品名称 */
@property(nonatomic,strong) UILabel * goodsTitleL;
/**  价钱 */
@property(nonatomic,strong) UILabel * priceLabel;
/**  货物地址 */
@property(nonatomic,strong) UILabel * addressLabel;
/**  购买货物的人数 */
@property(nonatomic,strong) UILabel  * buyCtnLabel;
@end


@implementation GoodsListLayoutCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.goodsImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.goodsImageV];
    
    self.goodsTitleL = [[UILabel alloc] init];
    self.goodsTitleL.numberOfLines = 2;
    self.goodsTitleL.textColor = QF_BlackColor;
    self.goodsTitleL.font = kFont_Title;
    [self.contentView addSubview:self.goodsTitleL];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = kFont_Price;
    self.priceLabel.textColor = QF_RedColor;
    [self.contentView addSubview:self.priceLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = kFont_Adress;
    self.addressLabel.textColor = kGrayColor_D;
    self.addressLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.addressLabel];
    
    self.buyCtnLabel = [[UILabel alloc] init];
    self.buyCtnLabel.textColor = kGrayColor_D;
    self.buyCtnLabel.font = kFont_BuyCtn;
    self.buyCtnLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.buyCtnLabel];
    
    [self addTopLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleOutside];
    [self addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleOutside];
}

//布局子视图
- (void)layoutViews
{
    [self.goodsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(kMargin_ImgView);
        make.left.offset(kMargin_ImgView);
        make.right.offset(-kMargin_ImgView);
        make.height.offset(kImgView_H);
    }];
    
    [self.goodsTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_goodsImageV.mas_bottom).offset(kSpace_Img_Title);
        make.left.equalTo(_goodsImageV);
        make.right.equalTo(_goodsImageV);
        make.height.offset([_goodsTitleL getHeight]);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_goodsImageV);
        make.top.equalTo(_goodsTitleL.mas_bottom).offset(kSpace_Title_Price);
        make.height.offset([_priceLabel getHeight]);
        make.width.offset(kPrice_W);
    }];
    
    [self.buyCtnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_priceLabel);
        make.width.offset(kBuyCtn_W);
        make.left.equalTo(_priceLabel.mas_right).offset(kSpace_Labels_Level);
        make.height.offset([_buyCtnLabel
                            getHeight]);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_priceLabel);
        make.width.offset(kAddress_W);
        make.right.equalTo(_goodsTitleL);
        make.height.offset([_addressLabel getHeight]);
    }];
}

+ (CGFloat)cellHeight
{
    return (kMargin_ImgView + kImgView_H + kSpace_Img_Title + [UILabel getHeightWithFont:kFont_Title] * 2.0 + kSpace_Title_Price + [UILabel getHeightWithFont:kFont_Price] + kMargin_Price);
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(GoodsModel *)model
{
    _model = model;
}
@end
