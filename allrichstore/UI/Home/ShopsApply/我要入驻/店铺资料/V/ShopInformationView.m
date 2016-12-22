//
//  ShopInformationView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ShopInformationView.h"
@interface ShopInformationView ()
/**  scrollView */
@property(nonatomic,strong) IBOutlet UIScrollView * scrollView;
/**  上面图片 */
@property(nonatomic,strong) IBOutlet UIImageView * imageView;
/**  下一步 */
@property(nonatomic,strong) IBOutlet UIButton * nextButton;
/**  添加经营项目 */
@property (weak, nonatomic) IBOutlet UIButton *addClassBtn;
/**  height */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewheight;

/**  有效期 */
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
/**  有效期label */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ShopInformationView
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    [self setLayout];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableViewHeight:) name:kTableViewHeightNotification object:nil];
}
#pragma mark - setup
- (void)setup
{
    self.scrollView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.nextButton setBackgroundColor:QF_RedColor];
    [self.addClassBtn setBackgroundColor:QF_RedColor];
    self.addClassBtn.layer.cornerRadius = Layout_cornerRadius;
    self.addClassBtn.layer.masksToBounds = YES;
    [self.photoBtn setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
    [self.timeBtn setImage:Image(@"rili") forState:UIControlStateNormal];
}
- (void)setLayout
{
    
}
#pragma mark - custom method
//更新约束
- (void)updateTableViewHeight:(NSNotification *)noti
{
    self.tableViewheight.constant =  ([(NSNumber *)noti.object integerValue] + 1) * kBottomH;
    [self layoutIfNeeded];
}
#pragma mark - handle action
//点击添加经营类目
- (IBAction)addClassAction:(UIButton *)sender 
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ShopInformationViewDelegate_clickAddClass)]) {
        [self.delegate ShopInformationViewDelegate_clickAddClass];

    }
}
//上传图片
- (IBAction)photoAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ShopInformationViewDelegate_clickPhotosWithButton:)]) {
        [self.delegate ShopInformationViewDelegate_clickPhotosWithButton:sender];
    }
}
//有效期
- (IBAction)timeAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ShopInformationViewDelegate_clickTimeWithLabel:)]) {
        [self.delegate ShopInformationViewDelegate_clickTimeWithLabel:self.timeLabel];
    }
}
//下一步
- (IBAction)nextAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(ShopInformationViewDelegate_clickNext)]) {
        [self.delegate ShopInformationViewDelegate_clickNext];
        
    }
}

#pragma mark - setter model
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
