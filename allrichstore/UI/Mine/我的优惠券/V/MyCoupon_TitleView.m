//
//  MyCoupon_TitleView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCoupon_TitleView.h"

@interface MyCoupon_TitleView ()
/**  记录的当前的数组 */
@property(nonatomic,strong) NSArray * dataArray;
/**  红线 */
@property(nonatomic,strong) UIView * lineView;
/**  装button的数组 */
@property(nonatomic,strong) NSMutableArray * buttonArray;
@end


@implementation MyCoupon_TitleView

- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = QF_RedColor;
        self.lineView.height = 2.0f;
        self.lineView.top = self.height - self.lineView.height;
        [self addSubview:self.lineView];
        
        [self setupWithTitleArray:titleArray];
    }
    return self;
}
#pragma mark - setup 
- (void)setupWithTitleArray:(NSArray *)titleArray
{
    if (titleArray) {
        self.dataArray = titleArray;
    }
    CGFloat width = kScreenW /  self.dataArray.count;
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(width * i, 0, width, self.height);
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:QF_GrayColor forState:UIControlStateNormal];
        [btn setTitleColor:QF_RedColor forState:UIControlStateSelected];
        btn.titleLabel.font = Font_Mid;
        [btn setTitle:self.dataArray[i] forState:UIControlStateNormal];
        [self addSubview:btn];
        //默认点击了第一个按钮
        if (i == 0) {
            btn.selected = YES;
            self.lineView.width = [UILabel getWidthWithFont:Font_Mid text:self.dataArray[i]];
            self.lineView.centerX = btn.centerX;
        }
    }
    

}
#pragma mark - target
- (void)clickAction:(UIButton *)sender
{
    
    WS(weakSelf)
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyCoupon_TitleViewDelegate_clickIndex:)]) {
        for (UIView *view in self.subviews) {
            if (![view isKindOfClass:[UIButton class]]) continue;
            UIButton *btn = (UIButton *)view;
            if ([btn isEqual:sender]) {
                btn.selected = YES;
                [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([btn.titleLabel.text isEqualToString:obj]) {
                        [weakSelf.delegate MyCoupon_TitleViewDelegate_clickIndex:idx];
                    }
                }];
                //动画
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.lineView.centerX = sender.centerX;
                    weakSelf.lineView.width = [UILabel getWidthWithFont:Font_Mid text:btn.titleLabel.text];
                }];
            }else
            {
                btn.selected = NO;
            }
        }
    }
    

}
/**  点击一下按钮 */
- (void)MyCoupon_TitleViewClickWithIndex:(NSInteger)index
{
    WS(weakSelf)
    for (UIView *view in self.subviews) {
        
        if (![view isKindOfClass:[UIButton class]]) continue;
        UIButton *btn = (UIButton *)view;
        if ([btn.titleLabel.text isEqualToString:self.dataArray[index]]) {
            btn.selected = YES;
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.lineView.centerX = btn.centerX;
                weakSelf.lineView.width = [UILabel getWidthWithFont:Font_Mid text:btn.titleLabel.text];
            }];
        }else
        {
            btn.selected = NO;
        }
}

}
/**  设置指定index的title */
- (void)UpdateTitleWithIndex:(NSInteger )index Title:(NSString *)title
{
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            UIButton *button = self.buttonArray[index];
            [button setTitle:title forState:UIControlStateNormal];
        }
    }];
}
#pragma mark - lazy
- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[String(@"未使用"),String(@"已过期"),String(@"已使用")];
    }
    return _dataArray;
}
- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
@end
