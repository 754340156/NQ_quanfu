//
//  CodeButton.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/8.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "CodeButton.h"

@implementation CodeButton

/**
 添加相应事件
 */
-(void)addToucheHandler:(TouchedDownBlock)touchHandler
{
    _touchedDownBlock = [touchHandler copy];
     [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touched:(CodeButton *)sender
{
    if (_touchedDownBlock) {
        _touchedDownBlock(sender,sender.tag);
    }
}

/**
 设置时长
 
 @param totalSecond 60
 */
-(void)startWithSecond:(int)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    self.enabled = NO;
    _timer = [[NSTimer alloc] initWithFireDate:[NSDate new] interval:1.0 target:self selector:@selector(timerStart:)  userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerStart:(NSTimer *)timer
{

        double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
        _second = _totalSecond - (int)(deltaTime+0.5) ;
        if (_second< 0.0)
        {
            [self stop];
        }
        else
        {
            if (_didChangeBlock)
            {
                [self setTitle:_didChangeBlock(self,_second) forState:UIControlStateNormal];
                [self setTitle:_didChangeBlock(self,_second) forState:UIControlStateDisabled];
            }
            else
            {
                NSString *title = [NSString stringWithFormat:@"%d秒",_second];
                [self setTitle:title forState:UIControlStateNormal];
                [self setTitle:title forState:UIControlStateDisabled];
            }
        }
}


/**
 停止计算
 */
- (void)stop
{
    if (_timer)
    {
        if ([_timer respondsToSelector:@selector(isValid)])
        {
            if ([_timer isValid])
            {
                [_timer invalidate];
                _second = _totalSecond;
                if (_didFinishedBlock)
                {
                    [self setTitle:_didFinishedBlock(self,_totalSecond)forState:UIControlStateNormal];
                    [self setTitle:_didFinishedBlock(self,_totalSecond)forState:UIControlStateDisabled];
                }else{
                    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                    [self setTitle:@"获取验证码" forState:UIControlStateDisabled];
                }
            }
        }
    }
    
    self.enabled = YES;
}

/**
 点击button变化的时候
 
 @param didChangeBlock 回调时间
 */
-(void)didChange:(DidChangeBlock)didChangeBlock
{
    _didChangeBlock = [didChangeBlock copy];
}

/**
 当时间截止时候
 
 @param didFinishedBlock 计算秒数停止
 */
-(void)didFinished:(DidFinishedBlock)didFinishedBlock
{
    _didFinishedBlock = [didFinishedBlock copy];
}

@end
