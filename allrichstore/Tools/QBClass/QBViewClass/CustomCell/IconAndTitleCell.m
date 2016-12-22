//
//  IconAndTitleCell.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/5.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "IconAndTitleCell.h"

@interface IconAndTitleCell()

@property (nonatomic, strong) UIButton *imageBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView  *lineView;

@end

static const CGFloat left_Space=15;
static const CGFloat kIconSize=25;

@implementation IconAndTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        [self layoutView];
    }
    return self;
}

- (void)layoutView
{
    if (self.imageBtn == nil) {
        self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:self.imageBtn];
        [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left_Space);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(AdaptedWidth(kIconSize), AdaptedHeight(kIconSize)));
        }];
    }
    
    if (self.titleLabel==nil) {
        self.titleLabel=[[UILabel alloc]init];
        self.titleLabel.font= Font_SizeOf(16);
        
        self.titleLabel.textColor = RGBOF(0x333333);
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageBtn.mas_right).offset(15);
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(AdaptedHeight(20));
        }];
    }
    
    if (self.lineView == nil) {
        self.lineView = [[UIView alloc]init];
        self.lineView.hidden = YES;
        self.lineView.backgroundColor = Color_CellSplitLine;
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.offset(0);
            make.height.offset(0.5);
        }];
    }
}

- (void)configCellIconName:(NSString *)iconName cellTitle:(NSString *)cellTitle showLine:(BOOL)isShowLine
{
    [self.imageBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    self.titleLabel.text = cellTitle;
    self.lineView.hidden =! isShowLine;
}

@end
