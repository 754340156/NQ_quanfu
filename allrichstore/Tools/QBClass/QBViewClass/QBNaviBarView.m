//
//  QBNaviBarView.m
//  PRJ_CreditRecruit
//
//  Created by 任强宾 on 16/5/17.
//  Copyright © 2016年 河南维创盈通科技有限公司. All rights reserved.
//

#import "QBNaviBarView.h"

@implementation QBNaviBarView

//初始化方法
- (instancetype)initWithStatusBarColor:(UIColor *)statusBarColor
                          naviBarColor:(UIColor *)naviBarColor
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        //创建添加状态栏
        self.statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
        _statusBar.backgroundColor = statusBarColor;
        [self addSubview:_statusBar];
        
        //创建导航条
        self.naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, _statusBar.bottom, self.width, 44)];
        _naviBar.backgroundColor = naviBarColor;
        [self addSubview:_naviBar];
        
        //创建标题栏
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width / 4.0, 0, self.width / 2.0, _naviBar.height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        [_naviBar addSubview:_titleLabel];
    }
    return self;
}


@end
