//
//  GD_StoreCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/12.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "GD_StoreCell.h"

@interface GD_StoreCell ()
/**  头像 */
@property(nonatomic,strong) UIImageView * iconImageV;
/**  店铺名 */
@property(nonatomic,strong) UILabel * nickNameL;
/**  店铺评分 */
@property(nonatomic,strong) UILabel * scoreLabel;
/**  进店逛逛 */
@property(nonatomic,strong) UIButton * intoButton;
@end

@implementation GD_StoreCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.iconImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageV];
    
    self.nickNameL = [[UILabel alloc] init];
    [self.nickNameL sizeToFit];
    self.nickNameL.textColor = QF_BlackColor;
    self.nickNameL.font = Font_Mid;
    self.nickNameL.numberOfLines = 1;
    [self.contentView addSubview:self.nickNameL];
    
    self.scoreLabel = [[UILabel alloc] init];
    self.scoreLabel.font = Font_Mid;
    self.scoreLabel.textColor = QF_GrayColor;
    [self.scoreLabel sizeToFit];
    [self.contentView addSubview:self.scoreLabel];
    
    self.intoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.intoButton addTarget:self action:@selector(intoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.intoButton setTitle:String(@"进店逛逛") forState:UIControlStateNormal];
    self.intoButton.titleLabel.font = Font_Mid;
    [self.intoButton setTitleColor:QF_RedColor forState:UIControlStateNormal];
    self.intoButton.layer.cornerRadius = 5.0f;
    self.intoButton.layer.borderColor = QF_RedColor.CGColor;
    self.intoButton.layer.borderWidth = 0.5f;
    [self.contentView addSubview:self.intoButton];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];

}

//布局子视图
- (void)layoutViews
{
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(40), Adapted(40)));
    }];
    
    [self.nickNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.iconImageV.mas_right).offset(Adapted(kMargin));
        make.height.offset(Adapted(kMargin));
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.nickNameL.mas_right).offset(Adapted(kMargin));
        make.height.offset(Adapted(kMargin));
    }];
    
    [self.intoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.offset(Adapted(-kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(70), Adapted(25)));
    }];
}

#pragma mark - custom method

#pragma mark - handle action

- (void)intoAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(GD_StoreCellDelegate_clickIntoButton:)]) {
        [self.delegate GD_StoreCellDelegate_clickIntoButton:sender];
    }
}
#pragma mark - setter model
- (void)setModel:(GoodsDetailStoreModel *)model
{
    _model = model;
    [self.iconImageV sd_setImageWithURL:[NSURL URLWithString:model.s_headimage] placeholderImage:Image_PlaceHolder_Photo];
    self.nickNameL.text = model.s_name;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@：%@",String(@"综合"),model.s_score];
}
#pragma mark - lazy
@end
