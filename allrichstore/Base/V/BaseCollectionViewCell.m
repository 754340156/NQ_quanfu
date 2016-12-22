//
//  BaseCollectionViewCell.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/21.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface BaseCollectionViewCell()

@property (nonatomic, strong) UIColor *bgColor;

@end

@implementation BaseCollectionViewCell
@synthesize bgView = _bgView, imgBtn = _imgBtn, titleLabel = _titleLabel, contentLabel = _contentLabel, timeLabel = _timeLabel, isHaveSeleBgView = _isHaveSeleBgView, seleBgColor = _seleBgColor, isHaveHighlightColor = _isHaveHighlightColor,  highlightBgColor = _highlightBgColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = BaseColor_Cell_Backgound;
        [self createViews];
        [self layoutViews];
        self.bgColor = self.backgroundColor;
    }
    return self;
}

//供子类重写
- (void)createViews
{
    
}

//工资类重写
- (void)layoutViews
{
    
}

//重写系统的高亮setter
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (!_isHaveHighlightColor)
    {
        return;
    }
    UIColor *highColor = _highlightBgColor ? _highlightBgColor : _bgColor;
    self.backgroundColor = highlighted ? highColor : _bgColor;
}

#pragma mark - Lazy load
- (UIView *)bgView
{
    if (!_bgView)
    {
        self.bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

- (UIButton *)imgBtn
{
    if (!_imgBtn)
    {
        self.imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _imgBtn.layer.masksToBounds = YES;
    }
    return _imgBtn;
}

- (UIImageView *)imgView
{
    if (!_imgView)
    {
        self.imgView = [UIImageView new];
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        self.titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        //_titleLabel.textColor = BaseColor_Cell_TitleLabel_Text;
        _titleLabel.textColor = QF_BlackColor;
        _titleLabel.font = BaseFont_Cell_Title;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        self.contentLabel = [UILabel new];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = BaseColor_Cell_ContextLabel_Text;
        _contentLabel.font = BaseFont_Cell_Context;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        self.timeLabel = [UILabel new];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = BaseColor_Cell_TimeLabel_Text;
        _timeLabel.font = BaseFont_Cell_Time;
    }
    return _timeLabel;
}

#pragma mark - setter
//设置cell是否拥有选中背景
- (void)setIsHaveSeleBgView:(BOOL)isHaveSeleBgView
{
    if (_isHaveSeleBgView == isHaveSeleBgView)
    {
        return;
    }
    
    _isHaveSeleBgView = isHaveSeleBgView;
    if (isHaveSeleBgView)
    {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = BaseColor_Cell_SelectedBackground;
    }
    else
    {
        self.selectedBackgroundView = nil;
    }
}

//设置cell选中背景色
- (void)setSeleBgColor:(UIColor *)seleBgColor
{
    if (_seleBgColor == seleBgColor)
    {
        return;
    }
    
    //如果设置cell选中背景色 _isHaveSeleBgView直接设置为yes
    _isHaveSeleBgView = YES;
    _seleBgColor = seleBgColor;
    self.selectedBackgroundView.backgroundColor = seleBgColor;
}

- (void)setIsHaveHighlightColor:(BOOL)isHaveHighlightColor
{
    if (_isHaveHighlightColor == isHaveHighlightColor)
    {
        return;
    }
    
    _isHaveHighlightColor = isHaveHighlightColor;
    _highlightBgColor = isHaveHighlightColor ? BaseColor_Cell_SelectedBackground : nil;
}

- (void)setHighlightBgColor:(UIColor *)highlightBgColor
{
    if (_highlightBgColor == highlightBgColor)
    {
        return;
    }
    
    //如果设置cell高亮色 _isHaveHighlightColor直接设置为yes
    _isHaveHighlightColor = YES;
    _highlightBgColor = highlightBgColor;
}

+ (CGFloat)cellHeight
{
    return 100;
}

@end
