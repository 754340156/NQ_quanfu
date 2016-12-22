//
//  Person_TFCell.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/18.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "Person_TFCell.h"

#define kMargin_left_title  AdaptedWidth(10)
#define kFont_title         Font(16)
#define kColor_title        QF_BlackColor

#define kMargin_right_tf    AdaptedWidth(10)
#define kFont_tf            Font(16)
#define kColor_tf           kDarkGrayColor

#define kSpace_title_tf     AdaptedWidth(8)

@interface Person_TFCell ()

@end

@implementation Person_TFCell

//创建子视图
- (void)createViews
{
    self.bottomMargin = 0.0;
    
    self.titleLabel.font = kFont_title;
    _titleLabel.textColor = QF_BlackColor;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(kMargin);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset([_titleLabel getWidthWithText:@"用户等级"]);
        
    }];
    
    self.rightTF = [UITextField new];
    _rightTF.textAlignment = NSTextAlignmentRight;
    _rightTF.font = Font_Mid;
    _rightTF.textColor = kColor_tf;
    [self.contentView addSubview:_rightTF];
    [_rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_titleLabel.mas_right).offset(kMargin);
        make.top.offset(0);
        make.bottom.offset(0);
        make.right.offset(-kMargin);
        
    }];
}

- (void)configTitle:(NSString *)title tfText:(NSString *)tfText
{
    _titleLabel.text = title;
    _rightTF.text = tfText;
}

@end
