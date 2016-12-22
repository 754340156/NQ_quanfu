//
//  MyCollectionTitleView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyCollectionTitleView.h"

@interface MyCollectionTitleView ()
/**  保存的数组 */
@property(nonatomic,strong) NSArray * titleArray;
@end


@implementation MyCollectionTitleView
- (instancetype)initWithTitleArray:(NSArray *)array Frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithTitleArray:array];
    }
    return self;
}
#pragma mark - setup
- (void)setupWithTitleArray:(NSArray *)array
{
    self.titleArray = array;
    CGFloat width = self.width / array.count;
    for (NSInteger i = 0; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = Font_Mid;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:QF_RedColor forState:UIControlStateSelected];
        [btn setTitleColor:QF_BlackColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(width * i, 0, width, self.height);
        [self addSubview:btn];
    }
}
#pragma mark - target
- (void)buttonAction:(UIButton *)sender
{
    WS(weakSelf)
    if (self.delegate && [self.delegate respondsToSelector:@selector(MyCollectionTitleViewDelegate_clickIndex:)]) {
        for (UIButton *btn in self.subviews) {
            if ([btn isEqual:sender]) {
                btn.selected = YES;
                [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([btn.titleLabel.text isEqualToString:obj]) {
                        [weakSelf.delegate MyCollectionTitleViewDelegate_clickIndex:idx];
                    }
                }];
            }else
            {
                btn.selected = NO;
            }
        }
    }
}
/**  点击一下按钮 */
- (void)MyCollectionTitleViewClickWithIndex:(NSInteger)index
{
    for (UIButton *sender in self.subviews) {
        if ([sender.titleLabel.text isEqualToString:self.titleArray[index]]) {
            sender.selected = YES;
        }else
        {
            sender.selected = NO;
        }
    }
}
#pragma mark - lazy
- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}
@end
