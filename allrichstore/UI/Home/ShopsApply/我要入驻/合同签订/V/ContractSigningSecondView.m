//
//  ContractSigningSecondView.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ContractSigningSecondView.h"

@interface ContractSigningSecondView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *scheduleBtn;

@end

@implementation ContractSigningSecondView

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
    [self.scheduleBtn setTitleColor:QF_RedColor forState:UIControlStateNormal];
}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model



@end
