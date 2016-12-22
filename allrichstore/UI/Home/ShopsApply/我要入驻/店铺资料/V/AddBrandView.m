//
//  AddBrandView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AddBrandView.h"

@interface AddBrandView ()
/**  scrollView */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**  图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**  添加品牌按钮 */
@property (weak, nonatomic) IBOutlet UIButton *addBrandBtn;
/**  提交按钮 */
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation AddBrandView
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
    
    [self.addBrandBtn setBackgroundImage:Image(@"anniu_xiao") forState:UIControlStateNormal];
    [self.submitBtn setBackgroundColor:QF_RedColor];
}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action
//添加按钮
- (IBAction)addBrandAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(AddBrandViewDelegate_clickAddBrand)]) {
        [self.delegate AddBrandViewDelegate_clickAddBrand];
    }
}

- (IBAction)submitAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(AddBrandViewDelegate_clickSubmit)]) {
        [self.delegate AddBrandViewDelegate_clickSubmit];
    }
}
#pragma mark - setter model


@end
