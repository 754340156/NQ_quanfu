//
//  QBSwitchView.m
//  LiveTest
//
//  Created by 任强宾 on 16/9/1.
//  Copyright © 2016年 NeiQuan. All rights reserved.
//

#import "QBSwitchView.h"

@interface QBSwitchView ()
{
    UIColor *_onBackColor;
    UIColor *_offBackColor;
    UIColor *_onFrontColor;
    UIColor *_offFrontColor;
    CGFloat _lineWidth;
}
@end

@implementation QBSwitchView

- (instancetype)initWithFrame:(CGRect)frame
                  onBackColor:(UIColor *)onBackColor
                 offBackColor:(UIColor *)offBackColor
                 onFrontColor:(UIColor *)onFrontColor
                offFrontColor:(UIColor *)offFrontColor
                    lineWidth:(CGFloat )lineWidth
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _onBackColor = onBackColor;
        _offBackColor = offBackColor;
        _onFrontColor = onFrontColor;
        _offFrontColor = offFrontColor;
        _lineWidth = lineWidth;
        self.backgroundColor = offBackColor;
        self.ballView = [[UIView alloc] initWithFrame:CGRectMake(lineWidth, lineWidth, frame.size.width - lineWidth * 2, frame.size.height - lineWidth * 2)];
        _ballView.backgroundColor = offFrontColor;
        [self addSubview:_ballView];
    }
    return self;
}

- (void)switchOn
{
    self.backgroundColor = _onBackColor;
    self.ballView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - self.frame.size.height + _lineWidth, _lineWidth, self.frame.size.height - _lineWidth * 2, self.frame.size.height - _lineWidth * 2)];
    _ballView.backgroundColor = _onFrontColor;
}

- (void)switchOff
{
    self.backgroundColor = _offBackColor;
    self.ballView = [[UIView alloc] initWithFrame:CGRectMake(_lineWidth, _lineWidth, self.frame.size.height - _lineWidth * 2, self.frame.size.height - _lineWidth * 2)];
    _ballView.backgroundColor = _offFrontColor;
}

@end
