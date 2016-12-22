//
//  CustomInputView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CustomInputView.h"



@interface CustomInputView ()
/**  titleLabel */
@property(nonatomic,strong) UILabel * titleLabel;

@end

@implementation CustomInputView

- (instancetype)initWithTitleName:(NSString *)titleName PlaceHolder:(NSString *)placeHolder IsGrayLine:(BOOL)isGrayLine
{
    self = [super init];
    if (self) {
         self.backgroundColor = kWhiteColor;
        [self setupWithTitleName:titleName PlaceHolder:placeHolder IsGrayLine:isGrayLine];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setupWithTitleName:(NSString *)titleName PlaceHolder:(NSString *)placeHolder IsGrayLine:(BOOL)isGrayLine
{
   self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.font = Font_Mid;
    self.titleLabel.text =  titleName;
    [self addSubview:self.titleLabel];
    
    self.textFiled = [[UITextField alloc] init];
    if (placeHolder) self.textFiled.placeholder = placeHolder;
    self.textFiled.font = Font_Mid;
    [self addSubview:self.textFiled];
    !isGrayLine ? : [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}
- (void)setLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(Adapted(kMargin));
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(Adapted(110), Adapted(20)));
    }];
    
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(Adapted(kMargin));
        make.bottom.equalTo(self.mas_bottom).offset(Adapted(-kMargin));
        make.right.equalTo(self.mas_right).offset(Adapted(-kMargin));
        make.top.equalTo(self.mas_top).offset(Adapted(kMargin));
    }];
    
    [self.titleLabel addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model


@end
