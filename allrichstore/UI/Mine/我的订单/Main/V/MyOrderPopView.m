//
//  MyOrderPopView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderPopView.h"
#define kButtonViewH 60.0f
@interface MyOrderPopView ()<ButtonsViewDelegate>
/**  popView */
@property(nonatomic,strong) ButtonsView * buttonsView;
/**  保存title数组 */
@property(nonatomic,strong) NSArray * titleArray;
/**  保存的图片数组 */
@property(nonatomic,strong) NSArray * imageArray;
/**  保存图片选中数组 */
@property(nonatomic,strong) NSArray * seletedImageA;
@end

@implementation MyOrderPopView

- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray SeletedImageA:(NSArray *)seletedImageA
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_Translucent;
        self.imageArray = imageArray;
        self.titleArray = titleArray;
        self.seletedImageA = seletedImageA;
        [self setupWithTitleArray:titleArray];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setupWithTitleArray:(NSArray *)titleArray
{
    [self addSubview:self.buttonsView];
}
- (void)setLayout
{
    
}
#pragma mark - custom method
- (void)show
{
    [UIView animateWithDuration:0.2 animations:^{
        self.buttonsView.layer.transform = CATransform3DMakeTranslation(0, Adapted(kButtonViewH * 2) , 0);
        self.backgroundColor = Color_Translucent;
    } completion:^(BOOL finished) {
        self.height = kScreenH - TopBarHeight;
    }];
}
- (void)hidden
{
    [UIView animateWithDuration:0.2 animations:^{
        self.buttonsView.layer.transform = CATransform3DIdentity;
        self.backgroundColor = kClearColor;
    } completion:^(BOOL finished) {
        self.height = 0;
    }];
}
#pragma mark - handle action
#pragma mark - ButtonsViewDelegate
- (void)btsView:(ButtonsView *)btnView IsClicked:(UIButton *)btn atIndex:(NSInteger)index isRepeatTouch:(BOOL)isRepeatTouch
{

    for (UIButton *button in self.buttonsView.btns) {
        button.selected = NO;
    }
    btn.selected = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyOrderPopViewDelegate_clickWithButton:)]) {
        [self.delegate MyOrderPopViewDelegate_clickWithButton:(QButton *)btn];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyOrderPopViewDelegate_clickPopView)]) {
        [self.delegate MyOrderPopViewDelegate_clickPopView];
    }
}
#pragma mark - setter model
- (NSArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSArray array];
    }
    return _imageArray;
}
- (NSArray *)seletedImageA
{
    if (!_seletedImageA) {
        _seletedImageA = [NSArray array];
    }
    return _seletedImageA;
}
- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}
- (ButtonsView *)buttonsView
{
    if (!_buttonsView) {
        _buttonsView = [[ButtonsView alloc] initWithFrame:CGRectMake(0, Adapted(-kButtonViewH * 2), self.width, Adapted(kButtonViewH)) btnTitles:self.titleArray titleColor:QF_GrayColor selectedColor:QF_RedColor titleFont:Font_Min];
        _buttonsView.backgroundColor = kWhiteColor;
        _buttonsView.delegate = self;
        for (NSInteger i = 0 ; i < _buttonsView.btns.count; i++) {
            QButton *button  = _buttonsView.btns[i];
            button.style = QButtonStyleImageTop;
            button.space = 5.0f;
            [button setImage:Image(self.imageArray[i]) forState:UIControlStateNormal];
            [button setImage:Image(self.seletedImageA[i]) forState:UIControlStateSelected];
        }
    }
    return _buttonsView;
}

@end
