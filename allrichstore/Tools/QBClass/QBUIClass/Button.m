//
//  Button.m
//  PRJ_CreditRecruit
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import "Button.h"

@implementation Button


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

@end
