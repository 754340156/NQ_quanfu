//
//  GoodsClassVC.h
//  allrichstore
//
//  Created by 任强宾 on 16/10/27.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "BaseVC.h"

//左侧折叠菜单的宽度
#define kFoldMenuView_Width     Adapted(90)

//右侧collection的cell的边距
#define kCollectionCell_Margin   Adapted(10)

//右侧collection的宽度
#define kCollectionView_Width   (kScreenW - kFoldMenuView_Width - 2 * kCollectionCell_Margin)

//右侧collection的cell的宽度
#define kCollectionCell_Width  (kCollectionView_Width) / 3.0

@interface GoodsClassVC : BaseVC

@end
