//
//  ButtonsView.m
//  AmapRoutePlanning
//
//  Created by 任强宾 on 16/5/6.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "ButtonsView.h"

#define kSplitViewDefaultColor [UIColor colorWithWhite:0.90 alpha:1.0]

@interface ButtonsView ()

@property (nonatomic, strong) UIImageView *bottomLineView;
@property (nonatomic, strong) UIButton *lastBtn;

@end

#define AnimateDuration 0.15

@implementation ButtonsView

#pragma mark - Custom Method
//自定义 标题型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addEffectView];   //添加毛玻璃
        self.isRepeatTouch = NO;
        
        //循环创建buttons
        NSInteger count = btnTitles.count;
        _btnCount = count;
        CGFloat btnWidth = frame.size.width / count;
        _btnWidth = btnWidth;
        for (int i = 0; i < count; i++)
        {
            QButton *btn = [QButton buttonWithType:UIButtonTypeSystem];
            [self.btns addObject:btn];
            btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, self.frame.size.height);
            [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
            btn.tag = 101 + i;
            [btn addTarget:self action:@selector(handleTitleBtnNoSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}

//自定义 标题型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles
                   titleColor:(UIColor *)titleColor
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addEffectView];   //添加毛玻璃
        self.isRepeatTouch = NO;
        
        //循环创建buttons
        NSInteger count = btnTitles.count;
        _btnCount = count;
        CGFloat btnWidth = frame.size.width / count;
        _btnWidth = btnWidth;
        for (int i = 0; i < count; i++)
        {
            QButton *btn = [QButton buttonWithType:UIButtonTypeSystem];
            [self.btns addObject:btn];
            btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, self.frame.size.height);
            [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
            btn.tag = 101 + i;
            [btn addTarget:self action:@selector(handleTitleBtnNoSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}

//自定义 标题型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles
                   titleColor:(UIColor *)titleColor
                selectedColor:(UIColor *)seletedColor
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addEffectView];   //添加毛玻璃
        self.isRepeatTouch = NO;
        
        //循环创建buttons
        NSInteger count = btnTitles.count;
        _btnCount = count;
        CGFloat btnWidth = frame.size.width / count;
        _btnWidth = btnWidth;
        for (int i = 0; i < count; i++)
        {
            QButton *btn = [QButton buttonWithType:UIButtonTypeCustom];
            [self.btns addObject:btn];
            btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, self.frame.size.height);
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
            
            [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
            //[btn setTitleColor:seletedColor forState:UIControlStateHighlighted];
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
            [btn setTitleColor:seletedColor forState:UIControlStateSelected];
            btn.tag = 101 + i;
            [btn addTarget:self action:@selector(handleTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            if (i == 0)
            {
                btn.selected = YES;
                self.lastBtn = btn;
            }
            else
            {
                btn.selected = NO;
            }
        }
    }
    return self;
}

//自定义 标题型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles
                   titleColor:(UIColor *)titleColor
                selectedColor:(UIColor *)seletedColor
                    titleFont:(UIFont *)titleFont
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addEffectView];   //添加毛玻璃
        self.isRepeatTouch = NO;
        
        //循环创建buttons
        NSInteger count = btnTitles.count;
        _btnCount = count;
        CGFloat btnWidth = frame.size.width / count;
        _btnWidth = btnWidth;
        for (int i = 0; i < count; i++)
        {
            QButton *btn = [QButton buttonWithType:UIButtonTypeCustom];
            [self.btns addObject:btn];
            btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, self.frame.size.height);
            [btn.titleLabel setFont:titleFont];
            
            [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
            //[btn setTitleColor:seletedColor forState:UIControlStateHighlighted];
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
            [btn setTitleColor:seletedColor forState:UIControlStateSelected];
            btn.tag = 101 + i;
            [btn addTarget:self action:@selector(handleTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            if (i == 0)
            {
                btn.selected = YES;
                self.lastBtn = btn;
            }
            else
            {
                btn.selected = NO;
            }
        }
    }
    return self;
}

//自定义 图标型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                 normalImages:(NSArray *)normalImages
                   imageWidth:(CGFloat)imageWidth
                  imageHeight:(CGFloat)imageHeight
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addEffectView];   //添加毛玻璃
        self.isRepeatTouch = NO;
        
        //循环创建buttons
        NSInteger count = normalImages.count;
        _btnCount = count;
        CGFloat btnWidth = frame.size.width / count;
        _btnWidth = btnWidth;
        CGFloat selfHeight = frame.size.height;
        for (int i = 0; i < count; i++)
        {
            QButton *btn = [QButton buttonWithType:UIButtonTypeCustom];
            [self.btns addObject:btn];
            btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, selfHeight);
            [btn setImage:normalImages[i] forState:UIControlStateNormal];
            
            btn.imageEdgeInsets = UIEdgeInsetsMake((selfHeight - imageHeight) / 2.0, (btnWidth - imageWidth) / 2.0, (selfHeight - imageHeight) / 2.0, (btnWidth - imageWidth) / 2.0);
            btn.tag = 101 + i;
            [btn addTarget:self action:@selector(handleNormalImageBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            if (i == 0)
            {
                btn.selected = YES;
                self.lastBtn = btn;
            }
            else
            {
                btn.selected = NO;
            }
        }
    }
    return self;
}

