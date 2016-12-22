//
//  HotSectionHeader.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/01.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "HotSectionHeader.h"

@implementation HotSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createViews]; //创建子视图
        [self layoutViews]; //布局子视图
    }
    return self;
}

//创建子视图
- (void)createViews
{
    self.backgroundColor = Color_ScrollViewBg;
    
    self.leftImgView = [UIImageView new];
    _leftImgView.contentMode = UIViewContentModeLeft;
    _leftImgView.hidden = YES;
    [self addSubview:_leftImgView];
    
    [self addSubview:self.leftLabel];
    
    self.rightBtn = [[QButton alloc] initWithFrame:CGRectZero style:QButtonStyleImageRight layoutStyle:QButtonLayoutStyleRight font:Font(14) title:String(@"查看更多") image:nil space:Adapted(10) margin:Adapted(10) autoSize:NO];
    [_rightBtn setTitleColor:kGrayColor_D forState:UIControlStateNormal];
    [self addSubview:_rightBtn];
    
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:1.0];
}

//布局子视图
- (void)layoutViews
{
    [_leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(Adapted(10));
        make.centerY.offset(0);
        make.height.offset(16);
        make.width.offset(80);
    }];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(Adapted(12));
        make.centerY.offset(0);
        make.height.offset(30);
        make.width.offset(100);
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.and.bottom.right.offset(0);
        make.width.offset(Adapted(160));
    }];
}

#pragma mark - lazy
- (UILabel *)leftLabel
{
    if (!_leftLabel)
    {
        self.leftLabel = [UILabel new];
//        UIFont *font = [UIFont customFontWithName:@"qingchakaiti.ttf" size:21];
        UIFont *font = [UIFont customFontWithName:@"腾祥细潮黑简.ttf" size:21];
        _leftLabel.shadowColor = kLightGrayColor;
        _leftLabel.shadowOffset = CGSizeMake(0, -0.5);       _leftLabel.font = font;
    }
    return _leftLabel;
}

@end
