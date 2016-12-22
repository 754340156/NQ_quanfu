//
//  NewBrandView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/29.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "NewBrandView.h"

@interface NewBrandView ()
/**  scrollView */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**  图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**  品牌中文名 */
@property (weak, nonatomic) IBOutlet UITextField *chinaNameTF;
/**  品牌英文名 */
@property (weak, nonatomic) IBOutlet UITextField *englishNameTF;
/**  品牌首字母 */
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
/**  品牌商标注册人 */
@property (weak, nonatomic) IBOutlet UILabel *personLabel;
/**  品牌商标注册号 */
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
/**  上传品牌LOGO */
@property (weak, nonatomic) IBOutlet UIButton *logoBtn;
/**  上传产品外包装图 */
@property (weak, nonatomic) IBOutlet UIButton *productBtn;
/**  有效期 */
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
/**  上传图片 */
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
/**  保存品牌 */
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end


@implementation NewBrandView

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
    
    [self.logoBtn setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
    [self.productBtn setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
    [self.photoBtn setImage:Image(@"shangchuantupian") forState:UIControlStateNormal];
    [self.timeBtn setImage:Image(@"rili") forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:QF_RedColor forState:UIControlStateNormal];
}
- (void)setLayout
{
    
}
#pragma mark - custom method

#pragma mark - handle action
- (IBAction)saveAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(NewBrandViewDelegate_clickSave)]) {
        [self.delegate NewBrandViewDelegate_clickSave];
    }
}

#pragma mark - setter model


@end
