//
//  ShopsApplyPaymentView.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopsApplyPaymentView.h"

@interface ShopsApplyPaymentView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ShopsApplyPaymentView
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    [self setLayout];
}

#pragma mark - setup
- (void)setup
{
    self.scrollView.backgroundColor = QFColor_CoodsClassMenuViewBg;
}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model


@end
