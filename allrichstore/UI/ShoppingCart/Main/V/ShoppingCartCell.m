//
//  ShoppingCartCell_Cell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "ShoppingCartModel.h"

#define kSelectedButtonSize CGSizeMake(Adapted(25.0f), Adapted(25.0f))
#define kAddHeight 20.0f
#define kImageVSize CGSizeMake(Adapted(130), Adapted(130) / Cell_Goods_W_H_Scale)
@interface ShoppingCartCell ()<UITextFieldDelegate>
/**  选中按钮 */
@property(nonatomic,strong) UIButton * selectedButton;
/**  商品图 */
@property(nonatomic,strong) UIImageView * goodImageV;
/**  二级标题1 */
@property(nonatomic,strong) UILabel * subTitleL1;
/**  二级标题2 */
@property(nonatomic,strong) UILabel * subTitleL2;
/**  价格 */
@property(nonatomic,strong) UILabel * priceLabel;
/**  减号 */
@property(nonatomic,strong) UIButton * reduceButton;
/**  加号 */
@property(nonatomic,strong) UIButton * addButton;
@end

@implementation ShoppingCartCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectedButton setImage:Image(@"xuanze_weixuan") forState:UIControlStateNormal];
    [self.selectedButton setImage:Image(@"xuanze_yixuan") forState:UIControlStateSelected];
    [self.selectedButton addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectedButton];
    
    self.goodImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.goodImageV];
    
    self.titleLabel.font = Font_Mid;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.subTitleL1 = [[UILabel alloc] init];
    self.subTitleL1.font = Font_Min;
    self.subTitleL1.textColor = QF_GrayColor;
    [self.subTitleL1 sizeToFit];
    [self.contentView addSubview:self.subTitleL1];
    
    self.subTitleL2 = [[UILabel alloc] init];
    self.subTitleL2.font = Font_Min;
    self.subTitleL2.textColor = QF_GrayColor;
    [self.subTitleL2 sizeToFit];
    [self.contentView addSubview:self.subTitleL2];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.font = Font_Mid;
    self.priceLabel.textColor = QF_RedColor;
    [self.priceLabel sizeToFit];
    [self.contentView addSubview:self.priceLabel];
    
    self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.reduceButton setBackgroundColor:QFColor_CoodsClassMenuViewBg];
    [self.reduceButton setTitle:@"-" forState:UIControlStateNormal];
    [self.reduceButton setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self.reduceButton setTitleColor:QF_GrayColor forState:UIControlStateDisabled];
    [self.reduceButton addTarget:self action:@selector(reduceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.reduceButton];
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.font = Font_Mid;
    self.numberLabel.textColor = QF_BlackColor;
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.contentView addSubview:self.numberLabel];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton setBackgroundColor:QFColor_CoodsClassMenuViewBg];
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    [self.addButton setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self.addButton setTitleColor:QF_GrayColor forState:UIControlStateDisabled];
    [self.addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addButton];

    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(kSelectedButtonSize);
    }];
    
    [self.goodImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(kImageVSize);
        make.left.equalTo(self.selectedButton.mas_right).offset(Adapted(kMargin));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodImageV.mas_top);
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.right.offset(Adapted(-kMargin));
    }];
    
    [self.subTitleL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Adapted(kMargin));
    }];
    
    [self.subTitleL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subTitleL1.mas_right).offset(Adapted(kMargin));
        make.top.equalTo(self.subTitleL1.mas_top);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageV.mas_right).offset(Adapted(kMargin));
        make.bottom.equalTo(self.goodImageV.mas_bottom);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(Adapted(-kMargin));
        make.centerY.equalTo(self.priceLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(Adapted(kAddHeight), Adapted(kAddHeight)));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addButton.mas_left).offset(-2);
        make.centerY.equalTo(self.priceLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(Adapted(kAddHeight * 2), Adapted(kAddHeight)));
    }];
    
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.numberLabel.mas_left).offset(-2);
        make.centerY.equalTo(self.priceLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(Adapted(kAddHeight), Adapted(kAddHeight)));
    }];
}

#pragma mark - custom method
//设置button
- (void)setButtonWithButton:(UIButton *)button Image:(NSString *)image SelectedImage:(NSString *)selectedImage state:(UIControlState)state target:(SEL)target
{
    [button setImage:Image(image) forState:UIControlStateNormal];
    [button setImage:Image(selectedImage) forState:state];
    [button addTarget:self action:@selector(target) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - handle action
- (void)selectedAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.model.isCellSelected = sender.selected;
    if (self.selectedBlock) {
        self.selectedBlock();
    }
}
- (void)reduceAction
{
    if (self.countReduceBlock) {
        self.countReduceBlock(self.reduceButton);
    }
}
- (void)addButtonAction
{
    if (self.countAddBlock) {
        self.countAddBlock(self.reduceButton);
    }
}
#pragma mark - UITextFieldDelegate

#pragma mark - KVO
#pragma mark - setter model
- (void)setModel:(ShoppingCartListModel *)model
{
    _model = model;
    self.goodImageV.image = ImageStr(model.icon);
    self.titleLabel.text = model.title;
    self.subTitleL1.text = model.subTitle1;
    self.subTitleL2.text = model.subTitle2;
    self.priceLabel.text = model.price;
    self.numberLabel.text = model.count;
    self.selectedButton.selected = model.isCellSelected;
}
@end