//自定义 图片型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                 normalImages:(NSArray *)normalImages
               selectedImages:(NSArray *)selectedImages
                   imageWidth:(CGFloat)imageWidth
                  imageHeight:(CGFloat)imageHeight
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addEffectView];   //添加毛玻璃
        self.isRepeatTouch = NO;
        
        //循环创建buttons
        NSInteger count = normalImages.count;
        _btnCount = count;
        CGFloat btnWidth = frame.size.width / count;
        _btnWidth = btnWidth;
        CGFloat selfHeight = frame.size.height;
        for (int i = 0; i < count; i++)
        {
            QButton *btn = [QButton buttonWithType:UIButtonTypeCustom];
            [self.btns addObject:btn];
            btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, selfHeight);
            [btn setImage:normalImages[i] forState:UIControlStateNormal];
            [btn setImage:selectedImages[i] forState:UIControlStateSelected];
            btn.imageEdgeInsets = UIEdgeInsetsMake((selfHeight - imageHeight) / 2.0, (btnWidth - imageWidth) / 2.0, (selfHeight - imageHeight) / 2.0, (btnWidth - imageWidth) / 2.0);
            btn.tag = 101 + i;
            [btn addTarget:self action:@selector(handleImageBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0)
            {
                btn.selected = YES;
                self.lastBtn = btn;
            }
            else
            {
                btn.selected = NO;
            }
            [self addSubview:btn];
        }
    }
    return self;
}


#pragma mark - 带标题和图标
//自定义 标题和图标型按钮 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles
                   titleColor:(UIColor *)titleColor
                 normalImages:(NSArray *)normalImages
                        style:(QButtonStyle)style
                        space:(CGFloat)space
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addEffectView];   //添加毛玻璃
        self.isRepeatTouch = NO;
        
        //循环创建buttons
        NSInteger count = normalImages.count;
        _btnCount = count;
        CGFloat btnWidth = frame.size.width / count;
        _btnWidth = btnWidth;
        CGFloat selfHeight = frame.size.height;
        for (int i = 0; i < count; i++)
        {
            QButton *btn = [[QButton alloc] initWithFrame:CGRectMake(i * btnWidth, 0, btnWidth, selfHeight) style:style layoutStyle:QButtonLayoutStyleNone font:[UIFont systemFontOfSize:11] title:btnTitles[i] image:[UIImage imageNamed:normalImages[i]] space:space margin:0 autoSize:NO];
            
            [self.btns addObject:btn];
            
            [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
            [btn setImage:normalImages[i] forState:UIControlStateNormal];
            btn.tag = 101 + i;
            [btn addTarget:self action:@selector(handleNormalImageBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0)
            {
                btn.selected = YES;
                self.lastBtn = btn;
            }
            else
            {
                btn.selected = NO;
            }
            [self addSubview:btn];
        }
    }
    return self;
}

