//
//  RefundDetailApplyPhotosView.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "RefundDetailApplyPhotosView.h"


@interface RefundDetailApplyPhotosView ()

@end

@implementation RefundDetailApplyPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setup];
        [self setLayout];
    }
    return self;
}
#pragma mark - setup
- (void)setup
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = Adapted(kMargin);
    flowLayout.minimumInteritemSpacing = Adapted(kMargin);
    flowLayout.itemSize = CGSizeMake(Adapted(kItemWidth), Adapted(kItemHeight));
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.bounces = NO;
    [self addSubview:self.collectionView];
}
- (void)setLayout
{
    UILabel *headerLabel  = [[UILabel alloc] init];
    [headerLabel sizeToFit];
    headerLabel.text = @"上传照片";
    headerLabel.font = Font_Mid;
    headerLabel.textColor = QF_BlackColor;
    [self addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(Adapted(kMargin));
        make.height.offset(Adapted(kMargin * 2));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerLabel.mas_left);
        make.top.equalTo(headerLabel.mas_bottom).offset(Adapted(kMargin));
        make.size.mas_offset(CGSizeMake(Adapted(kMargin * (singleLineCount + 1) + kItemWidth * singleLineCount), Adapted(kItemHeight)));
    }];
    
    UILabel *footerLabel  = [[UILabel alloc] init];
    [footerLabel sizeToFit];
    footerLabel.text = @"为了帮助我们更好的解决问题,请上传照片（最多5张）";
    footerLabel.font = Font_Min;
    footerLabel.textColor = QF_GrayColor;
    [self addSubview:footerLabel];
    [footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerLabel.mas_left);
        make.height.offset(Adapted(kMargin * 2));
        make.bottom.offset(Adapted(-kMargin));
        make.top.equalTo(self.collectionView.mas_bottom).offset(Adapted(kMargin));
    }];
}
#pragma mark - custom method

#pragma mark - handle action

#pragma mark - setter model

@end
