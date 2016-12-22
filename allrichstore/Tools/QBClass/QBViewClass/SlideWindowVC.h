//
//  SlideWindowVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SlideType)
{
    SlideTypeFromCenter = 0,
    SlideTypeFromTop,
    SlideTypeFromLeft,
    SlideTypeFromBottom,
    SlideTypeFromRight
};

@interface SlideWindowVC : UIViewController
{
    SlideType _slideType;
    UIView *_windowView;
}

@property (nonatomic, assign) SlideType slideType;
@property (nonatomic, strong) UIView *windowView;
@property (nonatomic, assign) CGFloat windowViewWidth;
@property (nonatomic, assign) CGFloat windowViewHeight;

- (instancetype)initWithSlideType:(SlideType)slideType;
//消失筛选面板
- (void)dismissWindowViewCompletion:(void(^)())completion;

@end
