//
//  ChoiceGoodsTitleView.m
//  allrichstore
//
//  Created by zhaozhe on 16/10/31.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "ChoiceGoodsTitleView.h"

@interface ChoiceGoodsTitleView ()
/**  所有的btn */
@property(nonatomic,strong) NSMutableArray * btnsArr;
@end


@implementation ChoiceGoodsTitleView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame TitlesArr:( NSArray<NSString *> * _Nonnull )titleArr IsScroll:(BOOL)isScroll contentSize:(CGSize )contentSize
{
    if (self = [super initWithFrame:frame]) {
        self.contentSize = contentSize;
        [self setupWithTitlesArr:titleArr IsScroll:isScroll];
    }
    return self;
}
#pragma mark - setup
- (void)setupWithTitlesArr:(NSArray<NSString *> *)titleArr IsScroll:(BOOL)isScroll
{
    self.scrollEnabled = isScroll;
    CGFloat width = self.width / titleArr.count;
    for (NSInteger i = 0; i < titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * width, 0, width, self.height);
        btn.titleLabel.font = Font_Mid;
        [btn setTitleColor:QF_GrayColor forState:UIControlStateNormal];
        [btn setTitleColor:QF_RedColor forState:UIControlStateSelected];
        i != 0 ? :(btn.selected = YES);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.btnsArr addObject:btn];
    }
}
#pragma mark - target
- (void)btnAction:(UIButton *)sender
{
    for (UIButton *btn in self.btnsArr) {
        if ([sender isEqual:btn]) {
            sender.selected = YES;
            if (self.titleDelegate && [self.titleDelegate respondsToSelector:@selector(ChoiceGoodsTitleViewDelegate_clickBtn:)]) {
                [self.titleDelegate ChoiceGoodsTitleViewDelegate_clickBtn:sender];
            }
        }else
        {
            btn.selected = NO;
        }
    }
}
#pragma mark - lazy
- (NSMutableArray *)btnsArr
{
    if (!_btnsArr) {
        _btnsArr  = [NSMutableArray array];
    }
    return _btnsArr;
}
@end
