//
//  MyCollection_ShopsVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCollection_ShopsCell.h"
#import "MyCollection_ShopsModel.h"
#define kImageVH 60.0f

@interface MyCollection_ShopsCell ()
/**  imageView */
@property(nonatomic,strong) UIImageView * bigImageV;
/**  评分 */
@property(nonatomic,strong) UILabel * scoreLabel;
@end


@implementation MyCollection_ShopsCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.bigImageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bigImageV];
    
    self.titleLabel.font = Font_Mid;
    self.titleLabel.textColor = QF_BlackColor;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.scoreLabel = [[UILabel alloc] init];
    self.scoreLabel.textColor = QF_RedColor;
    self.scoreLabel.font = Font_Mid;
    self.scoreLabel.textAlignment = NSTextAlignmentRight;
    [self.scoreLabel sizeToFit];
    [self.contentView addSubview:self.scoreLabel];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    [self.bigImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(kImageVH), Adapted(kImageVH)));
        make.bottom.offset(Adapted(-kMargin));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bigImageV.mas_right).offset(Adapted(kMargin * 3 / 2));
        make.centerY.offset(Adapted(-kMargin * 3 / 2));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bigImageV.mas_right).offset(Adapted(kMargin * 3 / 2));
        make.centerY.offset(Adapted(kMargin * 3 / 2));
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

#pragma mark - setter model
- (void)setModel:(MyCollection_ShopsModel *)model
{
    _model = model;
#warning 展位图
   [self.bigImageV sd_setImageWithURL:[NSURL URLWithString:model.s_headimage] placeholderImage:nil];
    self.titleLabel.text = model.s_name;
    self.scoreLabel.text = model.s_score;
}

@end
