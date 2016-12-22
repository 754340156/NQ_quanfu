//
//  LBHeaderView.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/16.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "LBHeaderView.h"

//label的文字颜色
#define kColor_labelText    QF_BlackColor
//label的字体
#define kFont_labelText     AdaptedFont(19)
//按钮标题的字体
#define kFont_btnTitle      AdaptedFont(16)

//水平内距
#define kInsetLevel         Adapted(12)

//按钮的宽度
#define kWidth_btn          Adapted(100)

@implementation LBHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createViews]; //创建子视图
    }
    return self;
}

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(kInsetLevel, 0, self.width - kWidth_btn - kInsetLevel, self.height)];
    _label.textColor = kColor_labelText;
    _label.font = kFont_labelText;
    _label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_label];
    
    self.btn = [[QButton alloc] initWithFrame:CGRectMake(_label.right, 0, kWidth_btn, self.height) style:QButtonStyleImageRight layoutStyle:QButtonLayoutStyleRight font:kFont_btnTitle title:nil image:Image(@"pulldownMenuHeader_Normal") space:2.0 margin:kInsetLevel autoSize:NO];
    [_btn setImage:Image(@"pulldownMenuHeader_Selected") forState:UIControlStateSelected];
    [_btn addTarget:self action:@selector(handleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
}

#pragma mark - custom method

#pragma mark - handle action
//按钮的触发事件
- (void)handleBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
}


#pragma mark - setter model



@end
