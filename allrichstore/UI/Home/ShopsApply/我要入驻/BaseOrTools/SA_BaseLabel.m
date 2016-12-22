//
//  SA_BaseLabel.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SA_BaseLabel.h"

@implementation SA_BaseLabel

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    [self setLayout];
}
#pragma mark - setup
- (void)setup
{
    self.textColor = QF_BlackColor;
}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model

@end
