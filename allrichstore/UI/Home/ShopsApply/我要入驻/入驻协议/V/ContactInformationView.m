//
//  ContactInformationView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/28.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ContactInformationView.h"
#define kExistButtonSize CGSizeMake(50, 30)
@interface ContactInformationView ()
/**  scrollView */
@property(nonatomic,strong) IBOutlet UIScrollView * scrollView;
/**  上面图片 */
@property(nonatomic,strong) IBOutlet UIImageView * imageView;
/**  下面按钮 */
@property(nonatomic,strong) IBOutlet UIButton * nextButton;
/**  姓名 */
@property(nonatomic,strong) IBOutlet UITextField * nameTF;
/**  手机 */
@property(nonatomic,strong) IBOutlet UITextField * phoneTF;
/**  邮箱 */
@property(nonatomic,strong) IBOutlet UITextField * emailTF;
/**  地址 */
@property(nonatomic,strong) IBOutlet UITextField * addressTF;
/**  邮编 */
@property(nonatomic,strong) IBOutlet UITextField * zipCodeTF;
/**  有 */
@property(nonatomic,strong) IBOutlet QButton * existButton;
/**  无 */
@property(nonatomic,strong) IBOutlet QButton * noExistButton;
/**  输入招商人员姓名 */
@property(nonatomic,strong) IBOutlet UITextField * innerTF;
@end


@implementation ContactInformationView

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
    [self setButtonWithButton:self.noExistButton Title:@"无"];
    [self setButtonWithButton:self.existButton Title:@"有"];
    self.existButton.selected = YES;
}
- (void)setLayout
{
 
}
#pragma mark - custom method
- (void)setButtonWithButton:(QButton *)button Title:(NSString *)title
{
    button.space = 10.0f;
    [button setImage:Image(@"weixuanze_yuan") forState:UIControlStateNormal];
    [button setImage:Image(@"xuanze_yuan") forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [button setTitleColor:QF_BlackColor forState:UIControlStateSelected];
}
#pragma mark - handle action
- (IBAction)nextAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ContactInformationViewDelegate_clickNext)]) {
        [self.delegate ContactInformationViewDelegate_clickNext];
    }
}
- (IBAction)existAction:(QButton *)sender
{
    self.noExistButton.selected = NO;
    self.existButton.selected = YES;
    self.innerTF.userInteractionEnabled = YES;
}
- (IBAction)noExistAction:(QButton *)sender
{
    self.existButton.selected = NO;
    self.noExistButton.selected = YES;
    self.innerTF.userInteractionEnabled = NO;
}
#pragma mark - setter model


@end
