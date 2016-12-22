//
//  GoodsHorizontalLayoutCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GoodsHorizontalLayoutCell.h"
#import "GoodsModel.h"  

#define kFont_Title QFFont_GoodsOblongCell_Title //标题字体
#define kFont_Price QFFont_GoodsOblongCell_Price //价格字体
#define kFont_BuyCtn QFFont_GoodsOblongCell_Min //付款人数字体
#define kFont_Address QFFont_GoodsOblongCell_Min //地址字体

//图片的边距
#define kMargin_ImgView Adapted(10)
//图片的宽度
#define KImgView_W  Adapted(100)
//图片的高度
#define kImgView_H  (KImgView_W / Cell_Goods_W_H_Scale)

//图片与标题的水平间距
#define kSpace_Img_Title  Adapted(10)

//右间距
#define kMargin_Right_Title    Adapted(10)

//标题与评价与价格的间距
#define kSpace_Labels_Vertical  Adapted(12)

@interface GoodsHorizontalLayoutCell ()
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

@implementation GoodsHorizontalLayoutCell
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
    self.addressLabel.font = kFont_Address;
    self.addressLabel.textColor = kGrayColor_D;
    [self.contentView addSubview:self.addressLabel];
    
    self.buyCtnLabel = [[UILabel alloc] init];
    self.buyCtnLabel.textColor = kGrayColor_D;
    self.buyCtnLabel.font = kFont_BuyCtn;
    self.buyCtnLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.buyCtnLabel];
    
    [self.contentView addBottomLineWithColor:BaseColor_Cell_SplitLine height:0.7];
}

//布局子视图
- (void)layoutViews
{
    [_goodsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(kMargin_ImgView);
        make.left.offset(kMargin_ImgView);
        make.bottom.offset(-kMargin_ImgView-0.7);
        
        make.width.equalTo(_goodsImageV.mas_height).multipliedBy(Cell_Goods_W_H_Scale);
        
    }];
    
    [_goodsTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_goodsImageV);
        make.left.equalTo(_goodsImageV.mas_right).offset(kSpace_Img_Title);
        make.right.offset(-kMargin_Right_Title);
        make.height.offset([_goodsTitleL getHeight]);
        
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_goodsTitleL);
        make.top.equalTo(_goodsTitleL.mas_bottom).offset(kSpace_Labels_Vertical);
        make.right.offset(-kMargin_Right_Title);
        make.height.offset([_addressLabel getHeight]);
        
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_goodsTitleL);
        make.top.equalTo(_addressLabel.mas_bottom).offset(kSpace_Labels_Vertical);
        make.width.offset(Adapted(110));
        make.height.offset([_priceLabel getHeight]);
        
        make.bottom.equalTo(_goodsImageV.mas_bottom).offset(-Adapted(5));
    }];
    
    [_buyCtnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-kMargin_Right_Title);
        make.centerY.equalTo(_priceLabel);
        make.height.offset([_buyCtnLabel getHeight]);
        make.left.equalTo(_priceLabel.mas_right).offset(Adapted(5));
        
    }];
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
    _model = model;
}
@end
