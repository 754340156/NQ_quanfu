//
//  NewBrandHomeView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "NewBrandHomeView.h"

@interface NewBrandHomeView ()
/**  scrollView */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**  图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**  品牌名称 */
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
/**  商标注册人 */
@property (weak, nonatomic) IBOutlet UITextField *personTF;
/**  检索 */
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

/**  直接提交品牌信息 */
@property (weak, nonatomic) IBOutlet UIButton *submitBrand;
/**  没有检索到品牌信息 */
@property (weak, nonatomic) IBOutlet UILabel *noBrandLabel;
/**  更新约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@end

@implementation NewBrandHomeView
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
    self.noBrandLabel.userInteractionEnabled = YES;
    
    [self.searchBtn setBackgroundColor:QF_RedColor];
    self.searchBtn.layer.cornerRadius = Layout_cornerRadius;
    self.searchBtn.layer.masksToBounds = YES;
    
    [self.submitBrand setTitleColor:QF_RedColor forState:UIControlStateNormal];
}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action
//检索
- (IBAction)searchAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(NewBrandHomeViewDelegate_clickSearchWithFinish:)]) {
        [self.delegate NewBrandHomeViewDelegate_clickSearchWithFinish:^(NSInteger arrayCount) {
            //更新约束
            self.tableViewHeight.constant = arrayCount * kBottomH;
            [self.tableView reloadData];
            [self layoutIfNeeded];
        }];
    }
}
//直接提交品牌信息
- (IBAction)submitBrandAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(NewBrandHomeViewDelegate_clickSubmit)]) {
        [self.delegate NewBrandHomeViewDelegate_clickSubmit];
    }
}
//没有检索到
- (IBAction)NoSearchAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(NewBrandHomeViewDelegate_clickNoSearch)]) {
        [self.delegate NewBrandHomeViewDelegate_clickNoSearch];
    }
}
#pragma mark - setter model


@end
