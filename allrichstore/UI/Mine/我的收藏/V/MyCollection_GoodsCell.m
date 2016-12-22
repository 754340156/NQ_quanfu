//
//  MyCollection_GoodsCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCollection_GoodsCell.h"
#import "MyCollection_GoodsModel.h"
#import <objc/runtime.h>

#define kImageVSize CGSizeMake(Adapted(130), Adapted(100))
#define kLabelH 40.0f
#define kSubLabelW (kScreenW - Adapted(130)- 3 * Adapted(kMargin)) / 3
#define kSubLabelH 20.0f
@interface MyCollection_GoodsCell ()
/** 商品图片  */
@property(nonatomic,strong) UIImageView * bigImageV;
/**  商品名 */
@property(nonatomic,strong) UILabel * goodsTitleL;
/**  价钱 */
@property(nonatomic,strong) UILabel * priceLabel;
/**  货物地址 */
@property(nonatomic,strong) UILabel * addressLabel;
/**  付款的人数 */
@property(nonatomic,strong) UILabel  * evaluateCtnLabel;
/**  好评率 */
@property(nonatomic,strong) UILabel *  positiveRatioL;
/**  加入购物车 */
@property(nonatomic,strong) UIButton * intoCartBtn;
@end


@implementation MyCollection_GoodsCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.bigImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bigImageV];
    
    self.goodsTitleL = [[UILabel alloc] init];
    self.goodsTitleL.numberOfLines = 0;
    self.goodsTitleL.textColor = QF_BlackColor;
    self.goodsTitleL.font = Font_Mid;
    [self.contentView addSubview:self.goodsTitleL];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = Font_Mid;
    self.priceLabel.textColor = QF_RedColor;
    [self.priceLabel sizeToFit];
    [self.contentView addSubview:self.priceLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = Font_Min;
    self.addressLabel.textColor = QF_GrayColor;
    self.addressLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.addressLabel];
    
    self.evaluateCtnLabel = [[UILabel alloc] init];
    self.evaluateCtnLabel.font = Font_Min;
    self.evaluateCtnLabel.textColor = QF_GrayColor;
    [self.contentView addSubview:self.evaluateCtnLabel];
    
    self.positiveRatioL = [[UILabel alloc] init];
    self.positiveRatioL.font = Font_Min;
    self.positiveRatioL.textColor = QF_GrayColor;
    [self.contentView addSubview:self.positiveRatioL];
    
    self.intoCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.intoCartBtn.layer.borderColor = QF_RedColor.CGColor;
    self.intoCartBtn.layer.borderWidth = 0.5f;
    self.intoCartBtn.layer.cornerRadius = 5.0f;
    self.intoCartBtn.layer.masksToBounds = YES;
    [self.intoCartBtn setTitleColor:QF_RedColor forState:UIControlStateNormal];
    self.intoCartBtn.titleLabel.font = Font_Min;
    [self.intoCartBtn addTarget:self action:@selector(intoCarAction) forControlEvents:UIControlEventTouchUpInside];
    [self.intoCartBtn setTitle:String(@"加入购物车") forState:UIControlStateNormal];
    [self.contentView addSubview:self.intoCartBtn];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.bigImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(Adapted(kMargin));
        make.bottom.offset(Adapted(-kMargin));
        make.size.mas_offset(kImageVSize);
    }];
    
    [self.goodsTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bigImageV.mas_right).offset(Adapted(kMargin));
        make.top.equalTo(self.bigImageV.mas_top);
        make.right.offset(Adapted(-kMargin));
        make.height.offset(Adapted(kLabelH));
    }];
    
    [self.evaluateCtnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsTitleL.mas_left);
        make.top.equalTo(self.goodsTitleL.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(kSubLabelW, kSubLabelH));
    }];
    
    [self.positiveRatioL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsTitleL.mas_bottom).offset(Adapted(kMargin));
        make.left.equalTo(self.evaluateCtnLabel.mas_right);
        make.size.mas_offset(CGSizeMake(kSubLabelW, kSubLabelH));
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.positiveRatioL.mas_right);
        make.top.equalTo(self.goodsTitleL.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(kSubLabelW, kSubLabelH));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsTitleL.mas_left);
        make.top.equalTo(self.evaluateCtnLabel.mas_bottom).offset(Adapted(kMargin));
        make.bottom.equalTo(self.bigImageV.mas_bottom);
    }];
    
    [self.intoCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(Adapted(75), Adapted(25)));
        make.right.bottom.offset(Adapted(-kMargin));
    }];
}
/*  修改编辑样式 */
-(void)layoutSubviews
{
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image= Image(@"xuanze_yixuan");
                    }else
                    {
                        img.image=Image(@"xuanze_weixuan");
                    }
                }
            }
        }
    }
    
    [super layoutSubviews];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img = (UIImageView *)v;
                    if (!self.selected) {
                        img.image = Image(@"xuanze_weixuan");
                    }else
                    {
                        img.image = Image(@"xuanze_yixuan");
                    }
                }
            }
        }
    }
    
}
#pragma mark - custom method

#pragma mark - handle action
- (void)intoCarAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyCollection_GoodsCellDelegate_clickIntoCartBtn)]) {
        [self.delegate MyCollection_GoodsCellDelegate_clickIntoCartBtn];
    }
}
#pragma mark - setter model
- (void)setModel:(MyCollection_GoodsModel *)model
{
    _model = model;
#warning 展位图
    [self.bigImageV sd_setImageWithURL:[NSURL URLWithString:model.g_imgurl] placeholderImage:nil];
    self.goodsTitleL.text = model.g_name;
    self.addressLabel.text = model.g_site;
    self.evaluateCtnLabel.text = [NSString stringWithFormat:@"%@人付款",[NSString StringBreakWanHandleWithString:model.g_salenumber]];
    self.positiveRatioL.text = model.g_famerate;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",[model.g_price floatValue]];
}

@end
