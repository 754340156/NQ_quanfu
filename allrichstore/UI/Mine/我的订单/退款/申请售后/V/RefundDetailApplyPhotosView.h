//
//  RefundDetailApplyPhotosView.h
//  allrichstore
//
//  Created by zhaozhe on 16/11/18.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import <UIKit/UIKit.h>
//初始化0
#define kPhotosViewH(x) Adapted(kMargin * 8) + (x + 1) * Adapted(kItemHeight) + x * Adapted(kMargin)
#define kItemWidth 90.0f
#define kItemHeight 60.0f
//一行的数量
#define singleLineCount 3
//最多上传
#define maxCount 5
@interface RefundDetailApplyPhotosView : UIView
/**  collection */
@property(nonatomic,strong) UICollectionView  * collectionView;

@end
