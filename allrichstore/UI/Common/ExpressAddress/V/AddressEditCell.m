//
//  AddressEditCell.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/23.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "AddressEditCell.h" //地址编辑cell

#define kMargin_level   Adapted(10)

@implementation AddressEditCell

#pragma mark - override super
//创建子视图
- (void)createViews
{
    self.isHaveSeleBgView = NO;
    self.contentView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightTF];
    [self.contentView addSubview:self.addressBtn];
    
    _titleLabel.font = LightAdaptedFont(17);
}

//布局子视图
- (void)layoutViews
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(kMargin_level);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset([_titleLabel getWidthWithText:@"联系电话"] + Adapted(30));
    }];
    
    [_rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel.mas_right);
        make.top.offset(0);
        make.bottom.offset(0);
        make.right.equalTo(_addressBtn.mas_left).offset(-kMargin_level);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-kMargin_level);
        make.centerY.offset(0);
        make.width.offset(_addressBtn.width);
    }];
}

#pragma mark - lazy
- (QButton *)addressBtn
{
    if (!_addressBtn)
    {
        self.addressBtn = [[QButton alloc] initWithFrame:CGRectMake(0, 0, Adapted(40), Adapted(30)) style:QButtonStyleNormal font:LightAdaptedFont(15) title:@"定位" image:Image(@"locAddress") space:Adapted(3) autoSize:YES];
    }
    return _addressBtn;
}

- (UITextField *)rightTF
{
    if (!_rightTF)
    {
        self.rightTF = [UITextField new];
        _rightTF.font = LightAdaptedFont(17);
        _rightTF.textColor = QF_GrayColor;
    }
    return _rightTF;
}

#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model

@end
