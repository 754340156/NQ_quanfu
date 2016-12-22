//
//  FoldMenu_Cell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "FoldMenu_Cell.h"

//cell选中时的背景色
#define kSelectedBgColor    BaseColor_Cell_SelectedBackground

//底线的属性
#define kBottomLineView_Color   [UIColor colorWithWhite:0.92 alpha:1.0];
#define kBottomLineView_Height  0.8

//cell的背景颜色
#define kCell_BgColor   [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1.0]

@implementation FoldMenu_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = kCell_BgColor;
        self.clipsToBounds = YES;
        
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = kSelectedBgColor;
        
        
        self.titleBtn = [QButton buttonWithType:UIButtonTypeCustom];
        _titleBtn.userInteractionEnabled = NO;
        _titleBtn.titleLabel.font = AdaptedFont(16);
        [self.contentView addSubview:_titleBtn];
        
        [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.offset(0);
            
        }];
        
        UIView *bottomLineView = [UIView new];
        bottomLineView.backgroundColor = kBottomLineView_Color;
        [self.contentView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.offset(0);
            make.height.offset(kBottomLineView_Height);
            
        }];
    }
    return self;
}

@end
