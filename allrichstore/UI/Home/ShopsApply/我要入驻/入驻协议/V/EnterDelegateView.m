//
//  EnterDelegateView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "EnterDelegateView.h"
@interface EnterDelegateView ()
/**  同意协议按钮 */
@property(nonatomic,strong) IBOutlet UIButton * agreeButton;
/**  scrollView */
@property(nonatomic,strong) IBOutlet UIScrollView * scrollView;
/**  上面图片 */
@property(nonatomic,strong) IBOutlet UIImageView * imageView;
/**  下面按钮 */
@property(nonatomic,strong) IBOutlet UIButton * nextButton;
@end

@implementation EnterDelegateView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.scrollView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self setup];
    [self setLayout];
}
#pragma mark - setup
- (void)setup
{
    [self.nextButton setBackgroundImage:[UIImage imageWithColor:QF_RedColor] forState:UIControlStateNormal];
    [self.nextButton setBackgroundImage:[UIImage imageWithColor:kLightGrayColor] forState:UIControlStateDisabled];
    
    [self.agreeButton setImage:Image(@"xuanze_weixuan") forState:UIControlStateNormal];
    [self.agreeButton setImage:Image(@"xuanze_yixuan") forState:UIControlStateSelected];
    self.agreeButton.selected = YES;
}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action
- (IBAction) agreeAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.nextButton.enabled = YES;
    }else
    {
        self.nextButton.enabled = NO;
    }
}
- (IBAction)applyAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(EnterDelegateViewDelegate_clickApply)]) {
        [self.delegate EnterDelegateViewDelegate_clickApply];
    }
}
#pragma mark - setter model

@end