//自定义 图标型按钮（单选中） 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                    btnTitles:(NSArray *)btnTitles
                   titleColor:(UIColor *)titleColor
                selectedColor:(UIColor *)seletedColor
                 normalImages:(NSArray *)normalImages
               selectedImages:(NSArray *)selectedImages
                        style:(QButtonStyle)style
                        space:(CGFloat)space
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addEffectView];   //添加毛玻璃
        self.isRepeatTouch = NO;
        
        //循环创建buttons
        NSInteger count = normalImages.count;
        _btnCount = count;
        CGFloat btnWidth = frame.size.width / count;
        _btnWidth = btnWidth;
        CGFloat selfHeight = frame.size.height;
        for (int i = 0; i < count; i++)
        {
            QButton *btn = [[QButton alloc] initWithFrame:CGRectMake(i * btnWidth, 0, btnWidth, selfHeight) style:style layoutStyle:QButtonLayoutStyleNone font:[UIFont systemFontOfSize:11] title:btnTitles[i] image:normalImages[i] space:space margin:0 autoSize:NO];
            [self.btns addObject:btn];
            
            [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
            [btn setTitleColor:titleColor forState:UIControlStateNormal];
            [btn setTitleColor:seletedColor forState:UIControlStateSelected];
            [btn setImage:normalImages[i] forState:UIControlStateNormal];
            [btn setImage:selectedImages[i] forState:UIControlStateSelected];
            
            btn.tag = 101 + i;
            [btn addTarget:self action:@selector(handleImageBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0)
            {
                btn.selected = YES;
                self.lastBtn = btn;
            }
            else
            {
                btn.selected = NO;
            }
            [self addSubview:btn];
        }
    }
    return self;
}

//添加毛玻璃效果
- (void)addEffectView
{
    //创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    //毛玻璃view 视图
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    _effectView.frame = self.bounds;
    //设置模糊透明度
    _effectView.alpha = 0.0f;
    [self addSubview:_effectView];
}

