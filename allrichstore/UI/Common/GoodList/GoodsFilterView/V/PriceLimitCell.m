//
//  PriceLimitCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "PriceLimitCell.h"  //价格区间cell

#define PriceCellApadted(x)  Adapted(x)

//cell的背景颜色
#define kColor_Bg           [UIColor colorWithRed:240.0 / 255.0 green:242.0 / 255.0 blue:244.0 / 255.0 alpha:1.0]

//分隔条的背景颜色
#define kColor_SplitBg      [UIColor colorWithRed:200.0 / 255.0 green:200.0 / 255.0 blue:200.0 / 255.0 alpha:1.0]

//输入框的文字颜色
#define kColor_tfText       [UIColor colorWithWhite:0.2 alpha:1.0]

#define kMargin_tf_left     PriceCellApadted(12)   //输入框左右边距
#define kMargin_tf_top      PriceCellApadted(8)  //输入框上下边距

#define kWidth_splitWidth   PriceCellApadted(18)  //分割条的宽度
#define kHeight_splitHeight 2   //分割条的高度

#define kSpace_split_tf     PriceCellApadted(16)  //输入框和分隔条之间的间距

//输入框的高度
#define kHeight_tf   (self.contentView.height - 2 * kMargin_tf_top)
//输入框的宽度
#define kWidth_tf    (self.contentView.width - 2 * (kMargin_tf_left + kSpace_split_tf) - kWidth_splitWidth) / 2.0


@interface PriceLimitCell ()

@end

@implementation PriceLimitCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 3.0;
        self.contentView.backgroundColor = kColor_Bg;
        [self createViews]; //创建子视图
    }
    return self;
}

#pragma mark - override super
//创建子视图
- (void)createViews
{
    NSArray *placeholderArray = @[@"最低价", @"最高价"];
    CGFloat tfLeft = kMargin_tf_left;
    //创建子控件
    for (int i = 0; i < 2; i++)
    {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(tfLeft, kMargin_tf_top, kWidth_tf, kHeight_tf)];
        tf.backgroundColor = [UIColor whiteColor];
        tf.font = [UIFont systemFontOfSize:PriceCellApadted(18)];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.layer.masksToBounds = YES;
        tf.layer.cornerRadius = 3.0;
        tf.textAlignment = NSTextAlignmentCenter;
        tf.textColor = kColor_tfText;
        tf.placeholder = placeholderArray[i];
        
        if (i == 0)
        {
            self.leftTF = tf;
            //创建添加分隔条
            UIView *splitView = [UIView new];
            splitView.backgroundColor = kColor_SplitBg;
            splitView.size = CGSizeMake(kWidth_splitWidth, kHeight_splitHeight);
            splitView.center = CGPointMake(self.contentView.width / 2.0, self.contentView.height / 2.0);
            [self.contentView addSubview:splitView];
            tfLeft = splitView.right + kSpace_split_tf;
        }
        else
        {
            self.rightTF = tf;
        }
        [self.contentView addSubview:tf];
    }
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model

@end
