//
//  TitleAndPromptCell.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/5.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "TitleAndPromptCell.h"

@interface TitleAndPromptCell()

@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIView  *lineView;

@end

static const CGFloat spaceWith=15;

@implementation TitleAndPromptCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置背影色
        self.backgroundColor=[UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (self.keyLabel == nil) {
            self.keyLabel = [[UILabel alloc] init];
            self.keyLabel.font = AdaptedFontSize(14);
            self.keyLabel.textColor = kLightGrayColor;
            [self.contentView addSubview:self.keyLabel];
            [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceWith);
                make.centerY.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(80, AdaptedHeight(15)));
            }];
        }
        
        if (self.valueLabel==nil) {
            self.valueLabel=[[UILabel alloc]init];
            self.valueLabel.textAlignment=NSTextAlignmentRight;
            self.valueLabel.font=AdaptedFontSize(14);
            self.valueLabel.textColor=kLightGrayColor;
            [self.contentView addSubview:self.valueLabel];
            [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(kScreenW-80-2*spaceWith, AdaptedHeight(18)));
            }];
        }
        
        if (self.lineView==nil) {
            self.lineView = [[UIView alloc] init];
            self.lineView.hidden=YES;
            self.lineView.backgroundColor = Color_CellSplitLine;
            [self.contentView addSubview:self.lineView];
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceWith);
                make.right.mas_equalTo(self).offset(0);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(@0.5);
            }];
        }
    }
    return self;
}


-(void)setCellDataKey:(NSString *)curkey curValue:(NSString *)curvalue blankValue:(NSString *)blankvalue isShowLine:(BOOL)showLine cellType:(TitleAndPromptCellType)cellType
{
    self.keyLabel.text=curkey;
    self.lineView.hidden=!showLine;
    if ([curvalue length]==0) {
        self.valueLabel.text=blankvalue;
        self.valueLabel.textColor=kLightGrayColor;
    }
    else
    {
        self.valueLabel.text=curvalue;
        self.valueLabel.textColor=BlackTextColor;
    }
    switch (cellType) {
        case TitleAndPromptCellTypeInput: {
            self.accessoryType = UITableViewCellAccessoryNone;
            [self.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(0);
                make.right.mas_equalTo(-2*spaceWith);
                make.size.mas_equalTo(CGSizeMake(kScreenW-80-2*spaceWith, AdaptedHeight(18)));
            }];
            [self.valueLabel layoutIfNeeded];
            break;
        }
        case TitleAndPromptCellTypeSelect: {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
