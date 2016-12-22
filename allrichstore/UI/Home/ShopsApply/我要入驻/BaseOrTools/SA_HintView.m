//
//  SA_HintView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/4.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "SA_HintView.h"

@interface SA_HintView ()
/**  back */
@property(nonatomic,strong) UIView * backView;
/**  title */
@property(nonatomic,strong) UILabel * titleLabel;
/**  是 */
@property(nonatomic,strong) UIButton * sureBtn;
/**  不是 */
@property(nonatomic,strong) UIButton * notSureBtn;
@end


@implementation SA_HintView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Color_Translucent;
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor = kWhiteColor;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 5.0f;
    self.backView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.alpha = 1;
    } completion:^(BOOL finished) {
        self.backView.alpha = 1;
    }];
    [self addSubview:self.backView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = Font_Max;
    self.titleLabel.textColor = QF_BlackColor;
    self.titleLabel.text = @"您是三证合一的企业吗";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel addBottomLineWithColor:Home_ListCell_Line_Color height:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self.backView addSubview:self.titleLabel];
    
    self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.titleLabel.font = Font_Max;
    [self.sureBtn setTitle: @"是" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self.sureBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.sureBtn];
    
    self.notSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.notSureBtn.titleLabel.font = Font_Max;
    [self.notSureBtn setTitle: @"不是" forState:UIControlStateNormal];
    [self.notSureBtn setTitleColor:QF_BlackColor forState:UIControlStateNormal];
    [self.notSureBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.notSureBtn addRightLineWithColor:Home_ListCell_Line_Color width:ListCell_Line_W_H style:LineLayoutStyleInside];
    [self.backView addSubview:self.notSureBtn];
}

- (void)setLayout
{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_offset(CGSizeMake(Adapted(290), Adapted(160)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.offset(Adapted(115));
    }];
    
    [self.notSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.width.offset(Adapted(145));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.notSureBtn.mas_right);
    }];
}
#pragma mark - handle action
- (void)buttonAction:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(SA_HintViewDelegate_ClickBtnWith:)]) {
        if ([sender isEqual:self.sureBtn]) {
            [self.delegate SA_HintViewDelegate_ClickBtnWith:YES];
        }else
        {
            [self.delegate SA_HintViewDelegate_ClickBtnWith:NO];
        }
    }
}
#pragma mark - setter model
- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    self.titleLabel.text = titleName;
}
- (void)setSure:(NSString *)sure
{
    _sure = sure;
    [self.sureBtn setTitle:sure forState:UIControlStateNormal];
}
- (void)setNotSure:(NSString *)notSure
{
    _notSure = notSure;
    [self.notSureBtn setTitle:notSure forState:UIControlStateNormal];
}
@end
