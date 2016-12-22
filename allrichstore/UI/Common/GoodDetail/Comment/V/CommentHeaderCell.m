//
//  CommentHeaderCell.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/3.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "CommentHeaderCell.h"
//左右间距
static CGFloat margin = 10.0f;
//一行4个
static NSInteger count = 4;
@interface CommentHeaderCell ()
/**  button数组 */
@property(nonatomic,strong) NSMutableArray * buttonArray;
@end


@implementation CommentHeaderCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    [self addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
}

//布局子视图
- (void)layoutViews
{
    
}

#pragma mark - custom method
- (void)setButtonWithArray:(NSArray *)array
{
    
    __block NSInteger index = 0;
    CGFloat width = (kScreenW - 2 * count * margin) / count;
    [array enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:QF_GrayColor forState:UIControlStateNormal];
        [button setTitleColor:QF_RedColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderColor = QF_GrayColor.CGColor;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 0.5;
        button.layer.cornerRadius = Adapted(5);
        button.titleLabel.font = Font_Min;
        
        if (idx % count == 0) {
            index = 0;
        }else
        {
            index++;
        }
        
        button.frame = CGRectMake(Adapted(margin) + index * (Adapted(margin * 2) + width) , Adapted(margin) + (idx / count) * Adapted(25 + margin) , width, Adapted(25));
        [obj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [button setTitle:[NSString stringWithFormat:@"%@（%@）",key,obj]  forState:UIControlStateNormal];
            if ([key isEqualToString:@"全部"]) {
                button.selected = YES;
                button.layer.borderColor = QF_RedColor.CGColor;
            }
        }];
        [self.buttonArray addObject:button];
        [self.contentView addSubview:button];
    }];
}
#pragma mark - handle action

- (void)btnAction:(UIButton *)sender
{
   __block NSInteger index = 0;
    sender.selected = YES;
    sender.layer.borderColor = QF_RedColor.CGColor;
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isEqual:sender]) {
            obj.selected = NO;
            obj.layer.borderColor = QF_GrayColor.CGColor;
        }else
        {
            index = idx;
        }
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(CommentHeaderCellDelegate_clickButtonWithButton:Index:)]) {
        [self.delegate CommentHeaderCellDelegate_clickButtonWithButton:sender Index:index];
    }
}
#pragma mark - setter model

- (void)setBtnArray:(NSArray *)btnArray
{
    _btnArray = btnArray;
    [self setButtonWithArray:btnArray];
}
- (NSMutableArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
@end
