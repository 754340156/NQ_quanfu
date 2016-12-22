//
//  SA_BaseTextField.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SA_BaseTextField.h"

@implementation SA_BaseTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    [self setLayout];
}
#pragma mark - setup
- (void)setup
{
    [self addLeftLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    
}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model



@end
