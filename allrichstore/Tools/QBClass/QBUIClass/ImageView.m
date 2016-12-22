//
//  ImageView.m
//  PRJ_CreditRecruit
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import "ImageView.h"

@implementation ImageView

//重写initWithFrame:方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake([QBGet getIntFloatByFloat:frame.origin.x], [QBGet getIntFloatByFloat:frame.origin.y], [QBGet getIntFloatByFloat:frame.size.width], [QBGet getIntFloatByFloat:frame.size.height])];
    if (self)
    {
        
    }
    return self;
}

//重写frame的setter方法
- (void)setFrame:(CGRect)frame
{
    [super setFrame:CGRectMake([QBGet getIntFloatByFloat:frame.origin.x], [QBGet getIntFloatByFloat:frame.origin.y], [QBGet getIntFloatByFloat:frame.size.width], [QBGet getIntFloatByFloat:frame.size.height])];
}

@end
