//
//  NoEventView.m
//  LiveTest
//
//  Created by 任强宾 on 16/9/19.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "NoEventView.h"

@implementation NoEventView

#pragma mark - override method
//重写initWithFrame:方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(ceil(frame.origin.x), ceil(frame.origin.y), floor(frame.size.width), floor(frame.size.height))];
    if (self)
    {
        
    }
    return self;
}

//重写frame的setter方法
- (void)setFrame:(CGRect)frame
{
    [super setFrame:CGRectMake(ceil(frame.origin.x), ceil(frame.origin.y), floor(frame.size.width), floor(frame.size.height))];
}

#pragma mark - custom method
//设置边框（可设置参数：宽度，颜色）
- (void)setRimWithBorderWidth:(CGFloat)borderWidth
                  borderColor:(UIColor *)borderColor
{
    //设置边框宽度
    self.layer.borderWidth = borderWidth;
    //设置边框颜色
    self.layer.borderColor = [borderColor CGColor];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self isMemberOfClass:[UIScrollView class]]) {
        
    } else {
        [[self nextResponder] touchesBegan:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesBegan:touches withEvent:event];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self isMemberOfClass:[UIScrollView class]]) {
        
    } else {
        [[self nextResponder] touchesMoved:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesMoved:touches withEvent:event];
        }
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self isMemberOfClass:[UIScrollView class]]) {
        
    } else {
        [[self nextResponder] touchesEnded:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesEnded:touches withEvent:event];
        }
    }
}


@end
