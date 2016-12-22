//
//  Person_PhotoCell.m
//  MeiYiQuan
//
//  Created by 任强宾 on 16/10/18.
//  Copyright © 2016年 任强宾. All rights reserved.
//

#import "Person_PhotoCell.h"

#define kMargin_left_title  AdaptedWidth(10)
#define kFont_title         Font(16)
#define kColor_title        QF_BlackColor

@interface Person_PhotoCell ()

@property (nonatomic, strong) UIButton *photoBtn;

@property (nonatomic, strong) UIView *photoBgView;

@end

@implementation Person_PhotoCell

//创建子视图
- (void)createViews
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.bottomMargin = 0.0;
    
    self.titleLabel.font = kFont_title;
    _titleLabel.textColor = kColor_title;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(kMargin);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(180);
        
    }];
    
    self.photoBgView = [UIView new];
    [self.contentView addSubview:_photoBgView];
    [_photoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.offset(0);
        make.top.offset(kMargin / 2);
        make.bottom.offset(-kMargin / 2);
        make.width.equalTo(_photoBgView.mas_height);
        
    }];
    
    self.photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _photoBtn.contentMode = UIViewContentModeCenter;
    _photoBtn.layer.masksToBounds = YES;
    _photoBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_photoBtn];
    [_photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(_photoBgView.mas_centerX).offset(0);
        make.top.offset(kMargin / 2);
        make.bottom.offset(-kMargin / 2);
        make.width.equalTo(_photoBtn.mas_height);
        
    }];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _photoBgView.layer.cornerRadius = _photoBgView.height / 2.0;
    _photoBtn.layer.cornerRadius = _photoBtn.height / 2.0;
}

#pragma mark - 赋值
- (void)configTitle:(NSString *)title imageUrl:(NSString *)imageUrl
{
    _titleLabel.text = title;
    [_photoBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:Image_PlaceHolder_Photo options:SDWebImageRetryFailed];
}

@end
