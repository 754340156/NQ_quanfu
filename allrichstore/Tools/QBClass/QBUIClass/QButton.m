//
//  QButton.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/8.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "QButton.h"

#define kHighlightedAlpha  0.6

@interface QButton()

@property (nonatomic, assign) CGFloat minWidth;
@property (nonatomic, assign) CGFloat minHeight;

@property (nonatomic, strong) UIImage *normalNormalImage;
@property (nonatomic, strong) UIImage *normalSelectedImage;
@property (nonatomic, strong) UIImage *selectedNormalImage;
@property (nonatomic, strong) UIImage *selectedSelectedImage;

@end

@implementation QButton

+ (instancetype)btnType:(UIButtonType)btnType
                  frame:(CGRect)frame
                  style:(QButtonStyle)style
            layoutStyle:(QButtonLayoutStyle)layoutStyle
                   font:(UIFont *)font
                  title:(NSString *)title
                  image:(UIImage *)image
                  space:(CGFloat)space
                 margin:(CGFloat)margin
               autoSize:(BOOL)autoSize
{
    QButton *qBtn = [QButton buttonWithType:btnType];
    qBtn.frame = frame;
    qBtn.style = style;
    qBtn.layoutStyle = layoutStyle;
    qBtn.space = space;
    qBtn.margin = margin;
    qBtn.autoSize = autoSize;
    
    qBtn.minWidth = frame.size.width;
    qBtn.minHeight = frame.size.height;
    
    //self.transparentWhenhighlight = YES;
    
    if (font)
    {
        qBtn.titleLabel.font = font;
    }
    
    if (image)
    {
        [qBtn setImage:image forState:UIControlStateNormal];
    }
    
    [qBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [qBtn setTitle:title forState:UIControlStateNormal];
    qBtn.normalBgColor = qBtn.backgroundColor;
    
    qBtn.normalBorderColor = [UIColor clearColor];
    qBtn.selectedBorderColor = [UIColor clearColor];
    
    [qBtn layoutOwnSubviews];  //布局UIbutton的子视图
    return qBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
                        style:(QButtonStyle)style
                  layoutStyle:(QButtonLayoutStyle)layoutStyle
                         font:(UIFont *)font
                        title:(NSString *)title
                        image:(UIImage *)image
                        space:(CGFloat)space
                       margin:(CGFloat)margin
                     autoSize:(BOOL)autoSize
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.style = style;
        self.layoutStyle = layoutStyle;
        self.space = space;
        self.margin = margin;
        self.autoSize = autoSize;
        
        self.minWidth = frame.size.width;
        self.minHeight = frame.size.height;
        
        //self.transparentWhenhighlight = YES;
        
        if (font)
        {
            self.titleLabel.font = font;
        }
        
        if (image)
        {
            [self setImage:image forState:UIControlStateNormal];
        }
        
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateNormal];
        self.normalBgColor = self.backgroundColor;
        
        self.normalBorderColor = [UIColor clearColor];
        self.selectedBorderColor = [UIColor clearColor];
        
        [self layoutOwnSubviews];  //布局UIbutton的子视图
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                        style:(QButtonStyle)style
                         font:(UIFont *)font
                        title:(NSString *)title
                        image:(UIImage *)image
                        space:(CGFloat)space
                     autoSize:(BOOL)autoSize
{
    return [self initWithFrame:frame style:style layoutStyle:QButtonLayoutStyleNone font:font title:title image:image space:space margin:0 autoSize:autoSize];
}

- (instancetype)initWithFrame:(CGRect)frame
                  layoutStyle:(QButtonLayoutStyle)layoutStyle
                         font:(UIFont *)font
                        title:(NSString *)title
                     autoSize:(BOOL)autoSize
{
    return [self initWithFrame:frame style:QButtonStyleNormal layoutStyle:layoutStyle font:font title:title image:nil space:0 margin:0 autoSize:autoSize];
}

//布局UIbutton的子视图
- (void)layoutOwnSubviews
{
    CGSize imageSize = self.currentImage.size;
    CGSize titleSize = [self.titleLabel getSize];
    
    CGFloat maxWidth = (imageSize.width > titleSize.width) ? imageSize.width : titleSize.width;
    
    CGFloat maxHeight = (imageSize.height > titleSize.height) ? imageSize.height : titleSize.height;
    
    CGRect tempFrame = self.frame;
    
    CGFloat autoWidth = self.frame.size.width;
    CGFloat autoHeight = self.frame.size.height;
    
    
    switch (self.style)
    {
        case QButtonStyleNormal:
        {
            switch (self.layoutStyle)
            {
                case QButtonLayoutStyleNone:
                {
                    self.minSize = CGSizeMake(imageSize.width + titleSize.width + _space, maxHeight);
                    if (_autoSize)
                    {
                        autoWidth = imageSize.width + titleSize.width + _space;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = maxHeight;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0,  _space / 2.0, 0, -_space / 2.0)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -_space / 2.0, 0, _space / 2.0)];
                }
                    break;
                case QButtonLayoutStyleLeft:
                {
                    self.minSize = CGSizeMake(imageSize.width + titleSize.width + _space + _margin, maxHeight);
                    if (_autoSize)
                    {
                        autoWidth = imageSize.width + titleSize.width + _space + _margin;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = maxHeight;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetX =  (autoWidth - titleSize.width - imageSize.width) / 2.0 - _margin;
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0,  -offsetX + _space, 0,  offsetX - _space)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -offsetX, 0, offsetX)];
                }
                    break;
                case QButtonLayoutStyleRight:
                {
                    self.minSize = CGSizeMake(imageSize.width + titleSize.width + _space + _margin, maxHeight);
                    if (_autoSize)
                    {
                        autoWidth = imageSize.width + titleSize.width + _space + _margin;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = maxHeight;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetX = - ((autoWidth - titleSize.width - imageSize.width) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -offsetX, 0, offsetX)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -offsetX - _space, 0, offsetX + _space)];
                }
                    break;
                case QButtonLayoutStyleTop:
                {
                    self.minSize = CGSizeMake(imageSize.width + titleSize.width + _space, maxHeight + _margin);
                    if (_autoSize)
                    {
                        autoWidth = imageSize.width + titleSize.width + _space;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = maxHeight + _margin;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetY = (autoHeight - maxHeight) / 2.0 - _margin;
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(-offsetY , _space / 2.0, offsetY,  -_space / 2.0)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(-offsetY,  -_space / 2.0, offsetY, _space / 2.0)];
                }
                    break;
                case QButtonLayoutStyleBottom:
                {
                    self.minSize = CGSizeMake(imageSize.width + titleSize.width + _space, maxHeight + _margin);
                    if (_autoSize)
                    {
                        autoWidth = imageSize.width + titleSize.width + _space;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = maxHeight + _margin;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetY = -((autoHeight - maxHeight) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(-offsetY , _space / 2.0, offsetY,  -_space / 2.0)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(-offsetY,  -_space / 2.0, offsetY, _space / 2.0)];
                }
                    break;
            }
        }
            break;
        case QButtonStyleImageRight:
        {
            switch (self.layoutStyle)
            {
                case QButtonLayoutStyleNone:
                {
                    self.minSize = CGSizeMake(imageSize.width + titleSize.width + _space, maxHeight);
                    if (_autoSize)
                    {
                        autoWidth = imageSize.width + titleSize.width + _space;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = maxHeight;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width - _space / 2.0, 0, imageSize.width + _space / 2.0)];
                    
                    CGFloat titleLabelWidth = ceil(titleSize.width);
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleLabelWidth + _space / 2.0, -0, -titleLabelWidth - _space / 2.0)];
                }
                    break;
                case QButtonLayoutStyleLeft:
                {
                    self.minSize = CGSizeMake(imageSize.width + titleSize.width + _space + _margin, maxHeight);
                    if (_autoSize)
                    {
                        autoWidth = imageSize.width + titleSize.width + _space + _margin;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = maxHeight;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetX = ((autoWidth - titleSize.width - imageSize.width) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width - offsetX, 0, imageSize.width + offsetX)];
                    
                    CGFloat titleLabelWidth = ceil(titleSize.width);
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleLabelWidth - offsetX + _space, 0, -titleLabelWidth + offsetX - _space)];
                }
                    break;
                case QButtonLayoutStyleRight:
                {
                    self.minSize = CGSizeMake(imageSize.width + titleSize.width + _space + _margin, maxHeight);
                    if (_autoSize)
                    {
                        autoWidth = imageSize.width + titleSize.width + _space + _margin;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = maxHeight;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetX = -((autoWidth - titleSize.width - imageSize.width) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width - offsetX - _space, 0, imageSize.width + offsetX + _space)];
                    
                    CGFloat titleLabelWidth = ceil(titleSize.width);
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleLabelWidth - offsetX, 0, -titleLabelWidth + offsetX)];
                }
                    break;
                case QButtonLayoutStyleTop:
                {
                    self.minSize = CGSizeMake(imageSize.width + titleSize.width + _space, maxHeight + _margin);
                    if (_autoSize)
                    {
                        autoWidth = imageSize.width + titleSize.width + _space;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = maxHeight + _margin;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetY = (autoHeight - maxHeight) / 2.0 - _margin;
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(-offsetY, -imageSize.width - _space / 2.0, offsetY, imageSize.width + _space / 2.0)];
                    
                    CGFloat titleLabelWidth = ceil(titleSize.width);
                    [self setImageEdgeInsets:UIEdgeInsetsMake(-offsetY, titleLabelWidth + _space / 2.0, offsetY, -titleLabelWidth - _space / 2.0)];
                }
                    break;
                case QButtonLayoutStyleBottom:
                {
                    self.minSize = CGSizeMake(imageSize.width + titleSize.width + _space, maxHeight + _margin);
                    if (_autoSize)
                    {
                        autoWidth = imageSize.width + titleSize.width + _space;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = maxHeight;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight + _margin;
                        }
                    }
                    
                    CGFloat offsetY = -((autoHeight - maxHeight) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(-offsetY, -imageSize.width - _space / 2.0, offsetY, imageSize.width + _space / 2.0)];
                    
                    CGFloat titleLabelWidth = ceil(titleSize.width);
                    [self setImageEdgeInsets:UIEdgeInsetsMake(-offsetY, titleLabelWidth + _space / 2.0, offsetY, - titleLabelWidth - _space / 2.0)];
                }
                    break;
            }
        }
            break;
            
        case QButtonStyleImageTop:
        {
            switch (self.layoutStyle)
            {
                case QButtonLayoutStyleNone:
                {
                    self.minSize = CGSizeMake(autoWidth, titleSize.height + titleSize.height + _space);
                    if (_autoSize)
                    {
                        autoWidth = maxWidth;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = titleSize.height + titleSize.height + _space;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake((imageSize.height + _space) / 2.0, -imageSize.width / 2.0, -(imageSize.height + _space) / 2.0, imageSize.width / 2.0)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(-(titleSize.height + _space) / 2.0, titleSize.width / 2.0, (titleSize.height + _space) / 2.0, -titleSize.width / 2.0)];
                }
                    break;
                case QButtonLayoutStyleLeft:
                {
                    if (_autoSize)
                    {
                        autoWidth = maxWidth + _margin;
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        autoHeight = titleSize.height + titleSize.height + _space;
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetX =  (self.width - maxWidth) / 2.0 - _margin;
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake((imageSize.height + _space) / 2.0, -imageSize.width / 2.0 - offsetX, -(imageSize.height + _space) / 2.0, imageSize.width / 2.0 + offsetX)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(-(titleSize.height + _space) / 2.0, titleSize.width / 2.0 - offsetX, (titleSize.height + _space) / 2.0, -titleSize.width / 2.0 + offsetX)];
                }
                    break;
                case QButtonLayoutStyleRight:
                {
                    autoWidth = maxWidth + _margin;
                    autoHeight = titleSize.height + titleSize.height + _space;
                    self.minSize = CGSizeMake(autoWidth, autoHeight);
                    if (_autoSize)
                    {
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetX = -((self.width - maxWidth) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake((imageSize.height + _space) / 2.0, -imageSize.width / 2.0 - offsetX, -(imageSize.height + _space) / 2.0, imageSize.width / 2.0 + offsetX)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(-(titleSize.height + _space) / 2.0, titleSize.width / 2.0 - offsetX, (titleSize.height + _space) / 2.0, -titleSize.width / 2.0 + offsetX)];
                }
                    break;
                case QButtonLayoutStyleTop:
                {
                    autoWidth = maxWidth;
                    autoHeight = titleSize.height + titleSize.height + _space + _margin;
                    self.minSize = CGSizeMake(autoWidth, autoHeight);
                    if (_autoSize)
                    {
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetY = ((autoHeight - titleSize.height - imageSize.height) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake((imageSize.height) / 2.0 - offsetY + _space, -imageSize.width / 2.0, -(imageSize.height) / 2.0 + offsetY - _space, imageSize.width / 2.0)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(-titleSize.height / 2.0 - offsetY, titleSize.width / 2.0, titleSize.height / 2.0 + offsetY, -titleSize.width / 2.0)];
                }
                    break;
                case QButtonLayoutStyleBottom:
                {
                    autoWidth = maxWidth;
                    autoHeight = titleSize.height + titleSize.height + _space + _margin;
                    self.minSize = CGSizeMake(autoWidth, autoHeight);
                    if (_autoSize)
                    {
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetY = -((self.height - titleSize.height - imageSize.height) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height / 2.0 - offsetY, -imageSize.width / 2.0, -imageSize.height / 2.0  + offsetY, imageSize.width / 2.0)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(-titleSize.height / 2.0 - offsetY - _space, titleSize.width / 2.0, titleSize.height / 2.0 + offsetY + _space, -titleSize.width / 2.0)];
                }
                    break;
            }
        }
            break;
            
        case QButtonStyleImageBottom:
        {
            switch (self.layoutStyle)
            {
                case QButtonLayoutStyleNone:
                {
                    autoWidth = maxWidth;
                    autoHeight = titleSize.height + titleSize.height + _space;
                    self.minSize = CGSizeMake(autoWidth, autoHeight);
                    if (_autoSize)
                    {
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(-(imageSize.height + _space) / 2.0, -imageSize.width / 2.0, (imageSize.height + _space) / 2.0, imageSize.width / 2.0)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake((titleSize.height + _space) / 2.0, titleSize.width / 2.0, -(titleSize.height + _space) / 2.0, -titleSize.width / 2.0)];
                }
                    break;
                case QButtonLayoutStyleLeft:
                {
                    autoWidth = maxWidth + _margin;
                    autoHeight = titleSize.height + titleSize.height + _space;
                    self.minSize = CGSizeMake(autoWidth, autoHeight);
                    if (_autoSize)
                    {
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetX =  (self.width - maxWidth) / 2.0 - _margin;
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(-(imageSize.height + _space) / 2.0, -imageSize.width / 2.0 - offsetX, (imageSize.height + _space) / 2.0, imageSize.width / 2.0 + offsetX)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake((titleSize.height + _space) / 2.0, titleSize.width / 2.0 - offsetX, -(titleSize.height + _space) / 2.0, -titleSize.width / 2.0 + offsetX)];
                }
                    break;
                case QButtonLayoutStyleRight:
                {
                    autoWidth = maxWidth + _margin;
                    autoHeight = titleSize.height + titleSize.height + _space;
                    self.minSize = CGSizeMake(autoWidth, autoHeight);
                    if (_autoSize)
                    {
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetX = -((self.width - maxWidth) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(-(imageSize.height + _space) / 2.0, -imageSize.width / 2.0 - offsetX, (imageSize.height + _space) / 2.0, imageSize.width / 2.0 + offsetX)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake((titleSize.height + _space) / 2.0, titleSize.width / 2.0 - offsetX, -(titleSize.height + _space) / 2.0, -titleSize.width / 2.0 + offsetX)];
                }
                    break;
                case QButtonLayoutStyleTop:
                {
                    autoWidth = maxWidth;
                    autoHeight = titleSize.height + titleSize.height + _space +_margin;
                    self.minSize = CGSizeMake(autoWidth, autoHeight);
                    if (_autoSize)
                    {
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetY = ((autoHeight - titleSize.height - imageSize.height) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(-(imageSize.height) / 2.0 - offsetY, -imageSize.width / 2.0, (imageSize.height) / 2.0 + offsetY, imageSize.width / 2.0)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(titleSize.height / 2.0 - offsetY + _space, titleSize.width / 2.0, -titleSize.height / 2.0 + offsetY - _space, -titleSize.width / 2.0)];
                }
                    break;
                case QButtonLayoutStyleBottom:
                {
                    autoWidth = maxWidth;
                    autoHeight = titleSize.height + titleSize.height + _space +_margin;
                    self.minSize = CGSizeMake(autoWidth, autoHeight);
                    if (_autoSize)
                    {
                        if (_minWidth > autoWidth)
                        {
                            autoWidth = _minWidth;
                        }
                        
                        if (_minHeight > autoHeight)
                        {
                            autoHeight = _minHeight;
                        }
                    }
                    
                    CGFloat offsetY = -((autoHeight - titleSize.height - imageSize.height) / 2.0 - _margin);
                    
                    [self setTitleEdgeInsets:UIEdgeInsetsMake(-(imageSize.height) / 2.0 - offsetY, -imageSize.width / 2.0, (imageSize.height) / 2.0 + offsetY, imageSize.width / 2.0)];
                    
                    [self setImageEdgeInsets:UIEdgeInsetsMake(titleSize.height / 2.0 - offsetY + _space, titleSize.width / 2.0, -titleSize.height / 2.0 + offsetY - _space, -titleSize.width / 2.0)];
                }
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    if (_autoSize)
    {
        tempFrame.size = CGSizeMake(ceilf(autoWidth), ceilf(autoHeight));
        
        self.frame = tempFrame;
    }
}

#pragma mark - Override
- (void)setStyle:(QButtonStyle)style
{
    if (style == _style)
    {
        return;
    }
    
    _style = style;
    [self layoutOwnSubviews];
}

- (void)setLayoutStyle:(QButtonLayoutStyle)layoutStyle
{
    if (layoutStyle == _layoutStyle)
    {
        return;
    }
    
    _layoutStyle = layoutStyle;
    [self layoutOwnSubviews];
}

- (void)setMargin:(CGFloat)margin
{
    if (margin == _margin)
    {
        return;
    }
    
    _margin = margin;
    [self layoutOwnSubviews];
}

- (void)setSpace:(CGFloat)space
{
    if (space == _space)
    {
        return;
    }
    
    _space = space;
    [self layoutOwnSubviews];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self layoutOwnSubviews];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    [super setTitleColor:color forState:state];
    if (state == UIControlStateNormal)
    {
        UIColor *highLightedColor = [color colorWithAlphaComponent:kHighlightedAlpha];
        [self setTitleColor:highLightedColor forState:UIControlStateHighlighted];
    }
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    if (self.buttonType == UIButtonTypeSystem)
    {
        image = [image imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    }
    [super setImage:image forState:state];
    if (state == UIControlStateNormal)
    {
        [self setImage:[image imageWithAlpha:kHighlightedAlpha] forState:UIControlStateHighlighted];
    }
    [self layoutOwnSubviews];
}

//高亮半透明效果
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutOwnSubviews];
}


#pragma mark - Setter
- (void)setQbSelected:(BOOL)qbSelected
{
    if (_qbSelected == qbSelected)
    {
        return;
    }
    
    _qbSelected = qbSelected;
    
    if (!_qbSelected)
    {
        if (self.state == UIControlStateNormal)
        {
            [self setImage:_normalNormalImage forState:UIControlStateNormal];
        }
        else
        {
            [self setImage:_selectedNormalImage forState:UIControlStateSelected];
        }
    }
    else
    {
        if (self.state == UIControlStateNormal)
        {
            [self setImage:_normalSelectedImage forState:UIControlStateNormal];
        }
        else
        {
            [self setImage:_selectedSelectedImage forState:UIControlStateSelected];
        }
    }
}



- (void)setImage:(UIImage *)image forQButtonState:(QButtonState)state
{
    switch (state)
    {
        case QButtonNormalStateNormal:
        {
            _normalNormalImage = image;
        }
            break;
        case QButtonNormalStateSelected:
        {
            _normalSelectedImage = image;
        }
            break;
        case QButtonSelectedStateNormal:
        {
            _selectedNormalImage = image;
        }
            break;
        case QButtonSelectedStateSelected:
        {
            _selectedSelectedImage = image;
        }
            break;
        default:
            break;
    }
    
    if (!_qbSelected)
    {
        if (self.state == UIControlStateNormal)
        {
            [self setImage:_normalNormalImage forState:UIControlStateNormal];
        }
        else
        {
            [self setImage:_selectedNormalImage forState:UIControlStateSelected];
        }
    }
    else
    {
        if (self.state == UIControlStateNormal)
        {
            [self setImage:_normalSelectedImage forState:UIControlStateNormal];
        }
        else
        {
            [self setImage:_selectedSelectedImage forState:UIControlStateSelected];
        }
    }
}

- (void)setNormalBgColor:(UIColor *)normalBgColor
{
    if (!normalBgColor)
    {
        return;
    }
    _normalBgColor = normalBgColor;
    self.backgroundColor = normalBgColor;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected == YES)
    {
        UIImage *selectedImage = nil;
        if (!_qbSelected)
        {
            selectedImage = _selectedNormalImage;
        }
        else
        {
            selectedImage = _selectedSelectedImage;
        }
        
        if (selectedImage)
        {
            [self setImage:selectedImage forState:UIControlStateSelected];
        }
        
        self.backgroundColor = _selectedBgColor;
        self.layer.borderColor = _selectedBorderColor.CGColor;
    }
    else
    {
        UIImage *normalImage = nil;
        if (!_qbSelected)
        {
            normalImage = _normalNormalImage;
        }
        else
        {
            normalImage = _normalSelectedImage;
        }
        
        if (normalImage)
        {
            [self setImage:normalImage forState:UIControlStateNormal];
        }
        
        self.backgroundColor = _normalBgColor;
        self.layer.borderColor = _normalBorderColor.CGColor;
    }
}

- (void)setNormalBorderColor:(UIColor *)normalBorderColor
{
    if (normalBorderColor == nil)
    {
        return;
    }
    _normalBorderColor = normalBorderColor;
    if (self.state != UIControlStateSelected)
    {
        self.layer.borderColor = _normalBorderColor.CGColor;
    }
}

- (void)setSelectedBorderColor:(UIColor *)selectedBorderColor
{
    if (selectedBorderColor == nil)
    {
        return;
    }
    _selectedBorderColor = selectedBorderColor;
    if (self.state == UIControlStateSelected)
    {
        self.layer.borderColor = _selectedBorderColor.CGColor;
    }
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    if (self.currentImage)
    {
        [self setImage:[self.currentImage imageWithTintColor:highlightColor] forState:UIControlStateHighlighted];
    }
    
    [self setTitleColor:highlightColor forState:UIControlStateHighlighted];
}

//- (void)setImage:(UIImage *)image forState:(UIControlState)state
//{
//
//    if (state == UIControlStateSelected)
//    {
//        if (_qbSelected == QButtonSelectedStateNormal)
//        {
//            self.selectedNormalImage = image;
//        }
//        else if (_qbSelected == QButtonSelectedStateSelected)
//        {
//            self.selectedSelectedImage = image;
//        }
//
//    }
//}

@end
