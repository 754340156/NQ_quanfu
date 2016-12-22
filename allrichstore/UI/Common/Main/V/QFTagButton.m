//
//  QFTagButton.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "QFTagButton.h"

//cell的背景颜色
#define kColor_Bg           [UIColor colorWithRed:240.0 / 255.0 green:242.0 / 255.0 blue:244.0 / 255.0 alpha:1.0]
#define kColor_selectedBg   [UIColor whiteColor]

//cell的默认颜色
#define kCell_NormalColor    [UIColor clearColor]
//cell的选中颜色
#define kCell_SelectedColor  QF_RedColor


@implementation QFTagButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    QFTagButton *btn = [super buttonWithType:buttonType];
    btn.backgroundColor = kColor_Bg;
    btn.layer.borderColor = kCell_NormalColor.CGColor;
    return btn;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = kColor_Bg;
        self.layer.borderColor = kCell_NormalColor.CGColor;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kColor_Bg;
        self.layer.borderColor = kCell_NormalColor.CGColor;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {
        self.backgroundColor = kColor_selectedBg;
        self.layer.borderColor = kCell_SelectedColor.CGColor;
    }
    else
    {
        self.backgroundColor = kColor_Bg;
        self.layer.borderColor = kCell_NormalColor.CGColor;
    }
}

@end