#pragma mark - lazy load
- (NSMutableArray *)btns
{
    if (!_btns)
    {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (UIImageView *)bottomLineView
{
    if (!_bottomLineView)
    {
        self.bottomLineView = [[UIImageView alloc] init];
    }
    return _bottomLineView;
}



#pragma mark - Handle Action
- (void)handleTitleBtnNoSelected:(UIButton *)sender
{
    [self.delegate btsView:self IsClicked:sender atIndex:sender.tag - 101 isRepeatTouch:NO];
}

- (void)handleTitleBtn:(UIButton *)sender
{
    [self selectBtn:sender];
    [self.delegate btsView:self IsClicked:sender atIndex:sender.tag - 101 isRepeatTouch:self.isRepeatTouch];
}

- (void)selectBtn:(UIButton *)sender
{
    self.isRepeatTouch = (self.lastBtn == sender);
    sender.selected = !sender.selected;
    for (int i = 101; i < 101 + _btnCount; i++)
    {
        UIButton *btn = [self viewWithTag:i];
        btn.selected = (sender == btn) ? YES : NO;
    }
    
    self.lastBtn = sender;
    
    if (!_bottomLineView)
    {
        return;
    }
    [UIView animateWithDuration:AnimateDuration animations:^{
        
        if (self.isFullWidth)
        {
            CGRect frame = _bottomLineView.frame;
            frame.origin.x = sender.left;
            _bottomLineView.frame = frame;
        }
        else
        {
            _bottomLineView.frame = [self getSlideFrameUnderBtn:sender];
        }
    }];
}

//根据按钮，计算按钮下边的滑条的frame
- (CGRect)getSlideFrameUnderBtn:(UIButton *)btn
{
    CGRect frame = _bottomLineView.frame;
    
    CGFloat titleWidth = [btn.titleLabel getWidth];
    BOOL addWidth = btn.width * 3 / 4.0 > titleWidth;
    frame.size.width = titleWidth + (addWidth ? 16 : 0);
    frame.origin.x = btn.left + (btn.width - frame.size.width) / 2.0;
    return frame;
}

- (void)handleNormalImageBtn:(UIButton *)sender
{
    self.isRepeatTouch = (self.lastBtn == sender);
    [self.delegate btsView:self IsClicked:sender atIndex:sender.tag - 101 isRepeatTouch:self.isRepeatTouch];
    self.lastBtn = sender;
    
    UIView *slideView = [self viewWithTag:1001];
    if (!slideView)
    {
        return;
    }
    [UIView animateWithDuration:0.15 animations:^{
        CGRect frame = slideView.frame;
        frame.origin.x = (sender.tag - 101) * _btnWidth;
        slideView.frame = frame;
    }];
}

- (void)handleImageBtn:(UIButton *)sender
{
    [self selectBtn:sender];
    self.isRepeatTouch = (self.lastBtn == sender);
    [self.delegate btsView:self IsClicked:sender atIndex:sender.tag - 101 isRepeatTouch:self.isRepeatTouch];
    self.lastBtn = sender;
    
    UIView *slideView = [self viewWithTag:1001];
    if (!slideView)
    {
        return;
    }
    
    for (int i = 0; i < _btnCount; i++)
    {
        UIButton *button = [self viewWithTag:i + 101];
        button.selected = NO;
    }
    
    sender.selected = YES;
    [UIView animateWithDuration:0.15 animations:^{
        CGRect frame = slideView.frame;
        frame.origin.x = (sender.tag - 101) * _btnWidth;
        slideView.frame = frame;
    }];
}

#pragma mark - Override Method
//设置图片
- (void)setSliderImage:(UIImage *)sliderImage
{
    self.bottomLineView.image = sliderImage;
}

//设置底部滑动条高度
- (void)setSlideBarHeight:(CGFloat)slideBarHeight
{
    if (_slideBarHeight == slideBarHeight)
    {
        return;
    }
    _slideBarHeight = slideBarHeight;
    
    if (slideBarHeight > 0)
    {
        self.bottomLineView.frame = CGRectMake(0, self.frame.size.height - slideBarHeight, self.frame.size.width / _btnCount, slideBarHeight);
        
        //默认颜色是透明色
        _bottomLineView.backgroundColor = _slideBarColor ? _slideBarColor :[UIColor clearColor];
        _bottomLineView.tag = 1001;
        [self addSubview:_bottomLineView];
    }
}

//设置底部滑动条的宽度
- (void)setSlideBarWidth:(CGFloat)slideBarWidth
{
    if (_slideBarWidth == slideBarWidth)
    {
        return;
    }
    _slideBarWidth = slideBarWidth;
    
    
    if (slideBarWidth > 0)
    {
        //高度默认：3.0
        
        CGFloat slideWidth = (slideBarWidth < self.frame.size.width / _btnCount) ? slideBarWidth : self.frame.size.width / _btnCount;
        
        self.bottomLineView.frame = CGRectMake((self.frame.size.width / _btnCount - slideWidth) / 2.0, self.frame.size.height - 3.0, slideWidth, 3.0);
        //默认颜色是透明色
        _bottomLineView.backgroundColor = _slideBarColor ? _slideBarColor :[UIColor clearColor];
        _bottomLineView.tag = 1001;
        [self addSubview:_bottomLineView];
    }
}

- (void)setBtnTintColor:(UIColor *)btnTintColor
{
    _btnTintColor = btnTintColor;
    for (int i = 0; i < _btnCount; i++)
    {
        UIButton *button = [self viewWithTag:i + 101];
        [button setTintColor:btnTintColor];
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    for (int i = 0; i < _btnCount; i++)
    {
        UIButton *button = [self viewWithTag:i + 101];
        button.titleLabel.font = titleFont;
    }
}

//设置底部滑动条颜色
- (void)setSlideBarColor:(UIColor *)slideBarColor
{
    _slideBarColor = slideBarColor;
    _bottomLineView.backgroundColor = slideBarColor;
}


//滑动条的上偏移
- (void)setSlideBarOffSetH:(CGFloat)slideBarOffSetH
{
    if (_slideBarOffSetH == slideBarOffSetH)
    {
        return;
    }
    _slideBarOffSetH = slideBarOffSetH;
    CGRect tempFrame = self.bottomLineView.frame;
    tempFrame.origin.y = self.frame.size.height - self.bottomLineView.frame.size.height + slideBarOffSetH;
    self.bottomLineView.frame = tempFrame;
}

//设置分割条的宽度
- (void)setSplitWidth:(CGFloat)splitWidth
{
    if (_splitWidth == splitWidth)
    {
        return;
    }
    _splitWidth = splitWidth;
    
    if (splitWidth > 0 && splitWidth < self.frame.size.width / _btnCount / 2.0)
    {
        CGFloat btnWidth = self.frame.size.width / _btnCount;
        CGFloat splitMargin = (_splitMargin > 0) ? _splitMargin : 0;
        if (![self viewWithTag:2001])
        {
            for (int i = 1; i < _btnCount; i++)
            {
                UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(i * btnWidth - splitWidth / 2.0, splitMargin, splitWidth, self.frame.size.height - splitMargin * 2.0)];
                splitView.tag = 2000 + i;
                splitView.backgroundColor = _splitColor ? _splitColor : kSplitViewDefaultColor;
                [self addSubview:splitView];
            }
        }
        else
        {
            for (int i = 1; i < _btnCount; i++)
            {
                UIView *splitView = [self viewWithTag:2000 + i];
                splitView.frame = CGRectMake(i * btnWidth - splitWidth / 2.0, splitMargin, splitWidth, self.frame.size.height - splitMargin * 2.0);
            }
        }
    }
}

//设置分割条的边距
- (void)setSplitMargin:(CGFloat)splitMargin
{
    if (_splitMargin == splitMargin)
    {
        return;
    }
    _splitMargin = splitMargin;
    if (splitMargin > 0 && splitMargin < self.frame.size.height / 2.0)
    {
        CGFloat btnWidth = self.frame.size.width / _btnCount;
        CGFloat splitWidth = (_splitWidth > 0) ? _splitWidth : 1;
        if (![self viewWithTag:2001])
        {
            for (int i = 1; i < _btnCount; i++)
            {
                UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(i * btnWidth - splitWidth / 2.0, splitMargin, splitWidth, self.frame.size.height - splitMargin * 2.0)];
                splitView.tag = 2000 + i;
                splitView.backgroundColor = _splitColor ? _splitColor : kSplitViewDefaultColor;
                [self addSubview:splitView];
            }
        }
        else
        {
            for (int i = 1; i < _btnCount; i++)
            {
                UIView *splitView = [self viewWithTag:2000 + i];
                splitView.frame = CGRectMake(i * btnWidth - splitWidth / 2.0, splitMargin, splitWidth, self.frame.size.height - splitMargin * 2.0);
            }
        }
    }
}

//设置分割条的颜色
- (void)setSplitColor:(UIColor *)splitColor
{
    _splitColor = splitColor;
    if ([self viewWithTag:2001])
    {
        for (int i = 1; i < _btnCount; i++)
        {
            [self viewWithTag:2000 + i].backgroundColor = splitColor;
        }
    }
}

@end
