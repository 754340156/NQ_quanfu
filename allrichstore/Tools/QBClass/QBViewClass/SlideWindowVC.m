//
//  SlideWindowVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SlideWindowVC.h"

//动画的周期
#define kAnimationDuration  0.3

//半透明背景的颜色
#define kColor_transitionBg Color_transitionBg

//窗口默认的大小
#define kCenterType_windowViewRatio   (1 / 2.0)
#define kTopType_windowViewRatio      (1 / 3.0)
#define kBottomType_windowViewRatio   (1 / 3.0)
#define kLeftType_windowViewRatio     (3 / 4.0)
#define kRightType_windowViewRatio    (3 / 4.0)

@interface SlideWindowVC ()

@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, assign) CGRect initialRect;
@property (nonatomic, assign) CGRect showRect;

@end

@implementation SlideWindowVC

- (instancetype)initWithSlideType:(SlideType)slideType
{
    self = [super init];
    if (self)
    {
        _slideType = slideType;
        //设置模态类型，使视图模态之后能半透明
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        //设置模态类型，使视图模态之后能半透明
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //视图的背景
    self.view.backgroundColor = [UIColor clearColor];
    
    self.bgBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
    _bgBtn.backgroundColor = kColor_transitionBg;
    _bgBtn.enabled = NO;
    [_bgBtn addTarget:self action:@selector(handleBgBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bgBtn];
    
    //窗口视图
    self.windowView = [[UIView alloc] initWithFrame:self.view.bounds];
    _windowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _windowView.layer.shadowOpacity = 0.3f;
    _windowView.layer.shadowRadius = 3.f;
    _windowView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_windowView];
    
    //阴影
    CGSize shadowSize = CGSizeMake(0, 0);
    CGFloat windowWidth = 0;
    CGFloat windowHeight = 0;
    switch (_slideType)
    {
        case SlideTypeFromCenter:
        {
            windowWidth = (_windowViewWidth == 0) ? self.view.width * kCenterType_windowViewRatio : _windowViewWidth;
            windowHeight = (_windowViewHeight == 0) ? self.view.height * kCenterType_windowViewRatio : _windowViewHeight;
            _initialRect = CGRectMake((self.view.width - windowWidth * 2 / 3.0) / 2.0, (self.view.height - windowHeight * 2 / 3.0) / 2.0, windowWidth * 2 / 3.0, windowHeight * 2 / 3.0);
            _showRect = CGRectMake((self.view.width - windowWidth) / 2.0, (self.view.height - windowHeight) / 2.0, windowWidth, windowHeight);
        }
            break;
        case SlideTypeFromTop:
        {
            shadowSize = CGSizeMake(0, 4);
            windowWidth = self.view.width;
            windowHeight = (_windowViewHeight == 0) ? self.view.height * kTopType_windowViewRatio : _windowViewHeight;
            _initialRect = CGRectMake(0, -windowHeight, windowWidth, windowHeight);
            _showRect = CGRectMake(0, 0, windowWidth, windowHeight);
        }
            break;
        case SlideTypeFromBottom:
        {
            shadowSize = CGSizeMake(0, -4);
            windowWidth = self.view.width;
            windowHeight = (_windowViewHeight == 0) ? self.view.height * kBottomType_windowViewRatio : _windowViewHeight;
            _initialRect = CGRectMake(0, self.view.height, windowWidth, windowHeight);
            _showRect = CGRectMake(0, self.view.height - windowHeight, windowWidth, windowHeight);
        }
            break;
        case SlideTypeFromLeft:
        {
            shadowSize = CGSizeMake(4, 0);
            windowWidth = (_windowViewWidth == 0) ? self.view.width * kLeftType_windowViewRatio : _windowViewWidth;
            windowHeight = self.view.height;
            _initialRect = CGRectMake(-windowWidth, 0, windowWidth, windowHeight);
            _showRect = CGRectMake(0, 0, windowWidth, windowHeight);
        }
            break;
        case SlideTypeFromRight:
        {
            shadowSize = CGSizeMake(-4, 4);
            windowWidth = (_windowViewWidth == 0) ? self.view.width * kLeftType_windowViewRatio : _windowViewWidth;
            windowHeight = self.view.height;
            _initialRect = CGRectMake(self.view.width, 0, windowWidth, windowHeight);
            _showRect = CGRectMake(self.view.width - windowWidth, 0, windowWidth, windowHeight);
            
            UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(windowWidth, 0, 60, windowHeight)];
            subView.backgroundColor = [UIColor whiteColor];
            [_windowView addSubview:subView];
        }
            break;
        default:
            break;
    }
    
    _windowView.frame = _initialRect;
    _windowView.layer.shadowOffset = shadowSize;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showWindowView];  //展示筛选面板
}

//展示筛选面板
- (void)showWindowView
{
    [UIView animateWithDuration:kAnimationDuration delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:6 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        _windowView.frame = _showRect;
        _bgBtn.alpha = YES;
        
    } completion:^(BOOL finished) {

        _bgBtn.enabled = YES;
    }];
}

//消失筛选面板
- (void)dismissWindowViewCompletion:(void(^)())completion
{
    _bgBtn.enabled = NO;
    [UIView animateWithDuration:kAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _windowView.frame = _initialRect;
        _bgBtn.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        if (completion)
        {
            completion();
        }
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
}

//背景按钮触发事件
- (void)handleBgBtn:(UIButton *)sender
{
    //消失筛选面板
    [self dismissWindowViewCompletion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
