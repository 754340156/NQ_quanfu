//
//  RefundDetailApplyScrollView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/17.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RefundDetailApplyScrollView.h"
#import "RefundDetailApplyModel.h"
@interface RefundDetailApplyScrollView ()

@end


@implementation RefundDetailApplyScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    self.headerView = [[RefundDetailApplyHeaderView alloc] init];
    [self addSubview:self.headerView];
    
    self.typeView = [[RefundDetailApplyTypeView alloc] init];
    [self addSubview:self.typeView];
    
    self.countView = [[RefundDetailApplyCountView alloc] init];
    [self addSubview:self.countView];
    
    self.descriptionView = [[RefundDetailApplyDescriptionView alloc] init];
    [self addSubview:self.descriptionView];
    
    self.photosView = [[RefundDetailApplyPhotosView alloc] init];
    [self addSubview:self.photosView];
}
- (void)setLayout
{
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.size.mas_offset(CGSizeMake(kScreenW, Adapted(kHeaderHeight)));
    }];
    
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.headerView.mas_bottom).offset(Adapted(kMargin / 2));
        make.height.offset(Adapted(kTypeViewH));
    }];
    
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.typeView.mas_bottom).offset(Adapted(kMargin / 2));
        make.height.offset(Adapted(kCountViewH));
    }];
    
    [self.descriptionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.countView.mas_bottom).offset(Adapted(kMargin / 2));
        make.height.offset(Adapted(kDescriptionViewH));
    }];
    
    [self.photosView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.descriptionView.mas_bottom).offset(Adapted(kMargin / 2));
        make.height.offset(Adapted(kPhotosViewH(0)));
        make.bottom.offset(Adapted(-kMargin * 3));
    }];
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model
- (void)setModel:(RefundDetailApplyModel *)model
{
    _model = model;
    self.headerView.model = model;
    self.typeView.model = model;
    [self.typeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(model.typeHeight);
    }];
}

@end
