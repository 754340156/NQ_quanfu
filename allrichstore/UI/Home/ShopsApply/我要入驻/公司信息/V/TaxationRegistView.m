//
//  TaxationRegistView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "TaxationRegistView.h"

@interface TaxationRegistView ()
/**  scrollView */
@property(nonatomic,strong) IBOutlet UIScrollView * scrollView;
/**  上面图片 */
@property(nonatomic,strong) IBOutlet UIImageView * imageView;
/**  下一步 */
@property(nonatomic,strong) IBOutlet UIButton * nextButton;
@end

@implementation TaxationRegistView

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
    [self.nextButton setBackgroundColor:QF_RedColor];
    [self.button1 setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
    [self.button2 setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
    [self.button3 setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action
- (IBAction)PhotosAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TaxationRegistViewDelegate_clickPhotosWithButton:)]) {
        [self.delegate TaxationRegistViewDelegate_clickPhotosWithButton:sender];
    }
}
- (IBAction)NextAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(TaxationRegistViewDelegate_clickNext)]) {
        [self.delegate TaxationRegistViewDelegate_clickNext];
    }
}

#pragma mark - setter model


@end
