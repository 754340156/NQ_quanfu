//
//  BaseTableViewCell.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/21.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "BaseTableViewCell.h"

#define kCellBottomLine_Height 0.7

@interface BaseTableViewCell()

@property (nonatomic, strong) UIColor *bgColor;

@end

@implementation BaseTableViewCell
@synthesize imgBtn = _imgBtn, imgView = _imgView, titleLabel = _titleLabel, contentLabel = _contentLabel, stateLabel = _stateLabel,timeLabel = _timeLabel, isHaveHighlightColor = _isHaveHighlightColor,  highlightBgColor = _highlightBgColor, isEditState = _isEditState;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BaseColor_Cell_Backgound;
        self.isHaveSeleBgView = YES;
        
        [self createViews];
        [self layoutViews];
        
        self.bgColor = self.contentView.backgroundColor;
        if (_bgColor == [UIColor clearColor])
        {
            self.bgColor = self.backgroundColor;
        }
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

+ (CGFloat)cellHeight
{
    return 60;
}

#pragma mark - Lazy load
- (UIButton *)imgBtn
{
    if (!_imgBtn)
    {
        self.imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _imgBtn.userInteractionEnabled = NO;
        _imgBtn.layer.masksToBounds = YES;
    }
    return _imgBtn;
}

- (UIImageView *)imgView
{
    if (!_imgView)
    {
        self.imgView = [UIImageView new];
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

- (UILabel *)stateLabel
{
    if (!_stateLabel)
    {
        self.stateLabel = [UILabel new];
        _stateLabel.textColor = [UIColor lightGrayColor];
        _stateLabel.font = AdaptedFont(13);
        _stateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stateLabel;
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

- (UIView *)bottomLineView
{
    if (!_bottomLineView)
    {
        self.bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = BaseColor_Cell_SplitLine;
        [self addSubview:_bottomLineView];
    }
    return _bottomLineView;
}

#pragma mark - setter
- (void)setBottomMargin:(CGFloat)bottomMargin
{
    _bottomMargin = bottomMargin;
    _bottomLeftMargin = bottomMargin;
    _bottomRightMargin = bottomMargin;
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(_bottomLeftMargin);
        make.right.offset(-_bottomRightMargin);
        make.bottom.offset(0);
        make.height.offset(kCellBottomLine_Height);
        
    }];
    _bottomHeight = kCellBottomLine_Height;
}

- (void)setBottomLeftMargin:(CGFloat)bottomLeftMargin
{
    _bottomLeftMargin = bottomLeftMargin;
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(_bottomLeftMargin);
        make.right.offset(-_bottomRightMargin);
        make.bottom.offset(0);
        make.height.offset(kCellBottomLine_Height);
        
    }];
    _bottomHeight = kCellBottomLine_Height;
}

- (void)setBottomRightMargin:(CGFloat)bottomRightMargin
{
    _bottomRightMargin = bottomRightMargin;
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(_bottomLeftMargin);
        make.right.offset(-_bottomRightMargin);
        make.bottom.offset(0);
        make.height.offset(kCellBottomLine_Height);
        
    }];
    _bottomHeight = kCellBottomLine_Height;
}

- (void)setBottomHeight:(CGFloat)bottomHeight
{
    _bottomHeight = bottomHeight;
    [self.bottomLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(_bottomLeftMargin);
        make.right.offset(-_bottomRightMargin);
        make.bottom.offset(0);
        make.height.offset(bottomHeight);
        
    }];
}


#pragma mark - setter
//设置cell是否拥有选中背景
- (void)setIsHaveSeleBgView:(BOOL)isHaveSeleBgView
{
    _isHaveSeleBgView = isHaveSeleBgView;
    if (isHaveSeleBgView)
    {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = BaseColor_Cell_SelectedBackground;
    }
    else
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
    self.isHaveSeleBgView = YES;
    _seleBgColor = seleBgColor;
    self.selectedBackgroundView.backgroundColor = seleBgColor;
}

//设置cell是否拥有高亮选中背景色
- (void)setIsHaveHighlightColor:(BOOL)isHaveHighlightColor
{
    if (_isHaveHighlightColor == isHaveHighlightColor)
    {
        return;
    }
    
    _isHaveHighlightColor = isHaveHighlightColor;
    _highlightBgColor = isHaveHighlightColor ? BaseColor_Cell_SelectedBackground : nil;
}

//设置cell高亮展示时的背景颜色
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

//设置编辑状态
- (void)setIsEditState:(BOOL)isEditState
{
    
    if (_isEditState != isEditState)
    {
        _isEditState = isEditState;
        [self layoutViews];
    }
}

@end
